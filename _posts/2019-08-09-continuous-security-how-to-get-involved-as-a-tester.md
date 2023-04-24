---
title: Continuous Security - how to get involved as a tester?
layout: post
permalink: /2019/08/continuous-security-how-to-get-involved
categories:
  - Security
tags:
  - security
  - API testing 
---

![](/images/blog/photo-1514302240736-b1fee5985889.jpeg)

**Introduction**

As you may have already noticed I often drift into the security domain. My interests focus mainly on continuous
security (i.e. automated security tests). So far I had featured three tools on my
blog: [OWASP Dependency-Check](https://www.awesome-testing.com/2017/02/continuous-security-with-owasp.html), [OWASP ZAP](https://www.awesome-testing.com/2018/12/continuous-security-with-owasp-zap.html),
and [Find-Sec-Bugs](https://www.awesome-testing.com/2018/11/continuous-security-with-find-sec-bugs.html) and showed how
to use Selenium to automate
your [XSS tests](https://www.awesome-testing.com/2017/11/automate-your-xss-tests-with-selenium.html).

When I talk to my peers on various testing meetups I'm often surprised how rarely professional testers engage in
security-related work. Throughout my activities, I try to debunk the myth that application security should be dealt with
exclusively by full-time professionals. Of course, I'm far from saying that their work is not
needed ([quite contrary actually](https://www.awesome-testing.com/2017/03/automated-testing-vs-manual-testing.html)),
but testers should start to get themselves involved. I predict that companies will soon start to
put [OWASP Top 10](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) knowledge as a job requirement for
testing positions.

**How to get involved?**

As with almost everything in life we need to start somewhere. How? Perhaps with the already
featured [OWASP ZAP](https://www.awesome-testing.com/2018/12/continuous-security-with-owasp-zap.html). First, run an
automated scan against your application. If you don't have any
use [OWASP Juice Shop](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project).

![](/images/blog/Screenshot%2B2019-08-31%2Bat%2B12.29.25.png)

Most likely even with the simplest possible scan, you will be able to find vulnerabilities and things you can improve to
make your application more secure. Here is sample output
from [OWASP Juice Shop](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project).

![](/images/blog/Screenshot%2B2019-08-31%2Bat%2B12.45.27.png)

Today I'll focus on hardening (improving security)
with [security headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers). In the next post, I'll analyze what
to do as a tester when an actual vulnerability has been found.

**Hardening**

If you take a look at my blog response headers you may find two security
headers: [X-Xss-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection)
and [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options). Check it
in browser developer tools though, scanning Blogger via OWASP ZAP is illegal.

It's usually a good idea to add a cheap API test just to make sure headers do not disappear during development. Let's
use the newly
released [Rest-Assured](https://www.awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html) 4.0.0
framework for that purpose.

At first, it's good to list application endpoints we want to check. For me, it will be:

{% highlight java %}
abstract class AbstractSecurityHeaderTest {

    static final List<String> CHECKED_URLS = ImmutableList.of(
            "https://www.awesome-testing.com",
            "https://www.awesome-testing.com/search/label/security",
            "https://www.awesome-testing.com/2019/06/throttling-network-in-selenium-tests.html",
            "https://www.awesome-testing.com/2017/"
    );

}
{% endhighlight %}

Test for X-Xss-Protection (header which enables cross-site scripting filtering):

{% highlight java %}
    @Test
    public void shouldHaveXssProtectionHeader() {
        CHECKED_URLS.forEach(url -> {
            String header = given()
                    .when()
                    .get(url)
                    .then()
                    .extract()
                    .header("x-xss-protection");

            assertThat(header)
                    .isNotNull()
                    .isEqualTo("1; mode=block");
        });
    }
{% endhighlight %}

And X-Content-Type-Options (header which disables MIME sniffing and forces browser to use the type given in
Content-Type):

{% highlight java %}
    @Test
    public void shouldHaveContentTypeHeader() {
        CHECKED_URLS.forEach(url -> {
            String header = given()
                    .when()
                    .get(url)
                    .then()
                    .extract()
                    .header("x-content-type-options");

            assertThat(header)
                    .isNotNull()
                    .isEqualTo("nosniff");
        });
    }
{% endhighlight %}

Tests are really simple. If you have trouble understanding them please take a look at
my [Rest-Assured](https://www.awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html) introduction.

**TDD?**

Let's assume now that for some reason my blog needs to
meet [PCI requirements](https://tidalcommerce.com/learn/merchant-levels-of-pci-compliance) and I have to add two more
headers:

a) [Strict-Transport-Security/HSTS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security) (
header which forces communication using HTTPS instead of HTTP)

b) [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) (header which indicates
whether a browser should be allowed to render a page in a frame, iframe, embed or object)

In TDD fashion, I can start the work with the acceptance test. Developer job to add such header would be much easier
now.

a) HSTS

{% highlight java %}
    @Test
    public void shouldHaveHstsHeader() {
        CHECKED_URLS.forEach(url -> {
            String header = given()
                    .when()
                    .get(url)
                    .then()
                    .extract()
                    .header("strict-transport-security");

            assertThat(header)
                    .isNotNull()
                    .isEqualTo("max-age=31536000; includeSubDomains");
        });
    }
{% endhighlight %}

b) X-Frame-Options

{% highlight java %}
    @Test
    public void shouldHaveXFrameOptionsHeader() {
        CHECKED_URLS.forEach(url -> {
            String header = given()
                    .when()
                    .get(url)
                    .then()
                    .extract()
                    .header("x-frame-options");

            assertThat(header)
                    .isNotNull()
                    .isEqualTo("deny");
        });
    }
{% endhighlight %}

Simple, right? :)

As usual, all code can be found on
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting/commit/020d6e6de756beb21510ef91659b4b0d6e679ecf).
If you would like to support this blog please join 38 stargazers for a repository. Thank you.
