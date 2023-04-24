---
title: Practical test strategy for Spring & React application
layout: post
permalink: /2020/01/practical-test-strategy-for-spring
categories:
  - Test strategy
tags:
  - strategy
  - testing thoughts 
---

![](/images/blog/photo-1523875194681-bedd468c58bf.jpeg)

There are two leading approaches for tests: isolated and end to end (E2E). As usual, both approaches have upsides and
downsides, and it's impossible to say which one is better. Everything is dependent on application context and
architecture.

There are though few guidelines which can be followed most of the time:

* high test coverage should be achieved for a single application. Other parts of the system (i.e. connected
  microservices) should be stubbed/mocked
* important business cases should be tested in the E2E manner without any mocks. E2E tests should give us a high amount
  of confidence that our system will work on the production
* isolated tests should make up the majority of your overall test count
* E2E test count should be low because they may
  be [flaky](https://testing.googleblog.com/2017/04/where-do-our-flaky-tests-come-from.html)

It remains to be seen whether contract tests would make a list of best practices. I certainly recommend adding
them to the list.

Enough of theory, let's move into applying it in real life.

### System overview

Let's say we want to test a very simple system with:

a) [Spring Boot backend ](https://github.com/slawekradzyminski/vistulasampleapi)

b) [React frontend](https://github.com/slawekradzyminski/reactfrontend)

To complicate things a bit let's also assume that our backend is interacting with external API served by the other
service (which we have limited control of).

![](/images/blog/Screenshot%2B2020-01-18%2Bat%2B12.41.12.png)

The application I wrote is very simple, it only allows to CRUD (create, read, update, delete) a user but it's about to
overcome Facebook soon as the most popular social media platform so we need to prepare a comprehensive test strategy.

![](/images/blog/Screenshot%2B2020-01-18%2Bat%2B12.16.13.png)

### Functional test strategy

We need the following functional tests:

* Isolated API tests with external API mocked
  using [Wiremock](https://www.awesome-testing.com/2017/12/get-rid-of-your-external-dependencies.html) (
  or [MockServer](http://www.mock-server.com/)). All tests should be written using
  standard [libraries provided by Spring](https://docs.spring.io/spring/docs/current/spring-framework-reference/testing.html)
* Isolated [React components tests](https://www.valentinog.com/blog/testing-react/) (+ actions, reducers, views, hooks,
  etc.)
* Isolated [Pact contract tests](https://github.com/slawekradzyminski/PactExample) (external API <-> our API)
* Isolated [Pact contract tests](https://github.com/slawekradzyminski/PactExample) (our API <-> our frontend)
* Isolated [Cypress GUI tests](https://www.cypress.io/)
* E2E [Selenium tests](https://www.awesome-testing.com/search/label/selenium) covering business cases with no mocks

Isolated tests should be in the same repository as applications, and they should run in pipelines after each commit. For
E2E tests we need a separate repository. They should run as often as possible. Results should be recorded and displayed
on a screen placed in a visible area.

For simplicity let's assume we are not covering non-functional characteristics at this point.

### Non-functional test strategy

We need the following performance tests:

* Our API backend should be tested in isolation with tools like[Gatling](https://gatling.io/)
  or[Locust](https://locust.io/). JMeter is not recommended because we want to store performance tests as a code
* We measure website performance using Lighthouse on test environment and production. Results should be recorded and
  displayed on a screen placed in a visible area.

In the beginning, we assume that the application should handle 100 simultaneous users. Tests should prove that we can
handle 200.
