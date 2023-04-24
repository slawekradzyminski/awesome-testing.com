---
title: Rest Assured integration tests for jsontest.com
layout: post
permalink: /2017/06/rest-assured-integration-tests-for
categories:
  - API testing
tags:
  - API testing 
---


![](/images/blog/name-transparent.png)

In my very
popular [Tester's toolbox - an alternative guide](http://www.awesome-testing.com/2016/04/testers-toolbox-alternative-guide.html)
I listed few examples of free public APIs that can be used for learning Rest Assured. Recently I have found one more
site - [www.jsontest.com](http://www.jsontest.com/). Having in mind that my
last [API test post](http://www.awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html) was almost
exactly one year ago I decided to utilize my latest finding and show you few
examples. [JSON Test ](http://www.jsontest.com/)API has few excellent functionalities for people who want to learn.

In order to use Rest Assured in your Maven project add this dependency:

{% highlight xml %}
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>rest-assured</artifactId>
            <version>3.0.3</version>
        </dependency>
{% endhighlight %}

## Rest Assured GET examples

As a nice beginning I suggest to test [ip.jsontest.com](http://ip.jsontest.com/). This endpoint prints your current IP
address. Here is simple test case that looks pretty much like copy/paste from
excellent [getting started guide](https://github.com/rest-assured/rest-assured/wiki/GettingStarted). Please note that
you would most likely have to update partOfMyIp String.

{% highlight java %}
    @Test
    public void ipTest() {
        String partOfMyIp = "142";

        given().contentType(JSON)
                .when().get("http://ip.jsontest.com")
                .then()
                .body("ip", containsString(partOfMyIp));
    }
{% endhighlight %}

Second endpoint - [date.jsontest.com](http://date.jsontest.com/)returns date in three formats. Dealing with a time in
tests can be tricky (flaky) so I decided to assert only date in MM-dd-yyyy format.

{% highlight java %}
    @Test
    public void dateTest() {

        Date date = new Date();
        String dateMMddyyyy = new SimpleDateFormat("MM-dd-yyyy").format(date);

        given().contentType(JSON)
                .when().get("http://date.jsontest.com")
                .then()
                .body("date", equalTo(dateMMddyyyy));
    }
{% endhighlight %}

There is also [echo.jsontest.com/key/value/one/two](http://echo.jsontest.com/key/value/one/two)endpoint that gets the
values from URL.

{% highlight java %}
    @Test
    public void mirrorTest() {

        String firstKey = "firstKey";
        String firstValue = "firstValue";
        String secondKey = "secondKey";
        String secondValue = "secondValue";

        given().contentType(JSON)
                .when().get(format("http://%s/%s/%s/%s/%s",
                "echo.jsontest.com", firstKey, firstValue, secondKey, secondValue))

                .then()
                .body(firstKey, equalTo(firstValue))
                .body(secondKey, equalTo(secondValue));
    }
{% endhighlight %}

Another endpoint - [cookie.jsontest.com](http://cookie.jsontest.com/)sets the cookie as response. Here is the test that
asserts if the cookie was set.

{% highlight java %}
    @Test
    public void cookieTest() {
        given().contentType(JSON)
                .when().get("http://cookie.jsontest.com")
                .then()
                .cookie("jsontestdotcom", is(notNullValue()));
    }
{% endhighlight %}

The most fun you may get from [headers.jsontest.com](http://headers.jsontest.com/). This endpoint reads headers from your
request and prints them in response. I decided to send XML with UTF-8 enconding and assert Content Type.

{% highlight java %}
    @Test
    public void printSentHeaders() {

        RestAssuredConfig utf8Config
                = RestAssured.config()
                  .encoderConfig(encoderConfig().defaultContentCharset("UTF-8"));

        given().config(utf8Config).contentType(XML)
                .when().get("http://headers.jsontest.com")
                .then()
                .body("Content-Type", equalTo("application/xml; charset=UTF-8"));
    }
{% endhighlight %}

## Rest Assured POST examples

Those were GET examples. Now we would use POST method and send some data. Please note that .queryParam() method has to
be defined in given() section which is a little bit strange for me. I'd rather code that in when() section after
providing url.

First endpoint -[md5.jsontest.com/?text=text](http://md5.jsontest.com/?text=text)takes your text and returns it together
with calculated md5 checksum.

{% highlight java %}
    @Test
    public void shouldPrintMd5() {
        String myRandomText = "My random text";
        String md5 = md5Hex(myRandomText);

        given().contentType(JSON)
                .queryParam("text", myRandomText)
                .when().post("http://md5.jsontest.com")
                .then()
                .body("md5", equalTo(md5))
                .body("original", equalTo(myRandomText));
    }
{% endhighlight %}

Final endpoint which I decided to test is[validate.jsontest.com](http://validate.jsontest.com/). It takes 'json'
queryParam value and validates if it's parse-able (i.e. if it's correctly formatted json). Below is simple happy path:

{% highlight java %}
    @Test
    public void postSuccessfulBasicValidationTest() {
        String parsableJson = "{\"key\":\"value\"}";

        given().contentType(JSON)
                .queryParam("json", parsableJson)
                .when().post(" http://validate.jsontest.com")
                .then()
                .body("validate", equalTo(true));
    }
{% endhighlight %}

And negative path:

{% highlight java %}
    @Test
    public void postFailedValidationTest() {
        String nonParsableJson = "{\"key\":\"value";

        given().contentType(JSON)
                .queryParam("json", nonParsableJson)
                .when().post(" http://validate.jsontest.com")
                .then()
                .body("validate", equalTo(false));
    }
{% endhighlight %}

As usual all code from this post (+1 extra test) and from my
previous [Rest Assured Post ](http://www.awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html)is
available on my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting).
