---
title: Headless testing with Google Chrome
layout: post
permalink: /2017/05/headless-testing-with-google-chrome
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/suit-158820_1280.png)

Headless Testing means running a browser UI test without the graphical user interface, i.e. without the head. Such a
test requires a headless browser, which (according to [Wikipedia](https://en.wikipedia.org/wiki/Headless_browser))
provides automated control of a web page in an environment similar to popular web browsers, but are executed via a
command-line interface or using network communication. They are particularly useful for testing web pages as they are
able to render and understand HTML the same way a browser would, including styling elements such as page layout, colour,
font selection and execution of JavaScript and AJAX which are usually not available when using other testing methods.

Why would we want to execute UI tests in headless browser?

The main reason is continuous integration. We might not always have a display output (X-server) installed. For example
all unix systems (that usually act as enterprise CI servers) don't have it by default. Let's say you have Jenkins
installed on amazon EC2 ubuntu instance. In order to run UI tests there you
need [Xvfb installation + configuration](http://elementalselenium.com/tips/38-headless). Headless testing requires
browser only.

## Headless browsers overview

As for today [PhantomJS](https://github.com/ariya/phantomjs) is an unquestionable leader. Unfortunately the project has
more than 1800 open issues and its maintainer
has [just announced](https://groups.google.com/forum/#!topic/phantomjs/9aI5d-LDuNE) that he will no longer support it.
The main reason being:

> Headless Chrome is coming (...) I think people will switch to it, eventually. Chrome is faster and more stable than
> PhantomJS. And it doesn't eat memory like crazy.

Headless mode would be added into Google Chrome in [version 59](https://www.chromestatus.com/features/5678767817097216).

Firefox [is planning](https://bugzilla.mozilla.org/show_bug.cgi?id=1338004) to introduce it as well.

## Prerequisites for running headless tests on Chrome

I managed to run headless test on my Mac. Prerequisites require only two steps:

a) downloading [ChromeDriver 2.29](https://chromedriver.storage.googleapis.com/index.html?path=2.29/)  
b) downloading [Google Chrome 59](https://www.chromium.org/getting-involved/dev-channel) (beta currently)

## Demo in Java

As usual I prepared a demo on
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting/commit/7f13e2f5f8f2253ccfcd8c6bafd393661526a7e3).
It was a lot easier this time - I used example test
from [Selenium Waiting Game post](http://www.awesome-testing.com/2016/04/introducing-fluentlenium-2-selenium.html)and
Chrome Manipulation code
from [Browser Capabilities Explained post](http://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html).
I'm using [FluentLenium](http://fluentlenium.org/) syntax.

Turns out, all you need to do is add 'headless' option into Chrome BrowserCapabilites.

Test:

{% highlight java %}
public class HeadlessChromeTest extends HeadlessChromeConfig {

    private static final String URL = "https://resttesttest.com/";
    private static final String SUCCESS_TEXT = "HTTP 200 OK";

    private static final String AJAX_BUTTON_CSS = "#submitajax";
    private static final String ALERT_RESULT_CSS = ".alert-success";

    @Test
    public void ajaxCallTest() {
        goTo(URL);
        await().until(el(AJAX_BUTTON_CSS)).clickable();
        el(AJAX_BUTTON_CSS).click();
        await().atMost(5, TimeUnit.SECONDS).untilPredicate(ajaxCallCompleted);
        assertThat(el(ALERT_RESULT_CSS).text()).isEqualTo(SUCCESS_TEXT);
    }

    private Predicate<FluentControl> ajaxCallCompleted = fluent -> {
        final JavascriptExecutor driver = (JavascriptExecutor) getDriver();
        return (Boolean) driver
                .executeScript("return (window.jQuery != null) && (jQuery.active === 0);");
    };

}
{% endhighlight %}

ChromeDriver runner:

{% highlight java %}
public class HeadlessChromeConfig extends FluentTestNg {

    private static final String HEADLESS = "headless";

    @Override
    public WebDriver newWebDriver() {
        return new ChromeDriver(getChromeCapabilities());
    }

    private DesiredCapabilities getChromeCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.chrome();
        capabilities.setCapability(ChromeOptions.CAPABILITY, getChromeOptions());
        return capabilities;
    }

    private ChromeOptions getChromeOptions() {
        ChromeOptions options = new ChromeOptions();
        options.addArguments(getChromeSwitches());
        return options;
    }

    private List<String> getChromeSwitches() {
        List<String> chromeSwitches = new ArrayList<>();
        chromeSwitches.add(HEADLESS);
        return chromeSwitches;
    }

}
{% endhighlight %}

Try it on your own. You should see no GUI and the test should pass. Now comment out line 24 (adding 'headless' switch)
and you should see real Chrome.

All code from my technical posts is available and maintained on
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting). Check it out for more details and subscribe to
updates.  

**Update:** Headless Chrome doesn't work on Windows yet. Big thanks for [@rafalfusik](https://twitter.com/rafalfusik).
See link for details.

> **[@s\_radzyminski](https://twitter.com/s_radzyminski) [https://t.co/hW8x2l9vVW](https://t.co/hW8x2l9vVW)**
>
> **— rafalfusik (@rafalfusik) [May 7, 2017](https://twitter.com/rafalfusik/status/861151982379204608)**

**Update2:** Google Chrome Developer tools support
details - [article from official blog](https://developers.google.com/web/updates/2017/04/headless-chrome).
