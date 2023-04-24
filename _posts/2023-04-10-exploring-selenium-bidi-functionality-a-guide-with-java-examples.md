---
title: Exploring Selenium BiDi Functionality
layout: post
permalink: /2023/04/exploring-selenium-bidi-functionality
categories:
  - Selenium
tags:
  - Java
  - selenium
  - UI testing
  - test automation 
---

![](/images/blog/selenium_logo_square_green.png)

Selenium is a widely-used open-source testing framework designed for automating web browsers and validating web
applications. Initially, Selenium consisted of Selenium IDE, a plugin for record-and-playback testing, and Selenium
Remote Control (RC), which allowed for browser automation using various programming languages. However, as the web grew
more complex, so did the need for more advanced testing capabilities.

Selenium WebDriver was introduced as a successor to Selenium RC, providing a simpler and more efficient API for browser
automation. WebDriver quickly gained traction as it enabled developers to write test scripts in multiple programming
languages, including Java, C#, Ruby, and Python, and execute them across different browsers such as Chrome, Firefox, and
IE.

Over the years, Selenium has become the industry standard for web application testing, thanks to its robustness,
flexibility, and extensive community support. However, with the increasing complexity of modern web applications and the
advent of single-page applications (SPAs), Selenium WebDriver faced certain limitations in terms of real-time
communication and control over browser internals.

To address these challenges and further improve the testing experience, the Selenium project introduced the Selenium
BiDi (short for Bidirectional) protocol. In the following sections, we'll explore Selenium BiDi in detail. Working Java
project will be provided as an example usage.

## Selenium BiDi

Selenium BiDi, short for Selenium Bidirectional, is an exciting new addition to the Selenium ecosystem that aims to
improve the way we interact with and automate web browsers. Its primary goal is to enable real-time communication
between WebDriver clients and web browsers using WebSockets. This bidirectional communication allows for more efficient
control and monitoring of browser activities, enabling advanced features and better performance.

One of the main benefits of using Selenium BiDi over traditional WebDriver APIs is that it provides a more powerful and
flexible way of automating web browsers. In addition to the standard WebDriver commands, Selenium BiDi allows for
advanced actions like executing JavaScript commands, intercepting network requests, and handling browser events in
real-time.

As you can see in [Selenium documentation](https://www.selenium.dev/documentation/webdriver/bidirectional/) there are
two implementations of Selenium BiDi:

- [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/) (CDP)

- [WebDriver BiDirectional Protocol](https://w3c.github.io/webdriver-bidi/) (WebDriver BiDi)

In this blog post, we will dive into the various aspects of Selenium BiDi and showcase its capabilities using Java
examples. We will explore the differences between CDP and WebDriver BiDi, understand the architecture, and demonstrate
how to perform advanced actions and debugging with Selenium BiDi. By the end of this post, you will have a solid
understanding of how Selenium BiDi can enhance your web automation and testing experience. So, let's get started!

## Chrome DevTools Protocol (CDP)

The [Chrome DevTools Protocol (CDP)](https://chromedevtools.github.io/devtools-protocol/) is a powerful and versatile
API that allows developers to interact with and control Google Chrome and other Chromium-based browsers
programmatically. CDP provides a wide range of capabilities, such as inspecting and manipulating the DOM, monitoring
network activity, emulating different devices, evaluating JavaScript expressions, and profiling performance, among
others. These functionalities facilitate in-depth debugging, testing, and analysis of web applications, making CDP an
essential tool for developers striving to create high-quality, performant, and reliable web experiences. CDP operates
over a WebSocket-based communication channel, enabling bidirectional communication between client and browser, which
allows for real-time updates and more granular control over the browser's internal workings.

### CDP support in Selenium

While Selenium offers support for Chrome DevTools Protocol (CDP), its integration can be somewhat awkward and
challenging. One major issue with the CDP support in Selenium is that Java bindings need to maintain separate packages
for each Chromium version. This can result in compatibility issues and increased maintenance overhead, as developers
must ensure that their test scripts work correctly with the specific version of Chromium being used (see screenshot
from [javadoc](https://www.javadoc.io/doc/org.seleniumhq.selenium/selenium-devtools-v111/latest/overview-summary.html)
below).

![](/images/blog/dTW_B6D4YbtqekhvrURTrGLRo3RUX3U44W4n0O9E5rI5XAKNvuOYLWw3IGya8N52I2ORyzdVjo2ePVr6rlihBJUMat2xEUGplaU-uD-yLW5RIppq8ml1j-CDRvL8ys1rY3YpRyZY3K3EG1amAcQABqs=w520-h640)

Additionally, the [official Selenium documentation](https://www.selenium.dev/documentation/webdriver/bidirectional/)
highlights the drawbacks of relying on CDP for testing purposes. It states, "As it is not a good idea to tie your tests
to a specific version of any browser, the Selenium project recommends using WebDriver BiDi wherever possible." This
recommendation underscores the importance of adopting WebDriver BiDi, which aims to provide a more standardized and
future-proof solution for browser automation and testing, without the need to keep up with the ever-changing Chromium
versions and their corresponding CDP APIs.

Despite the challenges associated with using CDP in Selenium, it's worth noting that integrating CDP can unlock some
powerful functionalities that can significantly enhance your web application testing capabilities. For example, by
leveraging CDP, you can:

* **Mock the network**: Simulate various network conditions and intercept HTTP requests and responses, allowing you to
  test how your application behaves under different network scenarios, such as slow connections, high latency, or even
  offline mode.
* **Listen to console/JavaScript errors**: Monitor the browser console for JavaScript errors, warnings, or other logs in
  real-time. This can help you quickly identify and address issues in your application's code, ensuring a smooth user
  experience.
* **Collect [performance metrics](https://stackoverflow.com/questions/48630430/i-need-more-info-about-puppeteer-page-metrics-and-queryobjects)**: Gather detailed performance data, such as rendering times, memory usage, and the number of nodes, to help you
  identify bottlenecks and optimize your web application's performance.

These advanced functionalities offered by CDP can provide valuable insights into your web application's behavior,
stability, and performance, making it an attractive option for developers seeking more granular control and deeper
analysis of their applications. However, it's essential to weigh these benefits against the challenges of maintaining
compatibility with different Chromium versions and the recommendation to use WebDriver BiDi whenever possible.

### Mocking the network

The code snippet provided demonstrates how to mock an HTTP request using Selenium, specifically by intercepting a
request triggered by clicking on a "here" link in the application being tested. Here's a step-by-step explanation of how
the mocking process works in this example:

{% highlight java %}
@SuppressWarnings("resource")
private void mockRequestWhichIsTriggeredByClickingOnHereLink() {
new NetworkInterceptor(
           driver,
           Route.matching(req -> req.getUri().contains("status_codes"))
                   .to(() -> req -> new HttpResponse()
                        .setStatus(200)
                        .addHeader("Content-Type", MediaType.HTML_UTF_8.toString())
                        .setContent(utf8String(MOCKED_RESPONSE))));
}
{% endhighlight %}

a) First, a new instance of _NetworkInterceptor_ is created, which is responsible for intercepting and manipulating
network requests and responses in the browser session controlled by the Selenium driver.

b) The _Route.matching()_ method is used to define a custom route that will be intercepted. The _req -> req.getUri()
.contains("status\_codes")_ lambda expression specifies that the route should match any request with a URI containing
the string _"status\_codes"_.

c) The _to()_ method is then called to provide a custom response for the matched route. In this case, it defines a
lambda expression _req -> new HttpResponse()_ that takes the intercepted request and constructs a new _HttpResponse_
object.

d) The _HttpResponse_ object is configured with a status code of 200 (HTTP OK), indicating a successful response. It
also includes an appropriate Content-Type header (in this case, _MediaType.HTML\_UTF\_8.toString()_), which tells the
browser that the response body contains HTML content encoded in UTF-8.

e) Finally, the setContent() method is called to set the content of the mocked response using _utf8String(
MOCKED_RESPONSE)_. This method converts the _MOCKED\_RESPONSE_ string into a byte array with the appropriate UTF-8
encoding, which is then used as the response body.

When this method is executed, any request matching the specified route will be intercepted, and the custom response will
be returned instead of the actual response from the server. This allows you to test how your application behaves when
specific requests return different responses, without the need to modify the server-side implementation or configure an
external mocking tool.

The whole test looks like this:

{% highlight java %}
public class NetworkInterceptorTest extends LocalTest {

   private static final String MOCKED_RESPONSE = "That's mocked response";

   @BeforeEach
   public void setUp() {
       driver.get("https://the-internet.herokuapp.com/redirector");
       mockRequestWhichIsTriggeredByClickingOnHereLink();
   }

   @Test
   public void networkInterceptor() {
       // when
       driver.findElement(By.linkText("here")).click();

       // then
       assertThat(driver.getPageSource()).contains(MOCKED_RESPONSE);
   }

   @SuppressWarnings("resource")
   private void mockRequestWhichIsTriggeredByClickingOnHereLink() {
       new NetworkInterceptor(
               driver,
               Route.matching(req -> req.getUri().contains("status_codes"))
                       .to(() -> req -> new HttpResponse()
                        .setStatus(200)
                        .addHeader("Content-Type", MediaType.HTML_UTF_8.toString())
                        .setContent(utf8String(MOCKED_RESPONSE))));
   }
}
{% endhighlight %}

### Listening to javascript errors in console

The code snippet provided demonstrates how to listen for JavaScript errors in the browser console using Selenium and the
Chrome DevTools Protocol (CDP). Below is an explanation of each part of the code snippet:

{% highlight java %}
import static org.awaitility.Awaitility.await;

public class JavascriptExceptionLoggerTest extends LocalTest {

   private final List<JavascriptException> jsExceptionsList = new ArrayList<>();

   @BeforeEach
   public void setUpLogger() {
       DevTools devTools = driver.getDevTools();
       devTools.createSession();
       devTools.getDomains().events().addJavascriptExceptionListener(jsExceptionsList::add);
   }

   @Test
   public void logEvents() {
       // when
       driver.get("http://the-internet.herokuapp.com/javascript_error");

       // then
       await().until(() -> jsExceptionsList.size() > 0);
   }
}
{% endhighlight %}

a) Import the necessary classes and packages, including _org.awaitility.Awaitility.await_ for waiting for a condition to
be met before proceeding in the test.

b) Define a new class called _JavascriptExceptionLoggerTest_ that extends a base test class named _LocalTest_. This base
class is assumed to set up the Selenium WebDriver and other required configurations.

c) Create a new instance variable _jsExceptionsList_, which is an _ArrayList_ of _JavascriptException_ objects. This
list will be used to store any JavaScript exceptions caught during the test execution.

d) In the _setUpLogger()_ method, which is annotated with _@BeforeEach_, perform the following steps:

* Get the _DevTools_ instance from the WebDriver by calling _driver.getDevTools()_.
* Create a new _DevTools_ session by invoking _devTools.createSession()._
* Add a new listener for JavaScript exceptions by calling _devTools.getDomains().events()
  .addJavascriptExceptionListener(jsExceptionsList::add)_. This listener adds any JavaScript exceptions encountered to
  the _jsExceptionsList_.

e) Define the _logEvents()_ test method, which is annotated with _@Test_:

* Navigate to the target web page by calling driver.get("http://the-internet.herokuapp.com/javascript\_error"). This
  page is assumed to contain a JavaScript error that will be logged in the browser console.
* Use the _await()_ method from the Awaitility library to wait for the condition _jsExceptionsList.size() > 0_ to be
  true, meaning that at least one JavaScript exception has been logged.

By following these steps, the JavascriptExceptionLoggerTest class will listen for JavaScript errors in the browser
console and store them in the _jsExceptionsList_ ArrayList. This functionality can be useful for identifying and
debugging issues in your web application's JavaScript code during test execution, helping to ensure a smooth and
error-free user experience.

### Gathering performance metrics

The provided code snippet demonstrates how to gather performance metrics for a web application using Selenium and the
Chrome DevTools Protocol (CDP). Here's a step-by-step explanation of the code:

{% highlight java %}
public class PerformanceMetricsTest extends LocalTest {

   private List<Metric> metricList;

   @BeforeEach
   public void setUp() {
       DevTools devTools = driver.getDevTools();
       devTools.createSession();
       devTools.send(Performance.enable(Optional.empty()));
       metricList = devTools.send(Performance.getMetrics());
   }

   @Test
   public void shouldCollectPerformanceMetrics() {
       // when
       driver.get("https://awesome-testing.com");

       // then
       metricList.forEach(PerformanceMetricsTest::logAndAssert);
   }

   private static void logAndAssert(Metric metric) {
       log.info("{} = {}", metric.getName(), metric.getValue());
       assertThat(metric.getValue().longValue()).isGreaterThanOrEqualTo(0);
   }

}
{% endhighlight %}

a) Define a new class called _PerformanceMetricsTest_ that extends a base test class named _LocalTest_. This base class
is assumed to set up the Selenium WebDriver and other required configurations.

b) Create a new instance variable _metricList_ of type _List<Metric>_. This list will be used to store the performance
metrics gathered from the browser.

c) In the _setUp()_ method, which is annotated with _@BeforeEach_, perform the following steps:

* Get the _DevTools_ instance from the WebDriver by calling _driver.getDevTools()_.
* Create a new _DevTools_ session by invoking _devTools.createSession()_.
* Enable the Performance domain in _DevTools_ by calling _devTools.send(Performance.enable(Optional.empty()))_.
* Retrieve the current performance metrics by sending a _Performance.getMetrics()_ command, and store the results in the
  metricList.

d) Define the _shouldCollectPerformanceMetrics()_ test method, which is annotated with _@Test_:

* Navigate to the target web page by calling _driver.get("https://awesome-testing.com")_. The performance metrics will
  be collected for this page.
* Call the _metricList.forEach(PerformanceMetricsTest::logAndAssert)_ method to process each metric in the _metricList_.
  For each metric, the _logAndAssert()_ method is called.

e) Implement the _logAndAssert()_ method, which takes a Metric object as input:

* Log the metric's name and value using _log.info("{} = {}", metric.getName(), metric.getValue())_.
* Assert that the metric's value is greater than or equal to 0 using _assertThat(metric.getValue().longValue())
  .isGreaterThanOrEqualTo(0)_.

By following these steps, the PerformanceMetricsTest class gathers performance metrics from the browser and logs them
for analysis. This functionality can help developers identify potential performance bottlenecks in their web
applications, leading to improved user experience and overall application performance.

## WebDriver BiDi

WebDriver BiDi (short for Bidirectional) is a modern, standardized protocol designed to enhance browser automation
capabilities and overcome the limitations of WebDriver and the Chrome DevTools Protocol (CDP). WebDriver BiDi enables
real-time, bidirectional communication between the client and browser, allowing for more granular control over the
browser's internal workings and improved responsiveness in automation tasks.

Some of the key features of WebDriver BiDi include:

* Support for multiple browser vendors: Unlike CDP, which is specific to Chromium-based browsers, WebDriver BiDi aims to
  provide a unified and standardized API across all major browsers, such as Chrome, Firefox, Safari, and Edge. This
  ensures consistent automation behavior and reduces the need for browser-specific code in test scripts.
* Improved stability and maintainability: WebDriver BiDi addresses the maintenance challenges associated with CDP by
  offering a more stable and standardized API that is less likely to change with each browser release. This reduces the
  need to update test scripts frequently and ensures better compatibility across browser versions.

As explained in the [Google article](https://developer.chrome.com/blog/webdriver-bidi/) all browser vendors are involved
in the specification process. Here are some of them:

* Apple
* BrowserStack
* Google
* Microsoft
* Mozilla
* Sauce Labs

The work is mostly done in the [GitHub repository](https://github.com/w3c/webdriver-bidi). There are monthly meetings
with all major browser vendors reporting actual progress and discussing arguable and unknown specifics. The
cross-companies working group makes sure the decisions are aligned with all stakeholders.

The Draft is [available here](https://w3c.github.io/webdriver-bidi/) and the adoption rate
is [visualized here](https://wpt.fyi/results/webdriver/tests/bidi?label=experimental&label=master&aligned&view=subtest).

### WebDriver BiDi support in Selenium

Selenium has embraced the WebDriver BiDi protocol as a key component of its browser automation capabilities. The
integration of WebDriver BiDi into Selenium aims to provide a more seamless and reliable automation experience for
developers, with improved control and stability compared to using the Chrome DevTools Protocol. By adopting WebDriver
BiDi, Selenium users can benefit from its advanced features and cross-browser support, ensuring more consistent and
maintainable test scripts for web applications.

### Listening to JavaScript errors in console

One notable example of WebDriver BiDi's capabilities is its complete logging API, which allows developers to listen to
JavaScript errors in the browser console. This feature is particularly useful for identifying and debugging issues in
your web application's JavaScript code during test execution. With WebDriver BiDi, you can monitor and capture these
errors in a standardized manner, regardless of the browser being used, providing a consistent and reliable approach to
error detection and handling.

The following tests show how to do it:

{% highlight java %}
public class LogInspectorTest extends LocalFirefoxTest {

   private static final String SELENIUM_CUSTOM_PAGE = "https://www.selenium.dev/selenium/web/bidi/logEntryAdded.html";

   private List<ConsoleLogEntry> consoleLogEntries;
   private List<JavascriptLogEntry> javascriptLogEntries;
   private List<JavascriptLogEntry> javascriptExceptions;

   @SuppressWarnings("resource")
   @BeforeEach
   public void setUp() {
       consoleLogEntries = new ArrayList<>();
       javascriptLogEntries = new ArrayList<>();
       javascriptExceptions = new ArrayList<>();
       LogInspector logInspector = new LogInspector(driver);
       logInspector.onJavaScriptLog(log -> javascriptLogEntries.add(log));
       logInspector.onConsoleEntry(log -> consoleLogEntries.add(log));
       logInspector.onJavaScriptException(log -> javascriptExceptions.add(log));
   }

   @SneakyThrows
   @Test
   void testListenToConsoleLog() {
       // given
       driver.get(SELENIUM_CUSTOM_PAGE);

       // when
       driver.findElement(By.id("consoleLog")).click();

       // then
       await().until(() -> consoleLogEntries.size() == 1);
       ConsoleLogEntry consoleLogEntry = consoleLogEntries.get(0);
       assertThat(consoleLogEntry.getText()).isEqualTo("Hello, world!");
       assertThat(consoleLogEntry.getRealm()).isNull();
       assertThat(consoleLogEntry.getType()).isEqualTo("console");
       assertThat(consoleLogEntry.getMethod()).isEqualTo("log");
       assertThat(consoleLogEntry.getStackTrace()).isNull();
   }

   @SneakyThrows
   @Test
   void testListenToJavascriptLog() {
       // given
       driver.get(SELENIUM_CUSTOM_PAGE);

       // when
       driver.findElement(By.id("jsException")).click();

       // then
       await().until(() -> javascriptLogEntries.size() == 1);
       JavascriptLogEntry javascriptLogEntry = javascriptLogEntries.get(0);
       assertThat(javascriptLogEntry.getText()).isEqualTo("Error: Not working");
       assertThat(javascriptLogEntry.getType()).isEqualTo("javascript");
       assertThat(javascriptLogEntry.getLevel()).isEqualTo(LogLevel.ERROR);
   }

   @SneakyThrows
   @Test
   void testListenToJavascriptErrorLog() {
       // given
       driver.get(SELENIUM_CUSTOM_PAGE);

       // when
       driver.findElement(By.id("jsException")).click();

       // then
       await().until(() -> javascriptExceptions.size() == 1);
       JavascriptLogEntry javascriptLogEntry = javascriptExceptions.get(0);
       assertThat(javascriptLogEntry.getText()).isEqualTo("Error: Not working");
       assertThat(javascriptLogEntry.getType()).isEqualTo("javascript");
   }

   @SneakyThrows
   @Test
   void testRetrieveStacktraceForALog() {
       // given
       driver.get(SELENIUM_CUSTOM_PAGE);

       // when
       driver.findElement(By.id("logWithStacktrace")).click();

       // then
       await().until(() -> javascriptExceptions.size() == 1);
       JavascriptLogEntry javascriptLogEntry = javascriptExceptions.get(0);
       assertThat(javascriptLogEntry.getStackTrace()).isNotNull();
       assertThat(javascriptLogEntry.getStackTrace().getCallFrames()).hasSize(4);
   }

}
{% endhighlight %}

The _LogInspectorTest_ class contains four test cases that demonstrate how to listen to and capture different types of
log entries in a web application using WebDriver BiDi. The test cases are designed to work with Firefox, as indicated by
the LocalFirefoxTest base class. The tests interact with a custom Selenium page containing buttons to trigger different
types of log entries.

* _testListenToConsoleLog_: This test navigates to the custom Selenium page, clicks the "consoleLog" button, and listens
  for a console log entry. It verifies that the captured console log entry contains the expected text, realm, type,
  method, and stack trace.
* _testListenToJavascriptLog_: This test navigates to the custom Selenium page, clicks the "jsException" button, and
  listens for a JavaScript log entry. It verifies that the captured JavaScript log entry contains the expected text,
  type, and log level.
* _testListenToJavascriptErrorLog_: This test navigates to the custom Selenium page, clicks the "jsException" button,
  and listens for a JavaScript error log entry. It verifies that the captured JavaScript error log entry contains the
  expected text and type.
* _testRetrieveStacktraceForALog_: This test navigates to the custom Selenium page, clicks the "logWithStacktrace"
  button, and listens for a JavaScript error log entry with a stack trace. It verifies that the captured JavaScript
  error log entry contains a non-null stack trace and the correct number of call frames.

These tests showcase how WebDriver BiDi can be used to monitor and capture various types of log entries in a web
application, providing valuable insights into the application's behavior and helping developers identify and debug
issues more efficiently.

## Summary: WebDriver BiDi over CDP

As the browser automation landscape evolves, it's essential for testers to understand the long-term implications of
using different protocols, such as the Chrome DevTools Protocol (CDP) and WebDriver BiDi. In the long run, it is
expected that support for CDP in Selenium will diminish, as WebDriver BiDi is explicitly designed to be the future of
browser automation.

WebDriver BiDi offers numerous advantages over CDP, including cross-browser support, stability, and maintainability.
This makes it the preferred choice for web application testing and automation. As a result, developers should be
cautious about overinvesting in CDP-based tests and instead prioritize adopting WebDriver BiDi wherever possible.

By focusing on WebDriver BiDi, developers can ensure that their test scripts remain relevant and compatible with future
browser releases, reducing the need for frequent updates and maintenance. Additionally, WebDriver BiDi's standardized
API allows for a more consistent automation experience across different browsers, further enhancing the reliability and
robustness of your test suite.

In conclusion, while CDP has served as a valuable tool for browser automation and testing, its limitations and
browser-specific nature make it less suitable for long-term use. WebDriver BiDi, on the other hand, represents the
future of browser automation, with its cross-browser support and stable API. By embracing WebDriver BiDi and
transitioning away from CDP, developers can ensure that their test scripts remain relevant, maintainable, and compatible
with the ever-evolving world of web browsers.

## Java examples

In this blog post, I have explored various browser automation concepts, including Chrome DevTools Protocol (CDP) and
WebDriver BiDi. To help you better understand and implement these concepts, I have created a repository on GitHub
containing practical Java examples for both CDP and WebDriver BiDi.

You can access the repository at the following link:  
[https://github.com/slawekradzyminski/seleniumjava](https://github.com/slawekradzyminski/seleniumjava)

The repository contains examples for both CDP and WebDriver BiDi, demonstrating their capabilities and usage in
real-world scenarios. Please note that some of these examples require a Selenium Grid running locally. To help you set
up the local Selenium Grid, I have included a [docker-compose.yml](http://docker-compose.yml) file in the repository,
which allows you to easily create a grid using [Docker](https://www.docker.com/).

By exploring the provided examples, you can gain hands-on experience working with CDP and WebDriver BiDi in Selenium and
learn how to harness their full potential in your web application testing and automation efforts.
