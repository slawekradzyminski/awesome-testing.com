---
title: Tester's toolbox 2 - Awesome Testing Christmas edition
layout: post
permalink: /2019/12/testers-toolbox-2-awesome-testing
categories:
  - Toolbox
tags:
  - resources for testers
  - selenium
  - API testing
  - test automation
  - testing tools 
---

![](/images/blog/photo-1531718748519-a5fbb6cf972d.jpeg)

It's been more than three years since I released one of my most popular
posts - [Tester's toolbox - an alternative guide](https://www.awesome-testing.com/2016/04/testers-toolbox-alternative-guide.html).
Today I'd like to share tools and projects created by me for various occasions (public speaking, teaching on Vistula
University or just self-learning). All of those repositories are 100% free to use.

## Selenium starter guide (Java, Maven)

[https://github.com/slawekradzyminski/vistulaselenium](https://github.com/slawekradzyminski/vistulaselenium)

Selenium knowledge is still one of the most demanded testing skills on the market. Strong contender may have emerged
with [Cypress](https://www.cypress.io/), but its certain limitations (Chrome only, Javascript only) mean
that [Selenium](https://selenium.dev/) dominance won't disappear anytime soon.

My project contains the following features:

a) Very detailed setup guide (including Java install and running your first test)

This often-overlooked point tends to slow down newcomers a lot. Let's be honest - Java project setup is not easy.

b) Refactoring to page object pattern

The project contains few branches (see README) which can be used as a model of learning page object pattern. In small
steps, I show how to get rid of the Selenium API in tests.

## Rest API (Java, Spring Boot, Gradle)

[https://github.com/slawekradzyminski/vistulasampleapi](https://github.com/slawekradzyminski/vistulasampleapi)

I needed sample API for Rest Assured tests so I created one in Spring Boot. Nothing fancy here, just Gradle and Spring
Controllers. API is easily expandable. You don't need any additional setup - there is in
memory [h2 database](https://www.h2database.com/html/main.html).

## Rest Assured starter guide (Java, Maven)

[https://github.com/slawekradzyminski/vistularestassured](https://github.com/slawekradzyminski/vistularestassured)

A simple starter guide for API tests written using one of the most popular API testing
tools - [Rest Assured](http://rest-assured.io/). Nice extension of my previous post on this subject:

- [Restful API testing with Rest-Assured](https://www.awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html)
- [Rest Assured integration tests for jsontest.com](https://www.awesome-testing.com/2017/06/rest-assured-integration-tests-for.html)

Similar to Selenium starter guide project, it contains a nice and easy setup guide.

## Contract tests (Java, Gradle, Pact)

[https://github.com/slawekradzyminski/PactExample](https://github.com/slawekradzyminski/PactExample)

Last but not least! A project which took me a while to implement and test thoroughly. Main features include:

- Selected and recommended theoretical sources about contract tests
- Contract tests on both Consumer and Provider side written using [Pact](https://docs.pact.io/)
- Scripted [Pact Broker](https://docs.pact.io/getting_started/sharing_pacts) setup
- [Spring MVC](https://docs.spring.io/spring/docs/current/spring-framework-reference/testing.html) tests
- [Wiremock](https://www.awesome-testing.com/2017/12/get-rid-of-your-external-dependencies.html) stubbings

I'll describe this one in greater detail soon.

## Afterword

I know that I haven't been very active on this blog recently but great things are about to come here very soon. In 2020
you can expect contract tests, mobile tests, Cypress, Kotlin, Javascript and maybe even Python.

Happy new year! :)
