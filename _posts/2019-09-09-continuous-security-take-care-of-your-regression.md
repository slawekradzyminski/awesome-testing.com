---
title: Continuous Security - take care of your regression
layout: post
permalink: /2019/09/continuous-security-take-care-of-your
categories:
  - Security
tags:
  - security
  - API testing 
---

![](/images/blog/photo-1519575706483-221027bfbb31.jpeg)

In my
last '[Continuous Security - how to get involved](https://www.awesome-testing.com/2019/08/continuous-security-how-to-get-involved.html)?'
post I showed you quickstart guide on how to start helping your team in reaching the desired security level. The article
contained simple [OWASP ZAP](https://www.awesome-testing.com/2018/12/continuous-security-with-owasp-zap.html) scanning
technique and very
easy [Rest Assured](https://www.awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html) tests which
were ensuring HTTP headers presence. Today I'll focus on yet another avenue where testers can excel: regression testing.

Software testing can never prove that application under test contains no bugs. Even if we spend a significant amount of
time doing all things correctly, bugs may still get through. It's a good practice to add automated tests which check
that bugs found on production can never happen again. Security bugs are no different. Once detected, they should never
happen again.

As usual, there will be a practical demo explaining a theory in action.

## OWASP Juice Shop

[OWASP Juice Shop](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project) will be an application under test.
According to the official description, it's the most modern and sophisticated insecure web application. It can be used
in security training, awareness demos, CTFs and as a guinea pig for security tools. Juice Shop encompasses
vulnerabilities from the entire [OWASP Top Ten](https://www.owasp.org/index.php/OWASP_Top_Ten)along with many other
security flaws found in real-world applications.

WARNING: This article contains spoilers for existing vulnerabilities in Juice Shop. If you prefer to find them by
yourself come back here later.

## Rest Template

Just to change things a bit we will use Spring Rest Template. If you are not familiar with this library I
recommend [Baeldung tutorial](https://www.baeldung.com/rest-template). A more complete description can be found
in [Spring in Action](https://www.amazon.com/Spring-Action-Craig-Walls/dp/1617294942) book.

To start we need to add a couple of dependencies:

a) [Spring web](https://docs.spring.io/spring/docs/5.1.9.RELEASE/spring-framework-reference/integration.html#rest-client-access)
for core Rest Template methods

b) [Jackson](https://github.com/FasterXML/jackson) for Java JSON serialization

c) [JSON-Java](https://github.com/stleary/JSON-java)

{% highlight xml %}
<dependency>
<groupId>org.springframework</groupId>
<artifactId>spring-web</artifactId>
<version>5.1.9.RELEASE</version>
</dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.9.9.3</version>
        </dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-annotations</artifactId>
            <version>2.9.9</version>
        </dependency>
        
        <dependency>
            <groupId>org.json</groupId>
            <artifactId>json</artifactId>
            <version>20190722</version>
        </dependency>

{% endhighlight %}

Each test will require simple setup. Juice Shop runs on default port 3000.

{% highlight java %}
private RestTemplate restTemplate;

    @Before
    public void setUp() {
        restTemplate = new RestTemplate();
        restTemplate.setUriTemplateHandler(
                new DefaultUriBuilderFactory("http://localhost:3000"));
    }

{% endhighlight %}

## Vulnerability a - client-side error

The secure application should never show internal errors to end-user. It does not only create a terrible user experience
for the customer but also leaves a risk of exposing sensitive data. Attacker benefits a lot in such a situation because
he can understand what's going on internally on server-side.

When we try to log in as an inexisting user we receive HTTP 401 which is correct.

{% highlight java %}
@Test
public void shouldNotBeAbleToLoginOnInexisingUser() {
LoginDto loginDto = new LoginDto(INVALID_LOGIN, PASSWORD);
HttpEntity<LoginDto> body = new HttpEntity<>(loginDto);
assertThatThrownBy(() -> restTemplate.postForEntity(LOGIN_ENDPOINT, body, String.class))
.isInstanceOf(HttpClientErrorException.class)
.hasMessageContaining("401 Unauthorized");
}
{% endhighlight %}

However when we use ' as login server responds with HTTP 500 and exposes implementation details.

![](/images/blog/error_js-console.png)

The following test reproduces this vulnerability:

{% highlight java %}
private static final String REDIRECTION_URL = "https://awesome-testing.com";

    @Test
    public void shouldNotFollowRedirectWithWhitelistedUrl() {
        assertThatThrownBy(
            () -> restTemplate.getForEntity(getRedirectionUrlWithWhitelistedUrl(), String.class))
                .isInstanceOf(HttpClientErrorException.class)
                .hasMessageContaining("406 Not Acceptable");
    }

    private String getRedirectionUrlWithWhitelistedUrl() {
        return String.format(
            "/redirect?to=%s?pwned=https://github.com/bkimminich/juice-shop", REDIRECTION_URL);
    }

{% endhighlight %}

## Vulnerability b - open redirect

Juice shop allows for redirection on a whitelisted [GitHub page](https://github.com/bkimminich/juice-shop). When we try
to change this URL application correctly blocks us with HTTP 406.

{% highlight java %}
private static final String REDIRECTION_URL = "https://awesome-testing.com";

    @Test
    public void shouldNotFollowRedirect() {
        assertThatThrownBy(
            () -> restTemplate.getForEntity(getRedirectionUrl(), String.class))
                .isInstanceOf(HttpClientErrorException.class)
                .hasMessageContaining("406 Not Acceptable");
    }
    
    private String getRedirectionUrl() {
        return String.format("/redirect?to=%s", REDIRECTION_URL);
    }

{% endhighlight %}

Unfortunately whitelisting isn't implemented on _to_ parameter but on any of them. Adding a dummy parameter meeting
whitelisting criteria results in redirection to any website.

The following test reproduces this vulnerability:

{% highlight java %}
private static final String REDIRECTION_URL = "https://awesome-testing.com";

    @Test
    public void shouldNotFollowRedirectWithWhitelistedUrl() {
        assertThatThrownBy(
            () -> restTemplate.getForEntity(getRedirectionUrlWithWhitelistedUrl(), String.class))
                .isInstanceOf(HttpClientErrorException.class)
                .hasMessageContaining("406 Not Acceptable");
    }

    private String getRedirectionUrlWithWhitelistedUrl() {
        return String.format(
            "/redirect?to=%s?pwned=https://github.com/bkimminich/juice-shop", REDIRECTION_URL);
    }

{% endhighlight %}

## Vulnerability 3 - admin access

The last vulnerability is probably the worst one. An attacker can prepare JSON request which will register him as shop
admin. Only a couple of Java code lines are required!

{% highlight java %}
@Test
public void shouldNotBeAbleToRegisterAsAdmin() {
AdminRegisterDto adminRegisterDto = new AdminRegisterDto();
JSONObject jsonObj = new JSONObject(adminRegisterDto);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> body = new HttpEntity<>(jsonObj.toString(), headers);

        assertThatThrownBy(
                () -> restTemplate.postForEntity("/api/Users", body, AdminRegisterResultDto.class))
                .isInstanceOf(HttpClientErrorException.class)
                .hasMessageContaining("401 Unauthorized");
    }

{% endhighlight %}

## Summary

I didn't delve too deep into why those bugs exist (although it's perfectly reasonable for you to do a root cause
analysis in a similar situation) or how those tests implementation (details on
my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting)). I just wanted to you show a certain mindset.
If there is a bug on production you should think how to avoid it next time, but also add a regression tests just to make
sure it never happens again. For security bugs there is an additional benefit, you expand your knowledge in much-needed
field!
