---
title: How to Download files using Selenium 2
layout: post
permalink: /2016/06/how-to-download-files-using-selenium-2
categories:
  - Selenium
tags:
  - selenium
  - testing
  - fluentlenium
  - test automation
  - UI testing 
---

![](/images/blog/downloading-001.png)

In my previous post
about [Selenium](http://awesome-testing.blogspot.com/2016/02/selenium-browser-capabilities-explained.html), I explained
how can we modify browsers before tests to have the desired configuration. Today I like to discuss a different topic
that lacks quality guides - downloading files. Mixing Selenium with AutoIT isn't good, trust me.

I'm using [FluentLenium](http://awesome-testing.blogspot.com/2016/01/introducing-fluentlenium-1.html) syntax to navigate
on the page (that would be Micheal Bolton's [homepage](http://www.developsense.com/) to be more precise), but it's very
intuitive, and you shouldn't have any problems rewriting it on Selenium. I borrowed some code
from [Mastering Selenium WebDriver](http://www.amazon.com/Mastering-Selenium-WebDriver-Mark-Collin/dp/1784394351) book,
which I once again recommend.

Testers who don't understand HTTP protocol usually get stuck with 'Are you sure you want to download this file?' popup.
The thing is, it's just internal browser implementation and we don't have to test it. We are going to bypass it
completely. I'll give you 4 examples of how can you test it. Make a risk assessment and decide which one would be
appropriate for your site. The first one is the fastest, and the last one is the slowest.

## Checking that file is available on given address

We will not only bypass the browser's download handling mechanism, but we won't use Selenium too. It's
just [HttpClient](https://hc.apache.org/httpcomponents-client-ga/tutorial/pdf/httpclient-tutorial.pdf) request and
response code verification (we expect 200 -> SC_OK). We don't verify that the user sees the link and can click on it.

{% highlight java %}
    @Test
    public void downloadNoSelenium() throws URISyntaxException, IOException {
        Request request = new Request();
        String linkToCheck = "http://www.developsense.com/courses/RapidSoftwareTesting.pdf";
        request.setURIToCheck(linkToCheck);
        assertThat(request.getHTTPStatusCodeFromResponse()).isEqualTo(SC_OK);
    }
{% endhighlight %}

And here is HttpClient implementation. Quite a few lines, I know.

{% highlight java %}
class Request {

    private URI linkToCheck;
    private WebDriver driver;

    Request() {
    }

    void setURIToCheck(String linkToCheck) throws URISyntaxException {
        this.linkToCheck = new URI(linkToCheck);
    }

    int getHTTPStatusCodeFromResponse() throws IOException {
        return getHttpResponse().getStatusLine().getStatusCode();
    }

    private HttpResponse getHttpResponse() throws IOException {
        HttpClient client = initializeHttpClient();
        BasicHttpContext httpContext = new BasicHttpContext();
        if (driver != null) {
            addCookies(httpContext);
        }
        HttpRequestBase request = buildRequest();

        return client.execute(request, httpContext);
    }

    private HttpClient initializeHttpClient() {
        return HttpClientBuilder
                .create()
                .setRedirectStrategy(new LaxRedirectStrategy())
                .build();
    }

    private HttpRequestBase buildRequest() {
        HttpRequestBase requestMethod = new HttpGet();
        requestMethod.setURI(this.linkToCheck);

        return requestMethod;
    }
}
{% endhighlight %}

## Checking that file is available for real user

Now we would simulate the real user. We are going to get a URL from the existing site selector and add user cookies to
HTTP requests. Note that only getUrlFromSite() method uses FluentLenium. That's the class you need to modify to make it
work in clean Selenium.

{% highlight java %}
public class FileDownloadTest extends FluentTestNg {

    private static final String FILE_TO_DL_SELECTOR = "ul li a";
    private static final String URL = "http://www.developsense.com";

    @Test
    public void statusCode200() throws IOException, URISyntaxException {
        Request request = prepareRequest();
        assertThat(request.getHTTPStatusCodeFromResponse()).isEqualTo(SC_OK);
    }
    
    private Request prepareRequest() throws MalformedURLException, URISyntaxException {
        String fileUrl = getUrlFromSite();
        Request request = new Request(getDriver());
        request.setURIToCheck(fileUrl);
        return request;
    }

    private String getUrlFromSite() {
        goTo(URL);
        await().until(FILE_TO_DL_SELECTOR).isEnabled();
        return findFirst(FILE_TO_DL_SELECTOR).getAttribute("href");
    }
}
{% endhighlight %}

There is a very nice method that I found in Mastering Selenium WebDriver book. It copies all the cookies and adds to the
request. It's a Request.class extension required to make our test pass.

{% highlight java %}
     Request(WebDriver driver) {
        this.driver = driver;
    }
    
     private void addCookies(BasicHttpContext httpContext) {
        BasicCookieStore cookies = getCurrentDriverCookies(driver.manage().getCookies());
        httpContext.setAttribute(HttpClientContext.COOKIE_STORE, cookies);
    }

    private BasicCookieStore getCurrentDriverCookies(Set<Cookie> cookies) {
        BasicCookieStore mimicWebDriverCookieStore = new BasicCookieStore();
        for (Cookie seleniumCookie : cookies) {
            BasicClientCookie duplicateCookie = new BasicClientCookie(seleniumCookie.getName(), seleniumCookie.getValue());
            duplicateCookie.setDomain(seleniumCookie.getDomain());
            duplicateCookie.setSecure(seleniumCookie.isSecure());
            duplicateCookie.setExpiryDate(seleniumCookie.getExpiry());
            duplicateCookie.setPath(seleniumCookie.getPath());

            mimicWebDriverCookieStore.addCookie(duplicateCookie);
        }

        return mimicWebDriverCookieStore;
    }
{% endhighlight %}

##  Checking that file isn't empty

Now we would download the file and check that it isn't empty. Have in mind that this approach applies to small files.

{% highlight java %}
    @Test
    public void getDownload() throws Exception {
        Request request = prepareRequest();
        File downloadedFile = request.downloadFile();
        assertThat(downloadedFile).isNotNull();
    }
{% endhighlight %}

And that's the downloadFile() method from Request.class.

{% highlight java %}
    File downloadFile() throws Exception {
        File downloadedFile = File.createTempFile("download", ".tmp");
        HttpResponse fileToDownload = getHttpResponse();
        FileUtils.copyInputStreamToFile(fileToDownload.getEntity().getContent(), downloadedFile);

        return downloadedFile;
    }
{% endhighlight %}

## Checking that we download the correct file

And finally the most reliable approach. We would not only download the file but also check it's md5 checksum.

{% highlight java %}
    private static final String EXPECTED_MD5 = "c3fb273e2843808968d68120121f2c74";
 
    @Test
    public void getDownloadPlusMd5() throws Exception {
        Request request = prepareRequest();
        File downloadedFile = request.downloadFile();
        assertThat(calculateMd5(downloadedFile)).isEqualTo(EXPECTED_MD5);
    }
    
     private String calculateMd5(File downloadedFile) throws IOException {
        FileInputStream fis = new FileInputStream(downloadedFile);
        String md5 = md5Hex(fis);
        fis.close();
        
        return md5;
    }
{% endhighlight %}

If you prefer to read code only, here is everything:

- [Request.class](https://gist.github.com/slawekradzyminski/7d503a49db1b38f6988aa71310d99b01)

- [DownloadNoSelenium.class](https://gist.github.com/slawekradzyminski/7d6d222e9e299c0eaf9c5085db01c00c)

- [FileDownloadTest.class](https://gist.github.com/slawekradzyminski/9327458e8d35b518ee5501196c6e0f88)
