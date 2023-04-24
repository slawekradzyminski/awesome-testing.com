---
title: Headless Browser Testing with Selenium
layout: post
permalink: /2019/04/headless-browser-testing-with-selenium
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/suit-158819_960_720.png)

A headless browser is a very popular term in the testing community which refers to a web browser running without
Graphical User Interface (GUI). A headless browser can access any website but unlike normal browsers (which you
currently use) nothing will appear on the screen. Everything is done on the backend side invisible to the user.

Recent popularity rise of such browsers led to the creation of a new term: headless testing. It is running a UI-based
browser test using a headless browser.

In this article, I'm going to explain when is it worth to use headless browser and what are the actual limitations. As
usual, I have also prepared a Java demo with 5 most popular headless browsers used with Selenium WebDriver - Chrome,
Firefox, HtmlUnit, PhantomJS, and JBrowser.

## Benefits of headless testing

Why do people use headless browsers?

a) Speed - since headless browsers don’t have a UI, they are faster than real browsers.

b) Dependencies - sometimes you don't have full access to test environment and headless browsers are much easier to
setup on Continuous Integration servers like Jenkins

c) Data extraction - if your task is to scrape some data from website headless browser would do it much faster

d) Performance monitoring - headless browsers are often used
to [measure the client-side performance](https://www.awesome-testing.com/2019/01/measuring-page-load-times-using-selenium.html)

e) Layout testing - headless browsers are useful when testing layout (for example
with [Galen framework](http://galenframework.com/)). You can even automate screen captures for layout checks

## Limitations of headless testing

When you should not use headless browsers?

a) Functional tests - your users are not using a headless browser. You need a real browser to provide real feedback.

b) Debugging - headless browsers are hard to debug. You can't visually follow your tests step by step.

## Demo introduction

This time demo will be done using pure Selenium which you can copy paste into your project. I'll reuse page objects
which have been fully introduced
in [Selenium vs FluentLenium post](https://www.awesome-testing.com/2018/05/selenium-vs-fluentlenium.html). In order to
keep this post at a reasonable length, I'll skip a few implementation details. Please refer to
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting/commit/9a2b73a3c65897c8140394c2588ad03878c0b522)
for details.

Each headless driver would run the following scenario:

1. Open [Awesome Testing blog](https://awesome-testing.com/)
2. Search for 'public speaking' term
3. Verify that something has been found
4. Click on the first found article
5. Verify the comments section is present in the article

Inheritance will be used to make this method available for each headless test.

{% highlight java %}
abstract class AbstractHeadlessTest {

    MyProperties myProperties = new MyProperties();

    void shouldSuccessfullyFindPostAndDisplayCommentsSection(WebDriver driver) {
        driver.get("https://www.awesome-testing.com");

        new MainPage(driver)
                .searchFor("public speaking")
                .assertThatPostsAreDisplayed()
                .clickOnFirstPost()
                .assertThatCommentSectionIsDisplayed();
    }
}
{% endhighlight %}

Just for reference here is how search method implementation looks like.

{% highlight java %}
    public SearchResultsPage searchFor(String searchTerm) {
        searchBar.clear();
        searchBar.sendKeys(searchTerm);
        searchButton.click();
        return new SearchResultsPage(driver);
    }
{% endhighlight %}

And final assertion...

{% highlight java %}
    public void assertThatCommentSectionIsDisplayed() {
        wait.until(ExpectedConditions.presenceOfElementLocated(By.id("comments")));
    }

    private Wait<WebDriver> wait = new FluentWait<>(driver)
            .withTimeout(Duration.ofSeconds(5))
            .pollingEvery(Duration.ofMillis(500))
            .ignoring(NoSuchElementException.class)
            .withMessage("Oops, element didn't appear!");
{% endhighlight %}

## Chrome

Google Chrome is perhaps the most popular headless browser. In order to use ChromeDriver, the following dependency is
required.

{% highlight xml %}
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-chrome-driver</artifactId>
            <version>3.141.59</version>
        </dependency>
{% endhighlight %}

Setup requires adding two chrome switches into Chrome options: `--headless, --disable-gpu`

{% highlight java %}
public class HeadlessChromeTest extends AbstractHeadlessTest {

    private WebDriver driver;

    @Before
    public void setUp() {
        System.setProperty("webdriver.chrome.driver",
                           myProperties.getProperty("my_chrome_path"));
        driver = new ChromeDriver(getChromeOptions());
    }

    private ChromeOptions getChromeOptions() {
        ChromeOptions options = new ChromeOptions();
        List<String> chromeSwitches = new ArrayList<>();
        chromeSwitches.add("--headless");
        chromeSwitches.add("--disable-gpu");
        options.addArguments(chromeSwitches);
        return options;
    }

    @Test
    public void chromeTest() {
        shouldSuccessfullyFindPostAndDisplayCommentsSection(driver);
    }

    @After
    public void tearDown() {
        driver.close();
    }

}
{% endhighlight %}

For details and FluentLenium example, please refer to
my [Headless Chrome](https://www.awesome-testing.com/2017/05/headless-testing-with-google-chrome.html) post.

## Firefox

Firefox browser doesn't require an introduction as well. In order to use FirefoxDriver, the following dependency is
required.

{% highlight xml %}
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-firefox-driver</artifactId>
            <version>3.141.59</version>
        </dependency>
{% endhighlight %}

Setup requires adding one argument into Firefox: `--headless`

{% highlight java %}
public class HeadlessFirefoxTest extends AbstractHeadlessTest {

    private WebDriver driver;

    @Before
    public void setUp() {
        System.setProperty("webdriver.gecko.driver",
                           myProperties.getProperty("my_gecko_path"));
        driver = new FirefoxDriver(getFirefoxOptions());
    }

    private FirefoxOptions getFirefoxOptions() {
        FirefoxOptions options = new FirefoxOptions();
        options.addArguments("--headless");
        return options;
    }

    @Test
    public void firefoxTest() {
        shouldSuccessfullyFindPostAndDisplayCommentsSection(driver);
    }

    @After
    public void tearDown() {
        driver.close();
    }

}
{% endhighlight %}

For details and FluentLenium example, please refer to
my[Headless Firefox](https://www.awesome-testing.com/2017/09/headless-testing-with-firefox.html)post.

## HtmlUnit

[HtmlUnitDriver](https://github.com/SeleniumHQ/htmlunit-driver) is a WebDriver compatible driver
for [HtmlUnit](http://htmlunit.sourceforge.net/) headless browser. This project is under SeleniumHQ organization so
there is no need to worry about maintenance efforts.

The following dependency is needed.

{% highlight xml %}
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>htmlunit-driver</artifactId>
            <version>2.34.0</version>
        </dependency>
{% endhighlight %}

HtmlUnitDriver doesn't require to install any browser or set a path to driver executable. It's the most lightweight
solution of all presented here. This test will work on every platform without any configuration efforts.

{% highlight java %}
public class HeadlessHtmlUnitTest extends AbstractHeadlessTest {

    private WebDriver driver;

    @Before
    public void setUp() {
        driver = new HtmlUnitDriver();
    }

    @Test
    public void htmlUnitTest() {
        shouldSuccessfullyFindPostAndDisplayCommentsSection(driver);
    }

    @After
    public void tearDown() {
        driver.close();
    }

}
{% endhighlight %}

## JBrowser

[jBrowserDriver](https://github.com/MachinePublishers/jBrowserDriver) is A programmable, embeddable web browser driver
compatible with the Selenium WebDriver spec. It has a few interesting features that I'd like to present in a separate
post one day. No spoilers though :)

The following dependency is required.

{% highlight xml %}
        <dependency>
            <groupId>com.machinepublishers</groupId>
            <artifactId>jbrowserdriver</artifactId>
            <version>1.0.1</version>
        </dependency>
{% endhighlight %}

Unfortunately, jBrowserDriver is the only driver which failed my test so I'm a bit worried about its stability. There
are also no guarantees that it will be supported in the long term. For example, it still doesn't work with Java 11.

{% highlight java %}
public class HeadlessJBrowserTest extends AbstractHeadlessTest {

    private WebDriver driver;

    @Before
    public void setUp() {
        driver = new JBrowserDriver(Settings.builder().
                timezone(Timezone.EUROPE_WARSAW).build());
    }

    @Test
    public void jBrowserTest() {
        shouldSuccessfullyFindPostAndDisplayCommentsSection(driver);
    }

    @After
    public void tearDown() {
        driver.close();
    }

}
{% endhighlight %}

## PhantomJS

[PhantomJS](http://phantomjs.org/) is no longer and I'm adding it only for reference. I can't see any reasons to use it
in 2019.

Dependency:

{% highlight xml %}
        <dependency>
            <groupId>com.codeborne</groupId>
            <artifactId>phantomjsdriver</artifactId>
            <version>1.4.4</version>
        </dependency>
{% endhighlight %}

And test...

{% highlight java %}
public class HeadlessPhantomJsTest extends AbstractHeadlessTest {

    private WebDriver driver;

    @Before
    public void setUp() {
        System.setProperty("phantomjs.binary.path",
                           myProperties.getProperty("my_phantom_path"));
        driver = new PhantomJSDriver();
    }

    @Test
    public void phantomJsTest() {
        shouldSuccessfullyFindPostAndDisplayCommentsSection(driver);
    }

    @After
    public void tearDown() {
        driver.close();
    }

}
{% endhighlight %}

## Summary

Headless browsers give us a few interesting benefits (speed being by far the most important), but you have to remember
about their limitations. There is no guarantee that website working perfectly with headless mode would work in a real
browser.

If you are about to start your journey with headless Selenium I recommend to use Chrome or Firefox. You can easily debug
any issues by commenting `--headless` switch and see actual browser behavior. For more experienced users I recommend
HtmlUnitDriver which we use a lot in [FluentLenium](https://github.com/FluentLenium/FluentLenium) project and can confirm
that it is a stable solution.
