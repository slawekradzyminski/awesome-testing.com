---
title: RESTful API Testing with Rest-Assured (1)
layout: post
permalink: /2016/07/restful-api-testing-with-rest-assured-1
categories:
  - API testing
tags:
  - rest-assured
  - API testing
  - test automation 
---

![](/images/blog/Rest-Assured-new-brand-identity-lr.jpg)

Before I start writing about API testing let me announce the big news. I released all my Selenium related Java code
snippets on [the Github Awesome Testing](https://github.com/slawekradzyminski/AwesomeTesting) project. I will update it
with every new technical post (including this one - the Rest-Assured tests were already
pushed [here](https://github.com/slawekradzyminski/AwesomeTesting/tree/master/src/test/java/restassuredjsonplaceholder)).
You can follow it and just type _'git pull'_ to get the latest code updates. From my experience, it's always better to
check how things work with IDE/Maven support.

Some time ago in
my [Tester's toolbox - an alternative guide](http://awesome-testing.com/2016/04/testers-toolbox-alternative-guide.html)
post I recommended you online resources on which you can train your testing
skills. [JSONplaceholder](http://jsonplaceholder.typicode.com/) is a perfect example of free RESTful API which can be
utilized for improving API testing skills. In this post, I'll show you how to write tests
in [the Rest Assured](https://github.com/rest-assured/rest-assured) framework.

## Getting started

Rest-Assured tests follow Behaviour-Driven Development _given, when, then_ approach.
As [Martin Fowler](http://martinfowler.com/bliki/GivenWhenThen.html) nicely explained it:

> The essential idea is to break down writing a scenario (or test) into three sections:
>
> * The **given** part describes the state of the world before you begin the behavior you're specifying in this
    scenario. You can think of it as the pre-conditions to the test.
>
> * The **when** section is that behavior that you're specifying.
>
> * Finally the **then** section describes the changes you expect due to the specified behavior.

To use Rest-Assured, you need to add the following libraries to your project.

{% highlight xml %}

{% endhighlight %}

## Writing the first test

Before I start let me explain the convention that I use for Rest-Assured tests. Basically, I split scenarios into two
classes:

a) The first one, called NameAPI (for
example [JsonPlaceholderAPI](https://github.com/slawekradzyminski/AwesomeTesting/blob/master/src/test/java/restassuredjsonplaceholder/utils/JsonPlaceholderAPI.java))
is responsible for defining requests (**given**+ **when**) and returning ready to validate responses. Each method name
in this class starts with [the HTTP method](http://www.tutorialspoint.com/http/http_methods.htm) name (get, post,
delete...).

b) The second class, called NameTest (for
example [GetTest](https://github.com/slawekradzyminski/AwesomeTesting/blob/master/src/test/java/restassuredjsonplaceholder/tests/GetTest.java))
contains all the assertions (**then**).

This approach nicely separates the setup and assertion phase. You don't have to follow this path though, that's my way
of keeping those tests readable and maintainable.

Here is how to code looks like

{% highlight java %}
    private static final String URL = "http://jsonplaceholder.typicode.com";

    public Response getPostContent(int postNumber) {
        return given()
                .contentType(JSON)

                .when()
                .get(format("%s/posts/%s", URL, Integer.toString(postNumber)));
    }
{% endhighlight %}

{% highlight java %}
    private JsonPlaceholderAPI jsonPlaceholderAPI = new JsonPlaceholderAPI();

    @Test
    public void testGetPostTitle() {
        jsonPlaceholderAPI.getPostContent(1)

                .then()
                .body("title", equalTo("sunt aut facere repellat provident occaecati excepturi optio reprehenderit"));
    }
{% endhighlight %}

We are checking here that get a request
for [http://jsonplaceholder.typicode.com/posts/1](http://jsonplaceholder.typicode.com/posts/1) gives us the correct
title. As you can see that's indeed the case.

Rest-Assured uses [Hamcrest matchers](http://www.vogella.com/tutorials/Hamcrest/article.html) for validation. There are
quite a few of
them ([I used 4 different ones](https://github.com/slawekradzyminski/AwesomeTesting/blob/master/src/test/java/restassuredjsonplaceholder/tests/GetTest.java)),
and they are easily expandable. I will show you how to write custom matchers in one of the future posts soon.

## Schema validation

Sometimes you may not want to assert details. You care more about the response types and structure. Rest-Assured
supports this approach nicely
with [Schema Validation](https://github.com/rest-assured/rest-assured/wiki/Usage#json-schema-validation). [SchemaValidationTest](https://github.com/slawekradzyminski/AwesomeTesting/blob/master/src/test/java/restassuredjsonplaceholder/tests/SchemaValidationTest.java)
shows you how it works:

{% highlight java %}
    private JsonPlaceholderAPI jsonPlaceholderAPI = new JsonPlaceholderAPI();

    @Test
    public void schemaValidation() {
        jsonPlaceholderAPI.getPostContent(1)

                .then()
                .body(matchesJsonSchemaInClasspath("jsonplaceholder-posts-schema.json"));
    }
{% endhighlight %}

You just need to define the schema:

{% highlight json %}
{
  "title": "Posts schema",
  "type": "object",
  "properties": {
    "userId": {
      "type": "integer"
    },
    "id": {
      "type": "integer"
    },
    "title": {
      "type": "string"
    },
    "body": {
      "type": "string"
    }
  },
  "required": ["userId", "id", "title", "body"]
}
{% endhighlight %}

## Other methods

Obviously, Rest-Assured isn't limited to get method only. You can add data as well. Let me show how you can simulate a
user adding something to your forum. Jsonplaceholder requires UTF-8 encoding, so I needed to modify it.

{% highlight java %}
    private final RestAssuredConfig restAssuredConfig = RestAssured.config()
        .encoderConfig(encoderConfig()
        .defaultContentCharset("UTF-8"));

    public Response putNewPost(User user, int postNumber) {
        return given()
                .config(restAssuredConfig)
                .contentType(JSON)
                .body(user)

                .when()
                .put(format("%s/posts/%s", URL, Integer.toString(postNumber)));
    }
{% endhighlight %}

Here is the test:

{% highlight java %}
    private JsonPlaceholderAPI jsonPlaceholderAPI = new JsonPlaceholderAPI();

    @Test
    public void testPutMethod() {
        User user = new User(1, "foo", "bar", 1);
        jsonPlaceholderAPI.putNewPost(user, 1)

                .then()
                .statusCode(SC_OK);
    }
{% endhighlight %}

You may wonder if you have to write a custom JSON parser. Fortunately, Rest-Assured does all the work for us, and you
just have to specify basic class:

{% highlight java %}
public class User {

    private int id;
    private final String title;
    private final String body;
    private final int userId;

    public User(int id, String title, String body, int userId) {
        this.id = id;
        this.title = title;
        this.body = body;
        this.userId = userId;
    }
}
{% endhighlight %}

Simple, isn't it? :)

All tests are available for download on my [GitHub project](https://github.com/slawekradzyminski/AwesomeTesting).
