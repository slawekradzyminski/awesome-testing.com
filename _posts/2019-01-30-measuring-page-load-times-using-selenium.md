---
title: Measuring page load times using Selenium
layout: post
permalink: /2019/01/measuring-page-load-times-using-selenium
categories:
  - Selenium
tags:
  - selenium performance testing 
---

![](/images/blog/kisscc0-computer-icons-performance-indicator-drawing-bench-performance-by-cyberang3l-5b74ed3ee8fa74.5190956615343895669543.png)

## Introduction

It seems like you really liked my latest post
about [console errors verification](https://www.awesome-testing.com/2019/01/adding-console-error-log-verification.html).
Today I'd like to share another useful extension for your Selenium scripts - page load time measurements. Performance
category is slightly underrepresented so far (only one post
about [Google Lighthouse](https://www.awesome-testing.com/2018/03/five-minutes-performance-report-with.html)) so it's a
perfect opportunity to change it.

By the way since my last post about Lighthouse using this tool has become even easier. You can run it online on
a[dedicated page](https://web.dev/measure). It also helps to optimize your page in SEO domain, for example by
suggesting [meta description](https://github.com/FluentLenium/FluentLenium/pull/687).

## Performance Timing interface

Two weeks ago I mentioned that w3c standardization regarding Selenium logging interface progresses rather slowly. This
time the story is totally different. We have nicely
documented[PerformanceTiming interface](https://www.w3.org/TR/navigation-timing/#sec-navigation-timing-interface)which
seems to be the implemented in every browser (I tested Chrome, Firefox, and Edge).

There's even an image which visualizes each metric:

![](/images/blog/timing-overview.png)

As you probably know deciding what to measure is crucial for effective performance testing so I suggest you to read it
the standard carefully. For my demo I'll use only two metrics:

**navigationStart** - This attribute must return the time immediately after the user agent
finishes [prompting to unload](http://www.w3.org/TR/html5/browsers.html#prompt-to-unload-a-document) the previous
document. If there is no previous document, this attribute must return the same value
as [fetchStart](https://www.w3.org/TR/navigation-timing/#dom-performancetiming-fetchstart).

**loadEventEnd** - This attribute must return the time when the load event of the current document is completed. It must
return zero when the load event is not fired or is not completed.

You can access each of those metrics via browser console. Just start typing _window.performance.timing._

![](/images/blog/perfapi.png)

## Demo

As usual, I'm going to [FluentLenium](https://github.com/FluentLenium/FluentLenium)in my demo. It's Selenium extension
with few [additional features](https://fluentlenium.com/).

Let's use different browser this time - Microsoft Edge. Here is a simple driver setup.

{% highlight java %}
    private static final String MY_EDGEDRIVER_PATH = "C:\\drivers\\MicrosoftWebDriver.exe";

    @Override
    public WebDriver newWebDriver() {
        System.setProperty("webdriver.edge.driver", MY_EDGEDRIVER_PATH);
        return new EdgeDriver();
    }
{% endhighlight %}

We may decide to measure different events at some points so let's make their setup easy and extendable in a separate
PerformanceEvent enum.

{% highlight java %}
public enum PerformanceEvent {

    LOAD_EVENT_END ("loadEventEnd"),
    NAVIGATION_START ("navigationStart");

    private final String event;

    PerformanceEvent(String event) {
        this.event = event;
    }

    @Override
    public String toString() {
        return this.event;
    }
}
{% endhighlight %}

So how do we access performance timing metrics in Selenium script? We only need to execute simple javascript and return
its value (as long). Method gets PerformanceEvent enum value as a parameter.

{% highlight java %}
    private long getEventValue(PerformanceEvent event) {
        String script = String.format("return window.performance.timing.%s;", event);
        return executeScript(script).getLongResult();
    }
{% endhighlight %}

Now let's move to the most interesting part for every tester - actual Junit implementation. We want to display loading
time in seconds on screen and assert that it isn't greater than 3 seconds.

{% highlight java %}
    @Test
    public void loadTimeTest() {
        goTo(awesomeTestingPage);
        long loadEventEnd = getEventValue(LOAD_EVENT_END);
        long navigationStart = getEventValue(NAVIGATION_START);

        assertThat(getLoadTimeInSeconds(loadEventEnd, navigationStart))
            .isLessThanOrEqualTo(3);
    }

    private long getLoadTimeInSeconds(long loadEventEnd, long navigationStart) {
        long loadTimeInSeconds = (loadEventEnd - navigationStart) / 1000;
        String logBody = String.format("Page Load Time is %s seconds.", loadTimeInSeconds);
        System.out.println(logBody);
        return loadTimeInSeconds;
    }
{% endhighlight %}

Pretty simple, isn't it? By the way, I checked it on Chrome and loading there is usually ~1 second faster than on
Microsoft Edge.

Complete code with all imports, dependencies etc. is available on
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting/tree/2a1526ea8b07dbd18a7960ffa8845beff5083616/src/test/java/com/awesome/testing/performance/timing).
Enjoy :)
