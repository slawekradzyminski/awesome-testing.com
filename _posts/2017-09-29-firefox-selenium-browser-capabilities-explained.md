---
title: Firefox Selenium Browser Capabilities explained
layout: post
permalink: /2017/09/firefox-selenium-browser-capabilities
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/firefox.jpg)

Two very important Firefox news related to Selenium were published recently:  
a) Selenium IDE will no longer be supported in Firefox
55+ ([source](https://seleniumhq.wordpress.com/2017/08/09/firefox-55-and-selenium-ide/))  
b) Headless mode is now available ([source](https://developer.mozilla.org/en-US/Firefox/Headless_mode))

First news isn't really that bad. Any time invested in IDE is basically wasted time, so I don't think there is too much
to worry.

Second news is exciting though. I already announced it before in
my [Headless Chrome](http://www.awesome-testing.com/2017/05/headless-testing-with-google-chrome.html) before, but now
it's live and ready to play with.

To be honest this post was meant to be about Headless Firefox, but upon testing it and using my code
from [Browser Capabilities explained](http://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)
post I realized it's no longer valid. Using Firefox Profiles is now deprecated. From now on we should rely on Browser
Capabilities and very familiar mechanism as the one already implemented for Chrome. The code changed very recently,
because even official Java example in [headless Firefox news](https://developer.mozilla.org/en-US/Firefox/Headless_mode)
is using deprecated methods.

Before I delve deeper into headless mode (which I'll publish this month) let me show new way of handling Firefox browser
in your test.

## Getting started with Gecko Driver

As you probably already know at first you need
to [download geckodriver](https://github.com/mozilla/geckodriver/releases). On Mac it can be done be very quickly
using [brew](https://brew.sh/index_pl.html).

{% highlight java %}
    private static final String MY_GECKO_PATH = "C:\\drivers\\geckodriver.exe";

    @BeforeTest
    public void setUp() {
        if (SystemUtils.IS_OS_WINDOWS) {
            System.setProperty("webdriver.gecko.driver", MY_GECKO_PATH);
        }
    }
{% endhighlight %}

Windows users have to also set gecko property (it's done automatically by brew on Mac).

## Using Firefox Browser Capabilities

Using Firefox browser capabilities looks exactly as in Chrome. I'm sure my readers are already very familiar with how I
handle capabilities. The code almost like copy/paste from my Chrome examples.

{% highlight java %}
    private static final String HOMEPAGE_KEY = "browser.startup.homepage";
    private static final String HOMEPAGE_VALUE = "www.google.pl";

    @Override
    public WebDriver newWebDriver() {
        return new FirefoxDriver(getFirefoxCapabilities());
    }

    private DesiredCapabilities getFirefoxCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.firefox();
        capabilities.setAcceptInsecureCerts(true);
        capabilities.setCapability(HOMEPAGE_KEY, HOMEPAGE_VALUE);
        capabilities.setCapability(FirefoxOptions.FIREFOX_OPTIONS, getFirefoxOptions());
        return capabilities;
    }

    private FirefoxOptions getFirefoxOptions() {
        FirefoxOptions options = new FirefoxOptions();
        options.setLogLevel(Level.WARNING);
        return options;
    }
{% endhighlight %}

Thankfully we no longer have to rely on flaky Firefox Profile solution. What's even better, especially comparing to
Chrome, is documentation. [GeckoDriver GitHub page](https://github.com/mozilla/geckodriver) have it covered very well. I
encourage you to take a look.

As usual I posted all the code from above in
my [GitHub Awesome Testing project](https://github.com/slawekradzyminski/AwesomeTesting/commit/e9c3470f8a7c2cebc962701b1cf901fe9766f54d).
