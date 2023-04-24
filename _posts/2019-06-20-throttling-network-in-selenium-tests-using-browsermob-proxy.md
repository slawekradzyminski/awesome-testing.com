---
title: Throttling network in Selenium tests using BrowserMob Proxy
layout: post
permalink: /2019/06/throttling-network-in-selenium-tests
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/photo-1520869562399-e772f042f422.jpeg)

It's a good testing practice to avoid as many external dependencies as possible. We want to run everything on localhost
and avoid test failures caused by things outside our application scope (environment issues, network problems,
unavailable web services).

Unfortunately, our clients don't access applications in a sterile environment. Many of them use rather slow GPRS/3G
Internet connection with significant latency caused by cellular interface. Hence we need to check how our systems cope
with slow Internet connection.

When it comes to manual verification the choice is
straightforward. [Chrome Dev Tools](https://developers.google.com/web/tools/chrome-devtools/device-mode/?utm_source=dcc&utm_medium=redirect&utm_campaign=2016q3)
have powerful network throttling functionalities. Sometimes though, we want to create an automated functional test which
checks that everything works fine with limited bandwidth. How to do it?

The easiest solution is
to [set up a proxy](https://www.awesome-testing.com/2018/01/how-to-use-automated-functional-tests.html) through which we
would pass network traffic. BrowserMob Proxy is a great tool that integrates nicely with Selenium and has very easy to
use Java API. BrowserMob Proxy allows you to manipulate HTTP requests and responses, capture HTTP content, and export
performance data as a HAR file. I've described the performance measuring feature in
a [separate post](https://www.awesome-testing.com/2016/10/browsermob-proxy-selenium-network.html).

## Understanding network bandwidth and latency

Before I'll show you how to throttle network in traditional demo let's clarify what exactly network latency and
bandwidth.

Latency is the amount of time it takes for data to travel from source to destination. It is dependent on the distance
that data must travel through cords, networks, radio interfaces and the like to reach its destination. If you are an
online gamer you probably check your ping. That's also your network latency.

Bandwidth is the rate of data transfer for a fixed period of time. The wider the communication band, the more data that
can flow through it simultaneously. If you buy an Internet connection you most likely pay for maximum bandwidth (like
200 Mb/s).

## Demo

As usual, I have prepared a demo on my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting). I'm going
to use [FluentLenium](https://fluentlenium.com/) Selenium extension.

At first, we would like to start a BrowserMob Proxy and change default configuration:

a) By settings 300ms network latency

b) By settings 1Mb/s (1 000 000 bytes/s) download and upload limit

c) By changing HTTP request user agent header to custom value (this simplifies debugging)

{% highlight java %}
    private static final int BROWSER_MOB_PROXY_PORT = 9191;
    private static final String USER_AGENT = "User-Agent";

    protected BrowserMobProxyServer server = new BrowserMobProxyServer();

    @Before
    public void startBMP() {
        server.start(BROWSER_MOB_PROXY_PORT);
        server.setReadBandwidthLimit(1000000);
        server.setWriteBandwidthLimit(1000000);
        server.setLatency(300, TimeUnit.MILLISECONDS);

        server.removeHeader(USER_AGENT);
        server.addHeader(USER_AGENT, "Throttled Chrome Selenium Test");
    }
{% endhighlight %}

Next, we need to create a Proxy object that will be used in tests. BrowserMob Proxy gives as a very useful static method
createSeleniumProxy() which simplifies setup. Next lines setup proxy IPv4 localhost urls.

{% highlight java %}
    private Proxy getProxy() {
        Proxy seleniumProxy = ClientUtil.createSeleniumProxy(server);
        String hostIp = null;
        try {
            hostIp = Inet4Address.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        String proxyUrl = String.format("%s:%s", hostIp, BROWSER_MOB_PROXY_PORT);
        seleniumProxy.setHttpProxy(proxyUrl);
        seleniumProxy.setSslProxy(proxyUrl);

        return seleniumProxy;
    }
view raw
{% endhighlight %}

Now we just need to modify Selenium Capabilities. Chrome example below.

{% highlight java %}
    public WebDriver newWebDriver() {
        return new ChromeDriver(getChromeOptions());
    }

    private ChromeOptions getChromeOptions() {
        ChromeOptions options = new ChromeOptions();
        options.setProxy(getProxy());
        return options;
    }
{% endhighlight %}

And here is final test that checks my blog with 1Mb/s network bandwidth.

{% highlight java %}
public class SlowNetworkTest extends ThrottledChrome {

    @Page
    private AwesomeTestingPage awesomeTestingPage;

    @Test
    public void shouldLoadBlogOnSlowNetwork() {
        goTo(awesomeTestingPage).isAt();
    }

}
{% endhighlight %}

Happy proxying :)
