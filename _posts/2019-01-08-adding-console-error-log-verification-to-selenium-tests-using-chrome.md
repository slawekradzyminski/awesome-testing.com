---
title: Adding console error log verification to Selenium tests using Chrome
layout: post
permalink: /2019/01/adding-console-error-log-verification
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/Przechwytywanie.PNG)

Selenium is an amazing test tool that is used pretty much everywhere these days. People are usually so spoiled by the
number of functionalities it provides that they can't hide being surprised when they notice two missing functionalities:

* ability to assert HTTP requests/responses (like status codes)
* ability to capture browser console logs

Today I'd like to focus on the second topic - browser console.

To put it in simple words. Currently, you can easily capture browser logs only in Chrome. Of course, you can always
build your own solution for other browsers but you have no guarantee that it would work after next browser update. There
is a [W3C Webdriver](https://github.com/w3c/webdriver/issues/406) attempt to standardize browser logging interface
however the progress seems to be slow.

Thankfully, in Chrome errors can be captured and I encourage you to do it in your scripts.

**Preparation**

To show this feature in action we need to prepare tests. I'm going to use my own blog as an example of a site not
reporting any console errors. In order to make failing example deterministic I created a custom broken site.

{% highlight xml %}
<html>
<head>
    <title>Page</title>
</head>
<body>
<div>The image below does not work by purpose
    (it triggers js error in browser console).</div>
<img src="https://nonexisting.url">
</body>
</html>
{% endhighlight %}

As usual, tests are written using [FluentLenium](https://fluentlenium.com/).

{% highlight java %}
@Test
public void pageHopefullyWithoutErrors() {
goTo(awesomeTestingPage);
}

    @Test
    public void pageWithErrors() throws URISyntaxException {
        goToFileInResources("pageWithError.html");
    }
{% endhighlight %}

**Demo**

Capturing console log errors is pretty easy. You only need one method

{% highlight java %}

    @After
    public void verifyConsoleErrors() {
        Logs logs = getDriver().manage().logs();
        LogEntries logEntries = logs.get(LogType.BROWSER);
        List<LogEntry> errorLogs = logEntries.filter(Level.SEVERE);

        if (errorLogs.size() != 0) {
            for (LogEntry logEntry: logEntries) {
                System.out.println("Found error in logs: " + logEntry.getMessage() );
            }
            fail(errorLogs.size() + " Console error found");
        }
    }
{% endhighlight %}

And as you can see on the image below error was reported.

![](/images/blog/Przechwytywanie2.PNG)

Every line of code needed to write this blog post was added to
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting/commit/51969357bf940c58821bc080dcc7c3588d69cf8e).

Happy new year everyone :)
