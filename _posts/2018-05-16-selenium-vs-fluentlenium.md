---
title: Selenium vs FluentLenium
layout: post
permalink: /2018/05/selenium-vs-fluentlenium
categories:
  - Selenium
tags:
  - selenium
  - fluentlenium 
---

![](/images/blog/fluentlenium.png)

All my previous posts labeled with [Selenium tag](https://www.awesome-testing.com/search/label/selenium)
featured [FluentLenium](http://fluentlenium.org/) syntax. Why? Even though I tried to answer it in FluentLenium focused
posts ([Introduction](https://www.awesome-testing.com/2016/01/introducing-fluentlenium-1.html) & [Waiting game](https://www.awesome-testing.com/2016/04/introducing-fluentlenium-2-selenium.html))
I never really did full comparison against Selenium. As you probably already figured out reading the title this post
will show how FluentLenium can help you write better, shorter and easier to maintain Selenium tests.

Just to be clear that we are on the same page: **FluentLenium is only Selenium extension, not alternative**. It's
important to keep in mind that it's still GUI automation with all it's flaws and difficulties. FluentLenium was designed
to mitigate these problems as shall be shown here.

Warning: this post is code rich.

## Selenium

I'm going to start with pure Selenium first. Let's say we want to automate the following scenario:

a) Search for 'public speaking' term on my blog. Make sure the search results page contains some posts.

b) Open first post and verify that it contains comment section.

I chose to verify comment section, because it's loaded dynamically by Blogger. As you shall see pure Selenium struggles
a bit with such elements and fancy waiting is required for test stability.

Our obvious first step is adding Selenium dependency into pom.xml. I'm using 3.9.1 version here:

{% highlight xml %}
         <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-chrome-driver</artifactId>
            <version>3.9.1</version>
        </dependency>

        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-firefox-driver</artifactId>
            <version>3.9.1</version>
        </dependency>

        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-java</artifactId>
            <version>3.9.1</version>
         </dependency>
{% endhighlight %}

We need some properties next. I'm writing those words on Windows so I have to define driver paths. Let's implement the
simplest possible class that handles it:

{% highlight java %}
public class MyProperties {

    private Properties properties;

    public MyProperties() {
        properties = loadProperties();
    }

    private static Properties loadProperties() {
        Properties properties = new Properties();
        try {
            properties.load(MyProperties.class.getResourceAsStream("/user.properties"));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return properties;
    }

    public String getProperty(String property) {
        return properties.getProperty(property);
    }
}
{% endhighlight %}

And next we need user.properties file in test resources folder:

{% highlight properties %}
my_chrome_path=C:\\drivers\\chromedriver.exe
my_gecko_path=C:\\drivers\\geckodriver.exe
{% endhighlight %}

So far so good. We are ready to start defining tests. Let's create a top level test class responsible for driver
handling first. It will be our baseline. Normally I don't include imports in my snippets, but this Apache Commons entry
is necessary for easy understanding of if in setUp() section. I have Mac with chrome driver system property already set
by Brew and this line ensures that it will work on it without any changes. I'm using JUnit btw.

{% highlight java %}
import static org.apache.commons.lang3.SystemUtils.IS_OS_WINDOWS;

public class SeleniumTest {

    protected static WebDriver driver;
    private MyProperties myProperties = new MyProperties();

    @Before
    public void setUp() {
        if (IS_OS_WINDOWS) {
            System.setProperty("webdriver.chrome.driver",
                               myProperties.getProperty("my_chrome_path"));
        }
        driver = new ChromeDriver();
    }

    @After
    public void tearDown() {
        driver.close();
    }
}
{% endhighlight %}

Now we need baseline for page objects. I don't want to load elements from @FindBy annotation every single time, so I'm
coding it on top level class.

{% highlight java %}
public class PageObject {
    protected WebDriver driver;

    public PageObject(WebDriver driver){
        this.driver = driver;
        PageFactory.initElements(driver, this);
    }
}
{% endhighlight %}

Framework is ready so we can implement our page objects. Main blog page is obvious place to begin. I'm adding two
methods, one to make sure we are indeed on correct page and the second one to use search functionality.

{% highlight java %}
public class MainPage extends PageObject {

    @FindBy(css = "input.gsc-input")
    private WebElement searchBar;

    @FindBy(css = "input.gsc-search-button")
    private WebElement searchButton;

    @FindBy(css = "h1")
    private WebElement post;

    public MainPage(WebDriver driver) {
        super(driver);
    }

    public void isInitialized() {
        assertThat(post.isDisplayed()).isTrue();
    }

    public SearchResultsPage searchFor(String searchTerm) {
        this.searchBar.clear();
        this.searchBar.sendKeys(searchTerm);
        this.searchButton.click();
        return new SearchResultsPage(driver);
    }

}
{% endhighlight %}

Next in flow is search results page. This time I'm adding two assertions (are we on correct page? are posts displayed?)
and method which clicks on first post title.

{% highlight java %}
public class SearchResultsPage extends PageObject {

    @FindBy(className = "status-msg-wrap")
    private WebElement searchOptionPanel;

    public SearchResultsPage(WebDriver driver) {
        super(driver);
    }

    public void isInitialized() {
        assertThat(searchOptionPanel.isDisplayed()).isTrue();
    }

    public void assertThatPostsAreDisplayed() {
        List<WebElement> postsTitles = driver.findElements(By.cssSelector("h1 a"));
        assertThat(postsTitles).size().isPositive();
    }

    public PostPage clickOnFirstPost() {
        List<WebElement> posts = driver.findElements(By.cssSelector("h1 a"));
        posts.get(0).click();

        return new PostPage(driver);
    }

}
{% endhighlight %}

And finally we are on post page. Comment section is not only in an iframe, but it also loads dynamically. In order to
handle it I had to implement fancy wait, which polls every 500 milliseconds maximum 10 times. Element is not there at
first, but we ignore NoSuchElementException and poll again.

{% highlight java %}
public class PostPage extends PageObject {

    @FindBy(id = "comment-editor")
    private WebElement commentsSection;

    public PostPage(WebDriver driver) {
        super(driver);
    }

    public void isInitialized() {
        assertThat(commentsSection.isDisplayed()).isTrue();
    }

    public void checkCommentsSectionPresence() {
        driver.switchTo().frame(commentsSection);
        wait.until(ExpectedConditions.presenceOfElementLocated(By.name("commentBody")));
    }

    private Wait<WebDriver> wait = new FluentWait<>(driver)
            .withTimeout(5, TimeUnit.SECONDS)
            .pollingEvery(500, TimeUnit.MILLISECONDS)
            .ignoring(NoSuchElementException.class)
            .withMessage("Oops, element didn't appear!");

}
{% endhighlight %}

Having all pieces implemented we can write a pure Selenium test.

{% highlight java %}
public class SearchTest extends SeleniumTest {

    private static final String BLOG = "https://www.awesome-testing.com";

    @Test
    public void shouldSuccessfullyFindPostAndDisplayCommentSection() {
        driver.get(BLOG);
        MainPage mainPage = new MainPage(driver);
        mainPage.isInitialized();

        SearchResultsPage searchResultsPage =  mainPage.searchFor("public speaking");
        searchResultsPage.isInitialized();
        searchResultsPage.assertThatPostsAreDisplayed();

        PostPage postPage = searchResultsPage.clickOnFirstPost();
        postPage.isInitialized();
        postPage.checkCommentsSectionPresence();
    }
}
{% endhighlight %}

## FluentLenium

Now we will write the same test using FluentLenium. Spoiler alert: it will be easier :)

As usual, we start with dependencies in pom.xml.

{% highlight xml %}
        <dependency>
            <groupId>org.fluentlenium</groupId>
            <artifactId>fluentlenium-core</artifactId>
            <version>3.5.1</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.fluentlenium</groupId>
            <artifactId>fluentlenium-assertj</artifactId>
            <version>3.5.1</version>
        </dependency>

        <dependency>
            <groupId>org.fluentlenium</groupId>
            <artifactId>fluentlenium-junit</artifactId>
            <version>3.5.1</version>
        </dependency>
{% endhighlight %}

Driver handling is already taken care of by FluentLenium (FluentTest class). I want my tests to work both on Windows and
Mac, so I'm adding a little extension. FluentLenium also allows to store driver names in human friendly way so I have
added driver=chrome property. MyProperties class can be found above.

{% highlight java %}
import static org.apache.commons.lang3.SystemUtils.IS_OS_WINDOWS;

public class FluentLeniumTest extends FluentTest {

    protected static WebDriver driver;
    private static MyProperties myProperties = new MyProperties();

    @BeforeClass
    public static void setUp() {
        if (IS_OS_WINDOWS) {
            System.setProperty("webdriver.chrome.driver",
                               myProperties.getProperty("my_chrome_path"));
        }
    }

    @Override
    public String getWebDriver() {
        return myProperties.getProperty("driver");
    }
}
{% endhighlight %}

In Selenium section I have implemented PageObject class for framework preparations. It isn't required in FluentLenium.
It's already handled by FluentPage class.

We can proceed to Page Object definition now. Let's start with Main Page. @PageUrl annotation is used to tell driver
where to go. newInstance() method creates new page object class and isAt() is used for 'am I on correct page?'
verification.

{% highlight java %}
@PageUrl("https://www.awesome-testing.com")
public class MainPage extends FluentPage {

    @FindBy(css = "input.gsc-input")
    private FluentWebElement searchBar;

    @FindBy(css = "input.gsc-search-button")
    private FluentWebElement searchButton;

    @FindBy(css = "h1")
    private FluentList<FluentWebElement> posts;

    @Override
    public void isAt() {
        assertThat(posts).hasSize().greaterThan(0);
    }

    public SearchResultsPage searchFor(String searchTerm) {
        searchBar.fill().with(searchTerm);
        searchButton.click();
        return newInstance(SearchResultsPage.class);
    }
}
{% endhighlight %}

Now search result page with similar methods. Please take a look into @FindBy support for lists. Such feature isn't
implemented in pure Selenium. It really helps to write easy to maintain code.

{% highlight java %}
public class SearchResultsPage extends FluentPage {

    @FindBy(className = "status-msg-wrap")
    private FluentWebElement searchOptionPanel;

    @FindBy(css = "h1 a")
    private FluentList<FluentWebElement> posts;

    @Override
    public void isAt() {
        assertThat(searchOptionPanel).isDisplayed();
    }

    public void assertThatPostsAreDisplayed() {
        assertThat(posts).hasSize().greaterThan(0);
    }

    public PostPage clickOnFirstPost() {
        posts.first().click();
        return newInstance(PostPage.class);
    }
}
{% endhighlight %}

Finally, post page. You can see how useful await() methods are. Instead of defining separate Wait object we can use
intuitive syntax. Also NoSuchElementExceptions are ignored by default. We have also very handy switchTo() method which
changes context into iframe.

{% highlight java %}
public class PostPage extends FluentPage {

    @FindBy(id = "comment-editor")
    private FluentWebElement commentsSection;

    @FindBy(name = "commentBody")
    private FluentWebElement commentBody;

    public void isAt() {
        assertThat(commentsSection).isDisplayed();
    }

    public void checkCommentsSectionPresence() {
        switchTo(commentsSection);
        await().atMost(5, TimeUnit.SECONDS).until(commentBody).displayed();
    }
}
{% endhighlight %}

Having all pieces ready let's take a look at our final creation - a FluentLenium test. @Page is pseudo injection - it
allow us to predefine pages used in test.

{% highlight java %}
public class SearchTest extends FluentLeniumTest {

    @Page
    private MainPage mainPage;

    @Page
    private SearchResultsPage searchResultsPage;

    @Page
    private PostPage postPage;

    @Test
    public void shouldSuccessfullySearchForPosts() {
        mainPage.go();
        mainPage.isAt();
        mainPage.searchFor("public speaking");

        searchResultsPage.isAt();
        searchResultsPage.assertThatPostsAreDisplayed();
        searchResultsPage.clickOnFirstPost();

        postPage.isAt();
        postPage.checkCommentsSectionPresence();
    }
}
{% endhighlight %}

## Conclusion

I'm engineer, and I'm not a fan of arguments about which approach is better. I can only suggest you try FluentLenium and
see how it works for you. Personally I'm a huge fan and I hope this post highlighted its features. Doesn't it?

As usual all code can be downloaded from by [GitHub page](https://github.com/slawekradzyminski/AwesomeTesting).
