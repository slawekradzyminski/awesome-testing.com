---
title: How to speed up your tests in one simple step
layout: post
permalink: /2018/09/how-to-speed-up-your-tests-in-one
categories:
  - CI/CD
tags:
  - CI/CD
  - testing tools 
---

![](/images/blog/traffic-car-vehicle-black.jpg)

Every tester
with [Continuous Improvement](https://www.awesome-testing.com/2017/01/testops-4-continuous-improvement.html) mindset
cares about overall test execution time. We aim for quick feedback loops ending before developer switches to another
task. This is not always easy as projects becomes bigger and bigger, teams focus on delivering new features and other
issues receive higher priority.

Today I'd like to present you a very simple way of speeding up your tests. Most of the times we try to introduce test
parallelism on code level. Unfortunately that's usually very costly and hard to implement. Often we end up with
complicated code that resolves our timing problems, but introduces new issues (increased code maintenance costs, flaky
tests, timing problems, random test dependencies).

Approach presented here is different. Instead of costly software test parallelism we multiply test environments and
split tests by basic regex (or [Globs](https://github.com/isaacs/node-glob#glob-primer) for Javascript).

## Concept

Idea is very simple. We spawn multiple test environment instances (ideally using lightweight Dockers) and execute only
arbitrary percent of full test suite. In my example I split the tests by name. First suite execute tests matched by
\[a-m\]\* pattern and the second suite is running tests matched by \[n-z\]\* pattern. This should theoretically create
split close to 50-50.

## Implementation

In order to give you better view on how it works I prepared complete Continuous Integration job definition
using [Gitlab CI](https://about.gitlab.com/features/gitlab-ci-cd/) .gitlab-ci.yml file. First example is from Java
world ([Maven](https://maven.apache.org/)) and the second one is from Javascript
world ([Node.js](http://node.js/), [npm](https://www.npmjs.com/), [mocha](https://mochajs.org/)).

### Java example

{% highlight yml %}
image: maven:3-jdk-8

stages:
  - build
  - test

compile:
  stage: build
  script:
    - mvn -U -B clean compile

tests-am:
  stage: test
  script:
    - echo '[A-M] TESTS'
    - mvn -U -B test -Dtest='%regex[.*/[A-M].*Test.class]'
    
tests-nz:
  stage: test
  script:
    - echo '[N-Z] TESTS'
    - mvn -U -B test -Dtest='%regex[.*/[N-Z].*Test.class]'
{% endhighlight %}

To those unfamiliar with Gitlab CI few words of explanation. This is [YAML](http://yaml.org/) file that stores our
Continuous Integration job definition. First line (image) defines Docker container which will be pulled from Docker
registry at the beginning. We get official maven image which guarantees us that _mvn_ command is working properly. Next
the application code is downloaded inside a container and scipt starts.

We split the tasks into two stages. First stage (build) contains only one job: execute '_mvn -U -B clean compile_'
command. Remember that we want to detect failures as soon as possible, so compilation is our first quality gate.

If first stage succeeds we move into phase two (test). This time though tasks start simultaneously. Two set of tests (
matched by regex) are executed on the same time.

### Javascript example

{% highlight yml %}
image: node:10

stages:
  - test

tests-am:
  stage: test
  script:
    - npm install
    - echo '[A-M] TESTS'
    - mocha "server-test/[a-m]*/**/*.js"
    
tests-nz:
  stage: test
  script:
    - npm install
    - echo '[N-Z] TESTS'
    - mocha "server-test/[n-z]*/**/*.js"
{% endhighlight %}

This time we have only one stage (test). Each one use mocha to run ~50% of tests present in server-test folder.

## Conclusion

This simple trick shortens overall test execution time and provides us with faster feedback. Please note that this
solution is also scalable (by adding new Docker and splitting test suite into more separate chunks).
