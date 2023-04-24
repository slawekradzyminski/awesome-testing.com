---
title: How to use automated functional tests to drive your exploratory, security and performance testing efforts?
layout: post
permalink: /2018/01/how-to-use-automated-functional-tests
categories:
  - Security
tags:
  - testing thoughts
  - security
  - performance testing
---

![](/images/blog/silly.jpg)

There is a growing need for technical testers who can test applications comprehensively. With such a low amount of top
specialists you may have been encouraged to extend your skill set not only in programming domain. Today I'd like to show
you how to start with security, performance and exploratory testing in an easy way. What's important my approach is not
only easy, but also very effective.

Let's say you are working in a quite mature project which is covered by automated functional tests written
using [Rest-Assured](http://www.awesome-testing.com/search/label/API%20testing)
or [Selenium](http://www.awesome-testing.com/search/label/selenium) (I've chosen these tools because my readers are
familiar with them - see blog history for multiple examples).

The starting point is very simple. We would use existing test scenarios to capture HTTP traffic and play with it. Why?
Because I assume testing suites cover the most important functionalities from customer point of view.

## Proxy basics

In order to capture traffic we will need a[proxy](https://en.wikipedia.org/wiki/Proxy_server) which is a server (a
computer system or an application) that acts as an intermediary for requests from clients seeking resources from other
servers. This [Wikipedia](https://en.wikipedia.org/wiki/Proxy_server) image explains the idea.

![](/images/blog/Proxy_concept_en.svg.png)

## How to setup local proxy?

There are multiple tools which allow you to setup local proxy very quickly. Here are my recommendations + links to step
by step setup guides.

a) [JMeter](http://jmeter.apache.org/) - The Apache JMeter™ application is open source software, a pure 100% Java
application designed to load test functional behavior and measure performance.

[Link to JMeter proxy setup guide](https://github.com/slawekradzyminski/AwesomeTesting/blob/master/src/test/java/gui/proxy/jmeter_proxy_step_by_step.pdf)

b) [Burp](https://portswigger.net/burp) - graphical tool for testing Web application security. The tool is written in
Java and developed by PortSwigger Security.

[Link to Burp proxy setup guide](https://support.portswigger.net/customer/portal/articles/1783055-configuring-your-browser-to-work-with-burp)

c) [Fiddler](https://www.telerik.com/fiddler) - free web debugging tool which logs all HTTP(S) traffic between your
computer and the Internet. Inspect traffic, set breakpoints, and fiddle with incoming or outgoing data.

[Link to Fiddler proxy setup guide](http://docs.telerik.com/fiddler/KnowledgeBase/Proxy)

d) [Charles](https://www.charlesproxy.com/) - proxy that enables a developer to view all of the HTTP and SSL / HTTPS
traffic between their machine and the Internet.

[Link to Charles proxy setup guide](https://www.charlesproxy.com/documentation/configuration/proxy-settings/)

e) [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project) - one of the world’s most popular free
security tools which is actively maintained by hundreds of international volunteers

[Link to OWASP ZAP proxy setup guide](https://chrisdecairos.ca/intercepting-traffic-with-zaproxy/)

## Implementation

All right. Traffic is being captured so now we need to generate. Thankfully as I mentioned in the introduction we
already have automated functional tests. How to run them via local proxy?

a) Rest Assured

For our API test we need... 1 line. In this example we have a local proxy running on port 8888.

{% highlight java %}
RestAssured.proxy = host("localhost").withPort(8888);
{% endhighlight %}

b) Selenium

With Selenium it's a bit more difficult. Let's assume we are using the most
stable [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/). I have already explained how to play with
Chrome options in
my [Browser Capabilities Explained](http://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)
post.

Here is the code:

{% highlight java %}
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
        chromeSwitches.add("--proxy-server=http://localhost:8888");
        chromeSwitches.add("--ignore-certificate-errors");
        return chromeSwitches;
    }
{% endhighlight %}

Second switch (`--ignore-certificate-errors`) helps with https/certificate issues.

After running your tests locally with such configuration you should have already captured http(s) traffic in your proxy.

## Security testing usage

Traffic captured from functional tests is an excellent starting point for active/passive security scanning. At this
point you can just press start scanning (in Burp & OWASP ZAP) knowing that you are testing the most important scenarios.
It's worth to add that attackers would probably start exploring your application going through the same scenarios.

For more experienced security testers there is something even more important. Captured requests expose where untrusted
data can be injected into your application. According to
OWASP [Injection Theory](https://www.owasp.org/index.php/Injection_Theory) document:

Untrusted data is most often data that comes from the HTTP request, in the form of URL parameters, form fields, headers,
or cookies. But data that comes from databases, web services, and other sources is frequently untrusted from a security
perspective. That is, untrusted data is input that can be manipulated to contain a web attack payload.
The [OWASP Code Review Guide](https://www.owasp.org/index.php/Searching_for_Code_in_J2EE/Java) has a decent list of
methods that return untrusted data in various languages, but you should be careful about your own methods as well.

## Performance testing usage

Each step of automated functional test can be captured by Jmeter. I probably don't have to explain what does it mean to
you. Just save the steps, randomize some data, increase the number of concurrent threads and you have your performance
test ready. Wonderful, isn't it?

## Exploratory testing usage

Fans of exploratory testing are probably already licking their lips seeing all possibilities. In HTTP request can be
twisted, spinned, rolled and reverted. Prizes can suddenly go below zero, shopping promotions above zero, names receive
Chinese symbols and checkout basket can suddenly reset to 0. I'm sure you can see how convenient it is to have full
application request flow from the beginning of exploratory testing session.
