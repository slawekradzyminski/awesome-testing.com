---
title: Selenium Page Object Pattern - how to handle common components?
layout: post
permalink: /2019/03/selenium-page-object-pattern-how-to
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/photo-1522542550221-31fd19575a2d.jpeg)

Page Object Pattern (POP) is probably the most widely adopted Selenium design pattern in the world. It has one very
simple principle: every action (method), field (page element) available for a user on a single page should be
implemented in one place (class). This class is popularly called Page Object.

Unfortunately, this overly simplified definition often causes confusion because it’s incomplete. In order to make it
more precise, we have to add that Page Object represents fields and methods available on this page exclusively. Every
piece of shared logic (header, footer, sidebars) should be stored in separate classes. Let’s call those shared elements
components from now on.

Imagine a very simple website that has multiple pages using a common template with certain components. All Page Objects
using this template should represent functionalities available only in non-shared space (see image below).

![](/images/blog/Screen%2BShot%2B2019-03-29%2Bat%2B17.20.17.png)

Page Object should cover only the orange section. Header, footer and sidebar should be implemented as separate entities
which can be accessed by each page class.

## Task definition

Now imagine you are a tester responsible for testing such a website from scratch. The project is new and promising so
every test design decision you make today can have a significant impact tomorrow, next year, and maybe even 10 years
from now. How would you do it?

To make things more realistic let’s also say that there is one page which doesn’t have a sidebar and we expect to create
more pages with various templates soon.

## Inheritance

The first and probably the most straightforward choice is inheritance. Inheritance is an important pillar of Object
Oriented Programming (OOP). It is the mechanism by which one class (called subclass) is allowed to inherit the
features (fields and methods) of another class (called superclass).

In order to use inheritance, we would create an abstract class containing every component.

{% highlight java %}
public abstract class TemplatePage {

    protected Header header = new Header();
    protected Sidebar sidebar = new Sidebar();
    protected Footer footer = new Footer();

}
{% endhighlight %}

Each of our pages would be a subclass extending TemplatePage with components actions available via inheritance.

{% highlight java %}
public class MainPage extends TemplatePage {

    public void logout() {
        header.clickLogout();
    }
}
{% endhighlight %}

## Composition

As usual, when it comes to development every problem can have multiple solutions. One of the alternatives is
composition. The composition is a "has-a" relationship. You do composition by having an instance of another class as a
field of your class, instead of inheriting it.

With inheritance, our code would most likely look similar to this simplified implementation.

{% highlight java %}
public class MainPage {

    private Header header;
    private Footer footer;
    private Sidebar sidebar;

    public MainPage() {
        this.footer = new Footer();
        this.sidebar = new Sidebar();
        this.header = new Header();
    }
    
    public void logout() {
        header.clickLogout();
    }

}
{% endhighlight %}

## Why is composition better than inheritance?

Having all that in mind, let's think which approach should we choose to complete a task defined in point 2?

If it was the year 2000 most likely inheritance approach would be much better. Unfortunately, modern websites can change
on an almost daily basis and having one core template class can be now considered obsolete.

Even when it comes to our task I have mentioned that one page doesn't have a sidebar. Should this page object extend
TemplatePage? Or should we create a separate template for this class? What if TemplatePage has multiple utility methods
we want to reuse? It would be tempting to rely on this single template forever. In reality with inheritance sooner or
later we end up with page objects having access to field/methods which shouldn't be there. That's a fundamental design
flaw.

Composition gives flexibility. Each page object has to have explicitly defined components it wants to rely on. We don't
have to worry about surplus code available just because we extend the superclass.

## Dependency Injection (DI)

Modern Java code relies mostly on composition with one very important tweak - Dependency Injection (DI). In software
engineering, dependency injection is a technique whereby one object (or static method) supplies the dependencies of
another object. A dependency is an object that can be used (a service).

Dependency Injection frameworks like Spring uses Java reflection to make our lives easier. We don't have to create every
object by ourselves. Instead, we can rely on an external library. This is how our MainPage will look like with DI.

{% highlight java %}
public class MainPage {

    @Inject
    private Header header;
    
    @Inject
    private Footer footer;
    
    @Inject
    private Sidebar sidebar;

    public MainPage() {
    }

    public void logout() {
        header.clickLogout();
    }

}
{% endhighlight %}

## Explaining FluentLenium component

This long introduction leads us slowly to my main point - FluentLenium component demonstration.

First of all fundamental POP support provided by Selenium - only Page Object elements can be found by @FindBy
annotation. They are not injected - we have to initialize them using initElements() method

{% highlight java %}
    public PageObject(WebDriver driver) {
        this.driver = driver;
        PageFactory.initElements(driver, this);
    }
{% endhighlight %}

Components handling has to be implemented by a test developer separately using inheritance or composition. This is
visualized below.

![](/images/blog/Screen%2BShot%2B2019-03-30%2Bat%2B16.42.07.png)

With [FluentLenium framework](https://fluentlenium.com/), life is much easier for a test developer. FluentLenium treats
custom Components in the same way as WebElements (wrapped by FluentWebElemet class) and injects them dynamically when
needed. This fixes the fundamental POP flaw described in point one. We can finally implement Page Object as full-page
visible for the customer perspective.

The image below shows the difference comparing to standard Selenium.

![](/images/blog/Screen%2BShot%2B2019-03-30%2Bat%2B21.47.28.png)

For those who prefer actual implementation here is Page Object example:

{% highlight java %}
@PageUrl("https://fluentlenium.com")
public class MainPage extends FluentPage {

    @FindBy(css = "div.sidebar")
    private Sidebar sidebar;

    @FindBy(css = "div.footer")
    private Footer footer;

    @FindBy(css = "nav")
    private Header header;

    @FindBy(className = "whats-fluentlenium")
    private FluentWebElement mainContent;

    public void assertThatPageIsLoaded() {
        assertThat(mainContent).isDisplayed();
    }

    public Header getHeader() {
        return header;
    }

}
{% endhighlight %}

## Demo

As usual, I have prepared a working demo for my readers. Complete code together with a working project can be found
on [my GitHub](https://github.com/slawekradzyminski/AwesomeTesting).

We are going to test [FluentLenium.com](https://fluentlenium.com/)website with the following header:

{% highlight java %}
public class Header extends FluentWebElement {

    @FindBy(css = "nav ul li:nth-of-type(1)")
    private FluentWebElement homeLink;

    @FindBy(css = "nav ul li:nth-of-type(2)")
    private FluentWebElement quickstartLink;

    @FindBy(css = "nav ul li:nth-of-type(5)")
    private FluentWebElement aboutLink;

    public Header(WebElement element, FluentControl control, ComponentInstantiator instantiator) {
        super(element, control, instantiator);
    }

    public MainPage clickHomeLink() {
        homeLink.click();
        return newInstance(MainPage.class);
    }

    public QuickStartPage clickQuickstartLink() {
        quickstartLink.click();
        return newInstance(QuickStartPage.class);
    }

    public AboutPage clickAboutLink() {
        aboutLink.click();
        return newInstance(AboutPage.class);
    }

}
{% endhighlight %}

Constructor implementation may seem a bit complicated, but it's automatically generated by IDE (like IntelliJ) when we
extend FluentWebElement class.

In order to use such component we only have to inject it by @FindBy annotation to any Page Object:

{% highlight java %}
@PageUrl("https://fluentlenium.com")
public class MainPage extends FluentPage {

    @FindBy(css = "div.sidebar")
    private Sidebar sidebar;

    @FindBy(css = "div.footer")
    private Footer footer;

    @FindBy(css = "nav")
    private Header header;

    @FindBy(className = "whats-fluentlenium")
    private FluentWebElement mainContent;

    public void assertThatPageIsLoaded() {
        assertThat(mainContent).isDisplayed();
    }

    public Header getHeader() {
        return header;
    }


{% endhighlight %}

And finally tests using FirefoxDriver() and Full HD resolution

{% highlight java %}
public class ComponentTest extends FluentTest {

    private static final Dimension FULL_HD = new Dimension(1920, 1080);

    @Page
    private QuickStartPage quickStartPage;

    @Page
    private MainPage mainPage;

    @Before
    public void setUp() {
        getDriver().manage().window().setSize(FULL_HD);
    }

    @Override
    public WebDriver newWebDriver() {
        return new FirefoxDriver();
    }

    @Test
    public void quickStartLink() {
        mainPage.go();
        mainPage.assertThatPageIsLoaded();

        mainPage.getHeader()
                .clickQuickstartLink()
                .assertThatPageIsLoaded();
    }

    @Test
    public void homeLink() {
        quickStartPage.go();
        quickStartPage.assertThatPageIsLoaded();

        quickStartPage.getHeader()
                .clickHomeLink()
                .assertThatPageIsLoaded();
    }

    @Test
    public void shouldShowSlawomir() {
        mainPage.go();
        mainPage.assertThatPageIsLoaded();

        mainPage.getHeader()
                .clickAboutLink()
                .assertThatPageIsLoaded()
                .verifySlawomirPresence();
    }

}
{% endhighlight %}

Please let me know if you have any questions.
