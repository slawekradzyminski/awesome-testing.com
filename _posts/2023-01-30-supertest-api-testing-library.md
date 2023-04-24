---
title: Supertest API testing library
layout: post
permalink: /2023/01/superest-api-testing-library
categories:
  - API testing
tags:
  - API testing 
---

![](/images/blog/1*R8dpDe1F8LIgCrN1QTfVBw.png)

[Supertest](https://github.com/ladjs/supertest) is a popular JavaScript library for testing HTTP APIs. It allows
developers to send HTTP requests to their server-side code and assert that the response meets certain criteria.

One of the key benefits of using Supertest is that it is built on top of the popular testing library, Superagent. This
means that it has a similar syntax and functionality, making it easy for developers who are already familiar with
Superagent to get started.

Supertest also provides a number of additional features that are specifically designed for testing APIs. For example, it
allows developers to easily send JSON payloads in their requests and assert that the response has the correct status
code and headers.

To get started with Supertest, you will first need to install it as a dependency in your project. Once you have done
this, you can import the library in your test file and use it to make requests to your server-side code.

For example, you can use the **_.get()_** method to send a GET request to your server and assert that the response has
the correct status code and contains the expected data.

{% highlight javascript %}
const request = require('supertest');
const app = require('./app');

describe('GET /', () => {
  it('should return a 200 status code and a welcome message', async () => {
    const res = await request(app).get('/');

    expect(res.statusCode).toEqual(200);
    expect(res.body).toEqual({ message: 'Welcome to my API!' });
  });
});
{% endhighlight %}

In this example, the **_request(app)_** function creates a new Supertest object that is bound to our Express app, which
allows us to make requests to the app's routes. The **_.get('/')_** method sends a GET request to the root route of the
app and returns a promise that resolves to the response object.

Overall, Supertest is a powerful and easy-to-use library for testing APIs in JavaScript. It allows developers to write
expressive and maintainable tests for their server-side code, helping to ensure that their APIs are working as expected.

For more examples and complete working project please use
my [GitHub project](https://github.com/slawekradzyminski/supertest-api-tests).

  

