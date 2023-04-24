---
title: BrowserMob Proxy Selenium network performance extension
layout: post
permalink: /2016/10/browsermob-proxy-selenium-network
categories:
  - Selenium
tags:
  - selenium 
---

![](/images/blog/3vg5xk.jpg)

It's been a while since I published some Java code here, but
as [Dexter Morgan](http://dexter.wikia.com/wiki/Dexter_Morgan) would say: today is the day. If you want me to post Java
tests more often please let me know in the comments.

[BrowserMob Proxy](https://bmp.lightbody.net/) is a very useful tool which 'can capture performance data for web apps (
via the [HAR format](https://dvcs.w3.org/hg/webperf/raw-file/tip/specs/HAR/Overview.html)), as well as manipulate
browser behavior and traffic, such as whitelisting and blacklisting content, simulating network traffic and latency, and
rewriting HTTP requests and responses'. It also has built-in support for Selenium integration which adds few nice
features for our test suites with very little effort required.

You may, of course, say that a Selenium is not a performance testing tool (and rightly so), but nevertheless, it can
contribute to your testing in the following ways:

* You can quickly assert that none of the web requests returned undesired HTTP responses (
  like [404](https://en.wikipedia.org/wiki/HTTP_404), [5xx](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_Error)).
  Captured `.har` network traffic can be easily converted to Apache JMeter using various tools, for
  example, [Har2jmeter](http://seitenbau.github.io/har2JMeter/)
* `.har` files can be used for comparison measures. If you do things right (i.e. your testing environment is exactly the
  same on each test run) changes in overall test execution time can indicate performance problems. Knowing that already
  you can just compare two \*.har files (fast one and slow one) and check exactly which requests had slowed down.*
  Modify user agent in requests

Those are just a few things that come to my mind right now, the full list of BrowserMob Proxy features is
listed[here](https://github.com/lightbody/browsermob-proxy#using-with-selenium).

In order to start using BrowserMob Proxy add this Maven dependency to your project:

{% highlight xml %}
<dependency>
<groupId>net.lightbody.bmp</groupId>
<artifactId>browsermob-core</artifactId>
<version>2.1.2</version>
</dependency>
{% endhighlight %}

Now BrowserMob Proxy can be run using simple methods. I'm using TestNG annotation to start it before the tests, and
close just after all of them finish. As you can see I capture all HTTP traffic headers here.

{% highlight java %}
private static final int BROWSER_MOB_PROXY_PORT = 9191;

    protected BrowserMobProxyServer server;

    @BeforeClass
    public void startBMP() {
        server = new BrowserMobProxyServer();
        server.start(BROWSER_MOB_PROXY_PORT);
        server.setHarCaptureTypes(CaptureType.getHeaderCaptureTypes());
    }

    @AfterClass
    public void stopBMP() {
        server.stop();
    }
}
{% endhighlight %}

And this Gist shows how to add proxy settings to ChromeDriver. See
my [Browser capabilities explained](https://awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)
post for a more thorough description of browser configuration.

{% highlight java %}
@Override
public WebDriver getDefaultDriver() {
return new ChromeDriver(getChromeCapabilities());
}

    private DesiredCapabilities getChromeCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.chrome();
        capabilities.setCapability(CapabilityType.PROXY, getChromeProxySettings());
        return capabilities;
    }

    private Proxy getChromeProxySettings() {
        return ClientUtil.createSeleniumProxy(server);
    }
{% endhighlight %}

Now the most important thing - actual tests. As you can see I'm starting new Har capture on BrowserMob Proxy server
before each test (it's called 'Awesome Testing Only Test' or 'Google Awesome Testing Test'). After the last test step
ends network traffic is saved to \*.har file. I'm
using [FluentLenium](https://awesome-testing.com/2016/01/introducing-fluentlenium-1.html) syntax. Page Objects code can
be found on
my [Github project](https://github.com/slawekradzyminski/AwesomeTesting/tree/master/src/test/java/gui/browsermobproxy/pages)
. Hopefully, you have no problem understanding what the tests do :)

{% highlight java %}
public class BrowserMobChromeTest extends BrowserMobChrome {

    private static final String AWESOME_TESTING = "Awesome Testing";

    @Test
    public void awesomeTestingOnly() throws IOException {
        server.newHar("Awesome Testing Only Test");

        AwesomeTestingPage awesomeTestingPage = createPage(AwesomeTestingPage.class);
        awesomeTestingPage.go();
        awesomeTestingPage.isAt();

        Har har = server.getHar();
        har.writeTo(new File("at.har"));
    }

    @Test
    public void googleAwesomeTesting() throws IOException {
        server.newHar("Google Awesome Testing Test");
        GoogleHomePage googleHomePage = createPage(GoogleHomePage.class);
        googleHomePage.go();
        googleHomePage.isAt();

        GoogleSearchResultPage googleSearchResultPage = googleHomePage.search(AWESOME_TESTING);
        googleSearchResultPage.isAt();

        AwesomeTestingPage awesomeTestingPage = googleSearchResultPage.clickLink(AWESOME_TESTING);
        awesomeTestingPage.isAt();

        Har har = server.getHar();
        har.writeTo(new File("googleat.har"));
    }

}
{% endhighlight %}

Our quest for obtaining \*.har network traffic file is completed. The screenshot below shows how does it look like
in [Google HTTP Archive Viewer](https://chrome.google.com/webstore/detail/http-archive-viewer/ebbdbdmhegaoooipfnjikefdpeoaidml/related?hl=en)
extension. It took 239 requests and 9.59 seconds to successfully Google my blog.

![](/images/blog/Screenshot%2B2016-10-04%2B09.17.45.png)

The file can also be accessed using external libraries. In the code below, I convert it JSON format
using [HarReader](https://github.com/sdstoehr/har-reader). It's not exactly part of the test so I put it in external
class.

{% highlight java %}
public static void main(String[] args) throws HarReaderException, IOException {
String pathToFile = "at.har";

        HarReader harReader = new HarReader();
        List<HarEntry> harEntryList = harReader.readFromFile(new File(pathToFile)).getLog().getEntries();

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try (Writer writer = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("filename.txt"), "utf-8"))) {
            writer.write(gson.toJson(harEntryList));
        }
    }
{% endhighlight %}

Remember: Complete Java code of this post (and every other) can be found on my [Github project](https://github.com/slawekradzyminski/AwesomeTesting/tree/master/src/test/java/gui/browsermobproxy).
