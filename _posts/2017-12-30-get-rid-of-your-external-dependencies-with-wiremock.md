---
title: Get rid of your external dependencies with WireMock
layout: post
permalink: /2017/12/get-rid-of-your-external-dependencies
categories:
  - API testing
tags:
  - API testing
  - security
---

![](/images/blog/wiremock.jpg)

So far in my posts focusing on [API testing](http://www.awesome-testing.com/search/label/API%20testing) I was using
external services only. This isn't particularly bad for higher level tests, but sometimes we would like to work on our
localhosts only. This eliminates potential flakiness related to network fluctuations, deployment being in progress or
general instability of services we rely on. Today I'd like to recommend you one tool that hugely simplifies our quest
for testing an app in total isolation - [WireMock](http://wiremock.org/). It's not a tool just got released and doesn't
work for anyone except the author, it's more like established industry standard used by many companies (including
Pivotal).

I read once that someone didn't like my Rest Assured post. Reader was claiming that it's too old framework to show on
blogs. The thing is I want my readers to learn valuable stuff and reuse
my [GitHub examples](https://github.com/slawekradzyminski/AwesomeTesting) so I don't want to change my approach in '
technical' posts. My general recommendation regarding tools is pretty much aligned with what I present here: always
choose older and more popular one unless you are 100% sure that new 'cutting-edge' tool is indeed that
great. [Gatling](https://gatling.io/) is perfect example of that. I know a lot of people who thought it brilliant, but
upon problems with more complex scenarios gave it up and came back to[JMeter](http://jmeter.apache.org/) instead.

## Getting started

As usual, we need to add Maven dependency first. I'm including also javax.json library for simple JSON creation, but you
can choose what you want here.

{% highlight xml %}
        <dependency>
            <groupId>javax.json</groupId>
            <artifactId>javax.json-api</artifactId>
            <version>1.1.2</version>
        </dependency>

        <dependency>
            <groupId>org.glassfish</groupId>
            <artifactId>javax.json</artifactId>
            <version>1.1.2</version>
        </dependency>

        <dependency>
            <groupId>com.github.tomakehurst</groupId>
            <artifactId>wiremock</artifactId>
            <version>2.12.0</version>
view raw
{% endhighlight %}

Unfortunately I had also a lot of problem with my classpath. WireMock uses jetty server 9.22 which is pretty old. This
generates conflicts with selenium-java so I had to add a lot of ugly exclusions in my pom.
See [commit](https://github.com/slawekradzyminski/AwesomeTesting/commit/fec306d18285dc79f6fa24dc80e620c3871d46b4) for
details. This may happen for you so get ready to analyse your _mvn dependency:tree_.

## Framework preparation

A bit of side note first: I often hear that testers would like have some kind of online portfolio available publicly. I
recommend to follow my path and integrate blogging with coding. It gives me a lot of online presence with relatively
small effort. As a bonus I guarantee you that even with such a simple tests you would learn something extra for
yourself.

End of chit-chat, now real stuff.

First of all opposite to what I usually do I'll be using Junit. By the way there is definitely not a good idea to mix
TestNG and Junit in on project. My IntelliJ was struggling to choose proper framework automatically and I had to choose
import after every @Test. Do yourself a favor and don't follow my path - chose Junit from start ;)

I chose to use hierarchical approach in my tests. This class would be extended by each Test class.

There are three methods:

- JUnit WireMock @Rule starts server on random port (it's important to randomize it because it allows us to run tests
simultaneously).

- We set port for RestAssured baseUrl (it would be http://localhost: + this port)

- We cleanUp stubs after each test

{% highlight java %}
public class WireMockTest {

    @Rule
    public WireMockRule wireMockRule =
            new WireMockRule(wireMockConfig().dynamicPort().portNumber());

    @Before
    public void configureRestAssured() {
        RestAssured.port = wireMockRule.port();
        RestAssured.registerParser(JSON.toString(), Parser.JSON);
    }

    @After
    public void cleanUp() {
        wireMockRule.resetAll();
    }

}
{% endhighlight %}

## Simple examples

I have prepared three very simple scenarios. Please take a look at @Before section. That's where all the WireMock magic
happens. We can define what kind of requests would be captured and how WireMock would respond for them. In this example
GET request for http://localhost:port/ip returns JSON defined in `getMockedIpEndpointJson()` method.

For actual request sending I'm using [RestAssured](http://rest-assured.io/) which is familiar for my readers.

As you can see WireMock allows us to build requests in almost the same way as RestAssured. Those two frameworks make
great duo.

{% highlight java %}
public class BasicGetTest extends WireMockTest {

    @Before
    public void setUp() {
        stubFor(get(urlEqualTo("/ip"))
                .withHeader("Accept", equalTo(JSON.toString()))
                .willReturn(aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", JSON.toString())
                        .withBody(getMockedIpEndpointJson())));
    }

    private String getMockedIpEndpointJson() {
        return Json.createObjectBuilder()
                .add("ip", "127.0.0.1")
                .build().toString();
    }

    @Test
    public void ipTest() {
        given()
                .contentType(JSON)
                .header("Accept", JSON.toString())
                .when()
                .get("/ip")
                .then()
                .body("ip", containsString("127.0.0.1"));
    }
{% endhighlight %}

Second test is almost identical, but contains more complex assertions.

{% highlight java %}
public class StaffTest extends WireMockTest {

    private static final String EMPLOYEES = "employees";
    private static final String MANAGER = "managers";
    private static final String FIRST_NAME = "firstName";
    private static final String LAST_NAME = "lastName";

    @Before
    public void setUp() {
        stubFor(get(urlEqualTo("/staff"))
                .withHeader("Accept", equalTo(JSON.toString()))
                .willReturn(aResponse()
                        .withStatus(200)
                        .withHeader("Content-Type", JSON.toString())
                        .withBody(getMockedStaffEndpointJson())));
    }

    private String getMockedStaffEndpointJson() {
        return Json.createObjectBuilder()
                .add(EMPLOYEES, Json.createArrayBuilder()
                        .add(Json.createObjectBuilder()
                                .add(FIRST_NAME, "John").add(LAST_NAME, "Doe"))
                        .add(Json.createObjectBuilder()
                                .add(FIRST_NAME, "Jessica").add(LAST_NAME, "Alba"))
                        .add(Json.createObjectBuilder()
                                .add(FIRST_NAME, "Emma").add(LAST_NAME, "Stone")))
                .add(MANAGER, Json.createArrayBuilder()
                        .add(Json.createObjectBuilder()
                                .add(FIRST_NAME, "Janusz").add(LAST_NAME, "Biznesu")))
                .build().toString();
    }

    @Test
    public void staffTest() {
        given()
                .contentType(JSON)
                .header("Accept", JSON.toString())
                .when()
                .get("/staff")
                .then()
                .body("employees[0].lastName", containsString("Doe"))
                .body("employees.size()", is(3))
                .body("managers.size()", is(1))
                .body("employees.firstName", containsInAnyOrder("John", "Jessica", "Emma"));
    }

}
{% endhighlight %}

Last but not least we can of course use POST, PUT, DELETE methods. Here is rather silly POST example.

{% highlight java %}
public class BasicPostTest extends WireMockTest {

    @Before
    public void setUp() {
        stubFor(post(urlEqualTo("/addPerson"))
                .withHeader("Accept", equalTo(JSON.toString()))
                .withRequestBody(equalToJson(getUserJson()))
                .willReturn(ok()));
    }

    private String getUserJson() {
        return Json.createObjectBuilder()
                .add("firstName", "Slawomir")
                .add("lastName", "Radzyminski")
                .add("age", "18")
                .build().toString();
    }

    @Test
    public void postTest() {
        given()
                .contentType(JSON)
                .header("Accept", JSON.toString())
                .body(getUserJson())
                .when()
                .post("/addPerson")
                .then()
                .statusCode(SC_OK);
    }

}
{% endhighlight %}

Isn't it beautiful? :)
