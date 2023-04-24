---
title: Headless testing with Firefox
layout: post
permalink: /2017/09/headless-testing-with-firefox
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/firefox.jpg)

Last week I wanted to show you how to run Selenium tests using headless Firefox. Unfortunately
my [Browser Capabilities](http://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)turned out
to be outdated so I opted for
correct [Firefox Selenium Browser Capabilities](http://www.awesome-testing.com/2017/09/firefox-selenium-browser-capabilities.html)
explanation instead.

It turned out that most of the work was done already and I just needed few minutes to run Firefox in headless mode. Here
is how I did it.

## Getting started - requirements

According to [official Mozilla guide](https://developer.mozilla.org/en-US/Firefox/Headless_mode)you need Firefox 55+ on
Linux and Firefox 56+ on Windows/Mac.

I'm currently using Windows, so I had to
download [Firefox 56 beta](https://www.mozilla.org/en-US/firefox/56.0beta/releasenotes/) first (stable version is 55).

## Headless Firefox configuration

My code from last week was almost sufficient. I only needed to add one option (--headless). Configuration is almost
identical as in [Chrome](http://www.awesome-testing.com/2017/05/headless-testing-with-google-chrome.html).

{% highlight java %}
    @Override
        public WebDriver newWebDriver() {
        return new FirefoxDriver(getFirefoxCapabilities());
    }

    private DesiredCapabilities getFirefoxCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.firefox();
        capabilities.setCapability(FirefoxOptions.FIREFOX_OPTIONS, getFirefoxOptions());
        return capabilities;
    }

    private FirefoxOptions getFirefoxOptions() {
        FirefoxOptions options = new FirefoxOptions();
        options.addArguments("--headless");
        return options;
    }
{% endhighlight %}

## Demo

As usual, I prepared quick demo for my readers. I run it few times in headless/non-headless mode on my local machine and
didn't observe any time differences. Still the main benefit of headless testing is ease of use on Unix machines. We
don't have to install xvfb and other tools related to graphic environment.

Demo is testing that only 5 posts is displayed on my homepage.

PageObject code:

{% highlight java %}
@PageUrl("http://www.awesome-testing.com")
public class AwesomeTestingPage extends FluentPage {

    @FindBy(css = "[alt='Awesome Testing']")
    private FluentWebElement logo;

    @FindBy(css = "h1.post-title")
    private FluentList<FluentWebElement> postTitle;

    @Override
    public void isAt() {
        await().atMost(5, TimeUnit.SECONDS).until(logo).displayed();
    }

    public void assertThatCorrectNumberOfPostsIsDisplayed(int numberOfPosts) {
        await().until(postTitle).displayed();
        assertThat(postTitle.size()).isEqualTo(numberOfPosts);
    }
}
{% endhighlight %}

Class in which I configure Firefox browser:

{% highlight java %}
public class FirefoxManipulator extends FluentTestNg {

    private static final String MY_GECKO_PATH = "C:\\drivers\\geckodriver.exe";

    @BeforeTest
    public void setUp() {
        if (SystemUtils.IS_OS_WINDOWS) {
            System.setProperty("webdriver.gecko.driver", MY_GECKO_PATH);
        }
    }

    @Override
    public WebDriver newWebDriver() {
        return new FirefoxDriver(getFirefoxCapabilities());
    }

    private DesiredCapabilities getFirefoxCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.firefox();
        capabilities.setCapability(FirefoxOptions.FIREFOX_OPTIONS, getFirefoxOptions());
        return capabilities;
    }

    private FirefoxOptions getFirefoxOptions() {
        FirefoxOptions options = new FirefoxOptions();
        options.addArguments("--headless");
        return options;
    }
}
{% endhighlight %}

Actual test code:

{% highlight java %}
public class HeadlessFirefoxDemoTest extends FirefoxManipulator {

    private static final int EXPECTED_NUMBER_OF_POSTS = 5;

    @Page
    private AwesomeTestingPage awesomeTestingPage;

    @Test
    public void correctNumberOfPostsShouldBeDisplayed() {
        goTo(awesomeTestingPage)
                .assertThatCorrectNumberOfPostsIsDisplayed(EXPECTED_NUMBER_OF_POSTS);
    }

}
{% endhighlight %}

As usual, I posted all the code from above in
my[GitHub Awesome Testing project](https://github.com/slawekradzyminski/AwesomeTesting).
