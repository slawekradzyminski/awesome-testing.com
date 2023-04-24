---
title: Maximizing Performance with Gatling
layout: post
permalink: /2023/01/maximizing-performance-with-gatling
categories:
  - Performance testing
tags:
  - performance testing 
---

![](/images/blog/1582210782200.png)

[Gatling](https://gatling.io) is a powerful open-source load testing tool designed to help developers and performance
engineers test the performance and scalability of their web applications. It's written in Scala and it's based on
the [Akka](https://akka.io) toolkit, which means it's highly extensible and easily integrated with other tools.

One of the key features of Gatling is its intuitive and easy-to-use DSL (domain-specific language) for building test
scenarios. This allows developers to write load tests in a natural and readable language, making it easy to understand
and maintain. Gatling also supports multiple protocols such as HTTP, HTTPS, WebSockets, and JMS, and it can be used to
test applications written in different languages and running on different platforms.

Gatling also provides detailed and accurate results, with real-time monitoring and reporting capabilities. It generates
HTML reports that provide a clear and concise overview of the test results, including request and response details,
response time distribution, and error statistics. Gatling also allows you to customize the reports by adding your own
charts and statistics.

Another advantage of Gatling is its high performance. It's designed to handle large numbers of concurrent users, making
it ideal for testing high-traffic web applications. Gatling's architecture is based on Akka, which is a high-performance
toolkit for building concurrent and distributed systems. This allows Gatling to handle large numbers of requests with
minimal resource usage.

In summary, Gatling is a powerful and flexible load testing tool that is easy to use and provides detailed and accurate
results. Its intuitive DSL, support for multiple protocols, and high performance make it an ideal choice for testing web
applications of all sizes and complexities.

It's important to note that Gatling also has a commercial version called Gatling Frontline which offer additional
features like distributed testing, advanced analytics, and real-time reporting.

If you're looking for a load testing tool that is easy to use, provides detailed results, and can handle large numbers
of concurrent users, then Gatling may be the perfect choice for you. So, give it a try and see how it can help you
improve the performance and scalability of your web applications.

You can write Gatling tests in popular JVM languages (Java, Scala & Kotlin).

**Scala test example**

Here is an example of a simple load test in Java using Gatling for a REST API endpoint that returns JSON:

{% highlight scala %}
import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class SimpleLoadTest extends Simulation {

  val httpConf = http.baseUrl("http://localhost:8080")
    .acceptHeader("application/json")

  val scn = scenario("Simple Load Test")
    .exec(http("request_1")
      .get("/api/endpoint")
      .check(status.is(200))
      .check(jsonPath("$.key").is("value"))
    )

  setUp(
    scn.inject(
      constantUsersPerSec(10) during (10 seconds)
    ).protocols(httpConf)
  )
}
{% endhighlight %}

In this example, the test sends a GET request to the endpoint "/api/endpoint" on the localhost at port 8080, and expects
a 200 OK response with a JSON body containing a key-value pair where the key is "key" and the value is "value". The test
will run for 10 seconds and will gradually ramp up to 10 users per second.

**Java test example**

Here is an example of a simple load test in Java using Gatling's core API for a REST API endpoint that returns JSON:

{% highlight java %}
import io.gatling.core.Predef;
import io.gatling.core.scenario.Simulation;
import io.gatling.core.structure.ScenarioBuilder;
import io.gatling.http.Predef;
import io.gatling.http.protocol.HttpProtocolBuilder;

public class SimpleLoadTest extends Simulation {

        HttpProtocolBuilder httpConf = Predef.http().baseUrl("http://localhost:8080")
                .acceptHeader("application/json");

        ScenarioBuilder scn = Predef.scenario("Simple Load Test")
                .exec(Predef.http("request_1")
                        .get("/api/endpoint")
                        .check(Predef.status().is(200))
                        .check(Predef.jsonPath("$.key").is("value"))
                );

     {
        Predef.setUp(
                scn.inject(Predef.constantUsersPerSec(10).during(10))
                .protocols(httpConf)
        );
    }
}
{% endhighlight %}

This test sends a GET request to the endpoint "/api/endpoint" on the localhost at port 8080, and expects a 200 OK
response with a JSON body containing a key-value pair where the key is "key" and the value is "value". The test will run
for 10 seconds and will gradually ramp up to 10 users per second.

You can find the working projects on my GitHub:

- tested
  application [https://github.com/slawekradzyminski/test-secure-backend](https://github.com/slawekradzyminski/test-secure-backend)

- Gatling tests in
  Scala [https://github.com/slawekradzyminski/performance-tests](https://github.com/slawekradzyminski/performance-tests)

- Gatling tests in
  Java [https://github.com/slawekradzyminski/performance-tests-java](https://github.com/slawekradzyminski/performance-tests-java)

