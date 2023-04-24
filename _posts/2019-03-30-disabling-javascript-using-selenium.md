---
title: Disabling JavaScript using Selenium
layout: post
permalink: /2019/03/disabling-javascript-using-selenium
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/pobrane2.png)

## Introduction

Some days ago I was looking for an easy way to disable JavaScript using chromedriver. It turned out to be surprisingly
hard and once again I had to find
proper [Chrome preference](https://src.chromium.org/viewvc/chrome/trunk/src/chrome/common/pref_names.cc?view=markup)in
the Chromium source code. If you ever wonder how to do something with your Chrome using Selenium I recommend my
own [Browser Capabilities explained](https://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)
post which has a lot of examples and links where to look for.

## Why is Javascript-disabled page worth testing?

Before we move on to Java demo let's wonder for a while: why do people disable JavaScript?

_a) Speed & Bandwidth_

Using Internet with an old computer and a slow connection is incredibly frustrating these days. You can try to throttle
bandwidth in your Chrome via Developer tools and try it yourself... For your responsibility.

_b) Usability & Accessibility_

Relying on javascript does not automatically mean the page is not accessible, although it makes it significantly harder
for disabled people. Imagine that content blind person wants to find is hidden behind three JS-invoked actions. Would it
be possible to access? Yes. Would it be usable? No.

_c) Security & Privacy_

Any website can use JavaScript to gather information about things you do (or did) during your browsing session and
upload them to an external server. That's enough reason for privacy-concerned people to disable it. JavaScript can also
be used for [XSS attacks](https://www.awesome-testing.com/2017/11/automate-your-xss-tests-with-selenium.html).

So, from the company perspective: why should we care and test our website with JavaScript disabled?

_a) SEO_

Perhaps the most important reason. If large chunks of your website rely on pure JavaScript chances are search-engines
will be ignoring it.

_b) Clients who disable JavaScript_

The number of people who disable JS is small... but is it negligent? Even if it's only 1% of our business can we ignore
that?

_c) Testing for graceful degradation of JavaScript_

Even if we decide that we don't support our site with JS disabled we should gracefully handle it. We can't leave our
users with a forever loading blank site. We have to present information that we don't support JS.

## Chrome

As I mentioned above I wasn't able to disable JavaScript in Chrome using any obvious methods (like setters etc.). I had
to pass a map of preferences with magic `profile.managed_default_content_settings.javascript`. I assume that the
code is easy to understand. For details please take a look at
my [Desired Capabilities explained](https://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)
post

{% highlight java %}
private static final String PREFS = "prefs";
private static final String JAVASCRIPT_SETTINGS = "profile.managed_default_content_settings.javascript";
private static final short DISABLED = 2;

    @Override
    public WebDriver newWebDriver() {
        return new ChromeDriver(getChromeOptions());
    }

    private ChromeOptions getChromeOptions() {
        ChromeOptions options = new ChromeOptions();
        options.setExperimentalOption(PREFS, getChromePrefs());
        return options;
    }

    private Map<String, Object> getChromePrefs() {
        Map<String, Object> chromePrefs = new HashMap<>();
        chromePrefs.put(JAVASCRIPT_SETTINGS, DISABLED);
        return chromePrefs;
    }

{% endhighlight %}

The test is pretty straightforward. We go to main Facebook page and wait until URL is updated with `?_fb_noscript=1`
.This is how FB detects users who have disabled JS.

I'm using [FluentLenium](https://github.com/FluentLenium/FluentLenium/) syntax.

{% highlight java %}
private static final String FACEBOOK_NO_JS_URL = "https://www.facebook.com/?_fb_noscript=1";

    @Page
    private FacebookMainPage facebookMainPage;

    @Test
    public void checkJsDisabled() {
        facebookMainPage.go();
        waitForFacebookNoJsUrlAppender();
    }

    private void waitForFacebookNoJsUrlAppender() {
        await().atMost(2, TimeUnit.SECONDS).until(
                () -> getDriver().getCurrentUrl().equals(FACEBOOK_NO_JS_URL));
    }

{% endhighlight %}

## Firefox

Firefox setup is much easier. Only one flag has to be set to false: _javascript.enabled_.

{% highlight java %}
private static final String JAVASCRIPT_ENABLED = "javascript.enabled";

    @Override
    public WebDriver newWebDriver() {
        return new FirefoxDriver(getFirefoxOptions());
    }

    private FirefoxOptions getFirefoxOptions() {
        FirefoxOptions options = new FirefoxOptions();
        options.addPreference(JAVASCRIPT_ENABLED, false);
        return options;
    }

{% endhighlight %}

The complete code can be found on
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting/commit/68cdb2c98a8282e8b48d79fcbcc8ced3b12def92).

Image credit: [tomthedev](https://tomthedev.com/blog-page/is-there-a-life-without-javascript)
