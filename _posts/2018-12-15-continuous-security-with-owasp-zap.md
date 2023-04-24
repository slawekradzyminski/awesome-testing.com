---
title: Continuous Security with OWASP ZAP
layout: post
permalink: /2018/12/continuous-security-with-owasp-zap
categories:
  - Security
tags:
  - security 
---

![](/images/blog/051e0245d787d1f71246d515e88a8564_zap256x256-oversize.png)

Referring nicely to 'continuous' word in the title I'm following up previous posts
about [OWASP Dependency Checker](https://www.awesome-testing.com/2017/02/continuous-security-with-owasp.html)
and[Find Sec Bugs](https://www.awesome-testing.com/2018/11/continuous-security-with-find-sec-bugs.html)by presenting yet
another tool which can help ensure security during Continuous Integration (CI) pipeline run - OWASP Zedd Proxy Attack (
more popular with OWASP ZAP name).

OWASP ZAP is one of the world’s most popular free security tools which can help you find security vulnerabilities in
your web application. It allows you to catch HTTP traffic via locally configured proxy. Such traffic can then be used to
modify requests in order to exploit an app. Tweaks don't have to be done by a human. There is a possibility to actively
scan an app using built-in logic. In this article, I'll show you how to trigger such actions using Java.

Usual word of caution: security is a very high-risk area which probably shouldn't be ensured by tools only. Human
penetration testing is advised. For details, I invite you to take a look at
my [Automated testing vs manual testing - security perspective](https://www.awesome-testing.com/2017/03/automated-testing-vs-manual-testing.html)
post where I outlined my thoughts about security testing in details.

## Prerequisites

In order to see OWASP ZAP in action you need few things:

a) OWASP ZAP

- Download it from[Github](https://github.com/zaproxy/zaproxy/wiki/Downloads)
- Run it
- Configure proxy: Tools -> Options -> Local Proxies. Set port to 8888

b) Vulnerable application - system under test

- Install docker and run docker service
- Run [bodgeit docker container](https://hub.docker.com/r/psiinon/bodgeit/)(or any
app[)](https://github.com/psiinon/bodgeit)
- Make sure it's running on [http://localhost:8080/bodgeit/](http://localhost:8080/bodgeit/)

c) Selenium code

- Download my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting)
- Get API key from your ZAP instance: Tools -> Options -> API
- Update `ZAP_API_KEY` in ZapApi class
- I'm skipping Chrome, chromedriver, Maven, SDK, and other Selenium-related setups as I've covered it already multiple
times in [multiple GUI automation posts](https://www.awesome-testing.com/search/label/selenium).

## High-level view

The following image visualizes what's going to happen:

![](/images/blog/Przechwytywanie3.PNG)

Selenium traffic will go through ZAP proxy in order to capture all traffic. It's not exactly necessary for the bodgeit
shop, but in real-world applications spider would struggle to find URLs requiring logged in access.

After Selenium run spidering, passive & active scanning will be triggered
via [ZAP API](https://github.com/zaproxy/zaproxy/wiki/ApiDetails). In order to increase code readability, I created an
interface.

{% highlight java %}
public interface ZapFunctionalities {

    void doSpidering() throws ClientApiException, InterruptedException;
    void doPassiveScan() throws ClientApiException, InterruptedException;
    void doActiveScan() throws ClientApiException, InterruptedException;

}
{% endhighlight %}

Before we move on into practice, some necessary theory from [ZAP User Guide](https://github.com/zaproxy/zap-core-help).

a) Spider

A spider is a tool that is used to automatically discover new resources (URLs) on a particular Site. It begins with a
list of URLs to visit, called the seeds, which depends on how the Spider is started. The Spider then visits these URLs,
it identifies all the hyperlinks in the page and adds them to the list of URLs to visit and the process continues
recursively as long as new resources are found.

b) Passive Scan

ZAP by default passively scans all HTTP messages (requests and responses) sent to the web application being tested.
Passive scanning does not change the requests nor the responses in any way and is, therefore, safe to use. Scanning is
performed in a background thread to ensure that it does not slow down the exploration of an application.

c) Active Scan

Active scanning attempts to find potential vulnerabilities by using known attacks against the selected targets. Active
scanning is an attack on those targets. You should NOT use it on web applications that you do not own. It should be
noted that active scanning can only find certain types of vulnerabilities. Logical vulnerabilities, such as broken
access control, will not be found by any active or automated vulnerability scanning.

## Selenium setup

In order to use OWASP ZAP, you have to configure a local proxy for functional tests. Thankfully, I have already covered
such topic in
my [How to use automated functional tests to drive your testing efforts post](https://www.awesome-testing.com/2018/01/how-to-use-automated-functional-tests.html).
In addition to Selenium config, there is also a Rest-Assured example (API tests can be used to capture traffic as well).

The following snippet shows a brief summary of what needs to be done for Selenium tests using chromedriver. Chrome needs
to know about proxy so an additional flag is required.

{% highlight java %}
    public WebDriver newWebDriver() {
        return new ChromeDriver(getChromeOptions());
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

Seleniums I have written as an example are pretty dumb. They just crawl the page.

{% highlight java %}
@PageUrl("http://localhost:8080/bodgeit/")
public class LoggedOutHomePage extends FluentPage {

    public void crawlSiteToSimulateSeleniumTraffic() {
        el(By.linkText("Home")).click();
        el(By.linkText("Doodahs")).click();
        el(By.linkText("Zip a dee doo dah")).click();
        el(By.linkText("About Us")).click();
        el(By.linkText("Scoring page")).click();
        el(By.linkText("Your Basket")).click();
        el(By.linkText("Search")).click();
    }
}
{% endhighlight %}

They crawl logged in pages as well.

{% highlight java %}
    @Test
        public void loggedOutCrawl() {
        goTo(loggedOutHomePage).crawlSiteToSimulateSeleniumTraffic();
    }

    @Test
    public void loggedInCrawl() {
        goTo(registerPage).registerUser(USERNAME, PASSWORD);
        goTo(loginPage).login(USERNAME, PASSWORD);
        goTo(loggedInHomePage).crawlPageToSimulateSeleniumTraffic();
    }
{% endhighlight %}

If you have done everything right you should now see a couple of requests on ZAP GUI.

![](/images/blog/owaspzap.PNG)

## ZAP API

Time to move on into actual OWASP ZAP stuff. There is Java ZAP API client library available. Add it as a dependency
first.

{% highlight xml %}
        <dependency>
            <groupId>org.zaproxy</groupId>
            <artifactId>zap-clientapi</artifactId>
            <version>1.6.0</version>
        </dependency>
{% endhighlight %}

Its syntax is quite lengthy so I decided to create two util classes: one for ZAP tasks (see interface above) and one for
API calls.

This is how ZAP task implementation looks like:

{% highlight java %}
    @Override
    public void doActiveScan() throws ClientApiException, InterruptedException {
        System.out.println("Active scanning started.");
        String activeScanTaskId = zapApi.getActiveScanTaskId();
        int progress;
        do {
            Thread.sleep(5000);
            progress = zapApi.getActiveScanProgress(activeScanTaskId);
            System.out.println("Active Scan progress : " + progress + "%");
        } while (progress < 100);
        System.out.println("Active Scan complete");
    }
{% endhighlight %}

As you can see we get taskId from API and then periodically check it's progress. Polling time seems big at first look (5
seconds), but active scanning is a very lengthy process which can take even hours. It's recommended that such security
tests should be executed daily during nighttime. Not only time but also the high amount of traffic would quickly
discourage you from adding them into a functional regression test suite.

JAVA API client is a bit awkward, but you can always rewrite it to Spring Template and do not use provided library.

{% highlight java %}
    public int getActiveScanProgress(String taskId) throws ClientApiException {
        String status = ((ApiResponseElement) api.ascan.status(taskId)).getValue();
        return Integer.parseInt(status);
    }
{% endhighlight %}

## Demo

After an extremely long journey with lots of coding and configuration (I even had to enable virtualization in BIOS in
order to use Docker in Windows) the security test is ready. It looks nice:

{% highlight java %}
public class SecurityTest {

    private static final String TARGET = "http://localhost:8080/bodgeit";

    private ZapApi zapApi = new ZapApi(TARGET);
    private Zap zap = new Zap(zapApi);

    @Test
    public void zapSecurityTest() throws ClientApiException, InterruptedException {
        zap.doSpidering();
        zap.doPassiveScan();
        zap.doActiveScan();

        zapApi.generateHtmlReport("report.html");

        assertThat(zapApi.getNumberOfAlerts()).isZero();
    }
}
{% endhighlight %}

It's up to you whether you want to use assertions or simply read the final report.

[An example report can be viewed here](https://htmlpreview.github.io/?https://github.com/slawekradzyminski/AwesomeTesting/blob/50435473147b6a90964ea8c0832f453ee3414c69/src/test/resources/report.html).

## Other sources

- Scanning job implemented in bash and SSL handling can be found
in [OWASP London slides pack](https://www.owasp.org/images/2/27/OWASPLondon-OWASP-ZAP-Selenium-20180830-PDF.pdf).
- My code was based
on [an official example](https://github.com/zaproxy/zap-api-java/blob/develop/subprojects/zap-clientapi/src/examples/java/org/zaproxy/clientapi/examples/SimpleExample.java),
but with lots of refactoring
- [Continuumsecurity](https://github.com/continuumsecurity) has two
projects - [zap-webdriver](https://github.com/continuumsecurity/zap-webdriver)
and [bdd-security](https://github.com/continuumsecurity/bdd-security), but approach and libraries are totally different
- New
book -[Hands-On Security in DevOps](https://www.amazon.com/Hands-Security-DevOps-continuous-deployment-ebook/dp/B07FNXVKCH)
short Continuous Security chapter
- [Sekurak](https://sekurak.pl/wprowadzenie-do-narzedzia-zed-attack-proxy-zap/) has a comprehensive introduction to
OWASP ZAP (polish only, sorry English-speaking readers)
