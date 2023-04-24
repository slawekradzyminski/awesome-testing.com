---
title: Automate your XSS tests with Selenium
layout: post
permalink: /2017/11/automate-your-xss-tests-with-selenium
categories:
  - Selenium
tags:
  - selenium
  - security 
---

![](/images/blog/safety-lock-logo_23-2147493514.jpg)

We are heading into an era where potential attackers have very easy knowledge access. In some instances proper training
isn't even required, because offensive tools are getting better and better. A lot of companies decided that it's better
to pay real money for security bugs (see [Bug Bounty list](https://hackerone.com/bug-bounty-programs)) than take a risk
hostile exposure.

As testers we shouldn't ignore this trend. This is already reflected in job offers - you may often notice that
defensive/offensive security knowledge is starting to appear not only in 'nice to have' section, but also in
requirements. I have already made [2 posts](http://www.awesome-testing.com/search/label/security) about various security
testing aspects.

XSS (cross-site scripting) is one of the easiest vulnerabilities to
test ([for example by scanners](https://www.owasp.org/index.php/Category:Vulnerability_Scanning_Tools)). It's also the
second most prevalent issue in the [OWASP Top 10](https://www.owasp.org/images/b/b0/OWASP_Top_10_2017_RC2_Final.pdf),
and is found in around two thirds of all applications. Today I want to show you how to test against XSS using Selenium.
We would focus our attention on the most popular and common type of XSS - Reflected Cross-Site Scripting.

**Reflected Cross-Site Scripting basics**

[OWASP](https://www.owasp.org/index.php/Testing_for_Cross_site_scripting) provides excellent description of Reflected
XSS which doesn't require much explanation:

> These holes show up when data provided by a web client is used immediately by server-side scripts to generate a page
of results for that user. If unvalidated user-supplied data is included in the resulting page without HTML encoding,
this will allow client-side code to be injected into the dynamic page. A classic example of this is in site search
engines: if one searches for a string which includes some HTML special characters, often the search string will be
redisplayed on the result page to indicate what was searched for, or will at least include the search terms in the text
box for easier editing. If all occurrences of the search terms are not HTML entity encoded, an XSS hole will result.__

For more information see [OWASP Testing Guide](https://www.owasp.org/images/1/19/OTGv4.pdf) which is amazing resource
available for free.

**Example in Java**

As usual I enjoyed the most coding part. I commited it on
my [Github project](https://github.com/slawekradzyminski/AwesomeTesting/commit/907e6f7de8702d8da6db1c78d9fcdb5fb278a1b2).

Let's split the explanation into few parts:

**_Driver preparation_**

This step can be omitted entirely if you are using Firefox. I usually prefer Chrome (chromedriver is in my opinion the
most reliable driver) so I had to disable built-in client xss protection first. I have already covered it extensively in
my [Browser Capabilites Explained post](http://www.awesome-testing.com/2016/02/selenium-browser-capabilities-explained.html)
so I assume reader doesn't require additional explanation.

XSS protection in Google Chrome is disabled by_\--disable-xss-auditor_ option.

{% highlight java %}
public class XssDisabledChromeConfig extends FluentTestNg {

    private static final String DISABLE_XSS_AUDITOR = "--disable-xss-auditor";

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
        chromeSwitches.add(DISABLE_XSS_AUDITOR);
        return chromeSwitches;
    }
{% endhighlight %}

**_Picking a vulnerable page_**

Obviously in order to show you how to test against XSS I had to find a vulnerable page. I decided to
use [XSS game](https://xss-game.appspot.com/) level 1.

That's the Page Object implementation using [FluentLenium](https://github.com/FluentLenium/FluentLenium).

{% highlight java %}
@PageUrl("https://xss-game.appspot.com/level1/frame")
public class XssGameLevelOnePage extends FluentPage {

    @FindBy(id = "level1")
    private FluentWebElement body;

    @FindBy(id = "query")
    private FluentWebElement queryInput;

    @FindBy(id = "button")
    private FluentWebElement sarchButton;

    @Override
    public void isAt() {
        await().atMost(5, TimeUnit.SECONDS).until(body).displayed();
    }

    public void searchFor(String content) {
        queryInput.fill().with(content);
        sarchButton.click();
    }
}
{% endhighlight %}

**_Test implementation_**

Having Page Object implemented we are ready for testing. Here is complete code of my test:

{% highlight java %}
public class XssGameTest extends XssDisabledChromeConfig {

    private static final String MY_CHROME_PATH = "C:\\drivers\\chromedriver.exe";
    private static final String XSS_CONTENT = "<script>alert(\"1\");</script>";

    @BeforeTest
    public void setUp() {
        if (SystemUtils.IS_OS_WINDOWS) {
            System.setProperty("webdriver.chrome.driver", MY_CHROME_PATH);
        }
    }

    @Page
    private XssGameLevelOnePage xssGameLevelOnePage;

    @Test
    public void xssShouldNotWork() {
        goTo(xssGameLevelOnePage).isAt();

        xssGameLevelOnePage.searchFor(XSS_CONTENT);

        assertThat(xssGameLevelOnePage.isAlertDisplayed()).isFalse();
    }
}
{% endhighlight %}

As you can see there is weirdly lookin CSS\_CONTENT string which require further explanation:

This is actual XSS. We are searching for something that may lead to client-side code injection on attacked webpage. This
particular JavaScript opens only silly alert, but attacker may use it for something more serious.

{% highlight java %}
XSS_CONTENT = "<script>alert(\"1\");</script>";
{% endhighlight %}

**_Assertion_**

Usually we want our test to have clear success/failure criteria. That's why I implemented the following method in my
PageObject:

{% highlight java %}
public boolean isAlertDisplayed() {
        boolean foundAlert;
        WebDriverWait wait = new WebDriverWait(getDriver(), 2);
        try {
            wait.until(ExpectedConditions.alertIsPresent());
            foundAlert = true;
        } catch (TimeoutException e) {
            foundAlert = false;
        }
        return foundAlert;
    }
{% endhighlight %}

This method is returning true if popup is displayed in 2 seconds time.

Execute the test on your computer and you will see that it fails - we have found XSS!
