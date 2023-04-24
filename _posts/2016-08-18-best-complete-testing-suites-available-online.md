---
title: Best complete testing suites available online
layout: post
permalink: /2016/08/best-complete-testing-suites-available
categories:
  - Selenium
tags:
  - selenium
  - learning 
---

![](/images/blog/Passed-Exam.jpg)

In [Testers toolbox - an alternative guide](https://awesome-testing.com/2016/04/testers-toolbox-alternative-guide.html)
post I listed various sites that you may use for testing skills improvement. Today I'd like to show you something
totally different - complete end-to-end testing suites that are open-sourced and freely available for
study/fork/reference. They may not be easy to understand at the beginning, but once you delve deeper you will notice how
they take advantage of various frameworks. Reserve yourself some free time and try to investigate them fully - don't get
discouraged at the first obstacle. Imagine today is the first day of your new job and you want to run them locally.

Word of warning at the beginning: The number of tests isn't too big. Probably that's because those companies follow the
test pyramid pattern ([ThoughtWorks](https://www.thoughtworks.com/) example below). You should follow it too. E2E test
may be cool, but they always require maintenance. No exceptions from that rule I'm afraid.

![](/images/blog/testing-pyramid-fabio-pereira.png)

### [Wikia](https://github.com/Wikia/selenium-tests)

Classic Java project with [Gradle](https://gradle.org/) build tool. Updating almost in a daily manner. Must see for
everyone writing in Java.

### [WordPress](https://github.com/Automattic/wp-e2e-tests)

Awesome JavaScript testing suite [announced](https://developer.wordpress.com/2016/05/12/automated-e2e-tests/) in
may. [Nodejs](https://nodejs.org/en/) and Calypso ([Mocha](https://mochajs.org/)) are used here. There is also support
for various resolutions and test notifications on Slack (with screenshot). Fantastic overall. Interesting quote
explaining why tests were open sourced:

> The quality of our code and our product depend on the amount of feedback we get and on the amount of people who use
> them. If we’re developing behind closed doors, we are putting artificial limits to both.

Matt Mullenweg, CEO Automattic

### [NASA](https://github.com/nasa/openmct/tree/master/protractor)

E2E Protractor tests written by NASA. Interesting usage of static waits. Perhaps I was wrong
in [my post](https://awesome-testing.com/2016/04/introducing-fluentlenium-2-selenium.html)? What do you think?

### [Jenkins](https://github.com/jenkinsci/acceptance-test-harness)

Acceptance Tests for Jenkins. Interesting mix of Java tests using [JUnit](http://junit.org/junit4/)
or[Cucumber](https://cucumber.io/)and Groovy tests
using [Geb](http://www.gebish.org/)/[Spock](https://github.com/spockframework/spock).

### [Moztrap](https://github.com/mozilla/moztrap-tests) & [Socorro](https://github.com/mozilla/Socorro-Tests)

Probably the most famous open source advocate - Mozilla with two Python open source projects
using [pytest](http://doc.pytest.org/en/latest/).

### [Optimizely](https://github.com/optimizely/mobile-e2e) (Mobile)

End to End black-box tests for the Mobile iOS and Android SDKs written in JavaScript. Test are prepared to run
on [the Appium](http://appium.io/) server.

Did I miss something? Please let me know in the comments :)
