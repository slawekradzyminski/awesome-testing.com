---
title: TestOps - Continuous Testing
layout: post
permalink: /2016/10/testops-3-continuous-testing
categories:
  - TestOps
tags:
  - testops 
---

![](/images/blog/jquery-ajax-loader.jpg)

Part 3 of my [TestOps](https://awesome-testing.com/search/label/testops) series focuses on an extremely important
subject that spans throughout the
full [Systems development life cycle](https://en.wikipedia.org/wiki/Systems_development_life_cycle) (SDLC). Some may
argue that apart from understanding
obvious[TestOps benefits](https://awesome-testing.com/2016/07/testops-missing-piece-of-puzzle.html)it's the key for a
successful release and effective development.

From what I saw reading various articles and books about the subject no clear Continuous Testing (CT) definition exists.
In such cases it's always best to use [Wikipedia](https://en.wikipedia.org/wiki/Continuous_testing):

> Continuous testing is the process of
> executing[automated tests](https://en.wikipedia.org/wiki/Test_automation "Test automation")as part of the software
> delivery pipeline to obtain immediate feedback on the business risks associated with a software release candidate.

Every CT step except exploratory testing should be fully automated and run as often as possible. Basically speaking
if our infrastructure allows us to run every CT step after every commit on every branch we should take full advantage of
that. If not CT can be performed nightly. CT should be integrated
into[the delivery pipeline](http://cdn.infoq.com/statics_s2_20150819-0313/resource/articles/orch-pipelines-jenkins/en/resources/Fig1-large.png)
using tools like Jenkins, TeamCity, Go, GitLab CI, etc.

I believe we can distinguish a few things that make CT complete:

**Continuous Integration (CI) and unit tests**

After every single commit to the main branch application should be compiled and build. Unit tests should also be
executed at this point to give as quickest feedback as possible. In case of failure, some kind of event (mail, slack
notification) is advisable for team or culprits only (the people whose changes lead to failure). Unit tests must be
executed quickly in parallel. Developers should see failure notification before they begin the next task to avoid
distractions. Unit tests should be written by developers (ideally in TDD fashion),
but[Google Testing Blogs](https://testing.googleblog.com/)advises testers to have strong skills in this area. In case of
bad practices (too slow tests, no parallelism, too few tests, not
following [test pyramid](http://martinfowler.com/bliki/TestPyramid.html), poor test quality/readability/maintainability)
we should initiate change and improvement. Also sometimes it is advisable to move integration/E2E tests to lower levels
to speed up the whole pipeline.

Few authors distinguish [mutation testing](http://pitest.org/)as a separate CT step. I don't agree with that. Mutation
testing is a way to check how good our unit tests are doing. We basically make sure that they can report failure in case
of reverted logic.

**Code coverage and static analysis**

After the developer commits code to the main branch he should be informed how his feature changed overall code coverage
statistics. You may be surprised here, but the introduction
of [the gamification](https://en.wikipedia.org/wiki/Gamification) element to your pipeline usually has a very positive
effect on the number of unit tests written. No developer wants to be a laggard who worsens statistics. Example code
coverage tools: [JaCoCo](http://www.eclemma.org/jacoco/) and [Istanbul](https://github.com/gotwarlost/istanbul).

Static code analysis tools like [SonarQube](http://www.sonarqube.org/)are also very useful. They're capable of doing
non-personal code reviews and white box testing in an automated fashion. They identify security issues, bugs, code
smells, etc. You can not only modify/remove existing rules but also add new ones.

Ideally, you want a static code analysis tool integrated with the code review process. This allows reviewers to focus on
the broad picture (architecture, maintainability) instead of debating if the given variable should be final.

**Continuous Delivery / Automated deployment**

When application building finishes you want to test your deployment process. Ideally, it should be done in the same
fashion as a production release. Performing lots of test environment deployments daily gives you confidence that your
release pipeline is working fine.

**Integration / E2E / Visual testing**

After the application was successfully deployed on the testing environment you can begin higher-level tests. I'm
analyzing them as a whole because the actual distribution of test cases depends pretty much on your strategy. Generally
speaking, you want to cover as many functionalities on integration/API level to shrink expensive E2E/Selenium tests.
This sometimes creates a void in visual verification which can be fulfilled by tools
like [BackstopJS](https://github.com/garris/BackstopJS) or [Galen Framework](http://galenframework.com/).

An important note here: testing on this level should be owned by the whole team, not only testers. This means that your
testing strategy should be discussed and agreed on by everyone in your project.

Examples of this level tests can be found on
my [Github Awesome Testing](https://github.com/slawekradzyminski/AwesomeTesting) project.

**Performance testing**

Along with functional testing, you want to check how your application is doing under heavy load. I'm planning a separate
post on this subject, but at this point, it's worth to note that:

_Performance tests should have a separate environment which is as close to production as possible - if you can't achieve
that it's usually better to do performance testing on production environment_

This sometimes means that you can't add performance testing to your pipeline.

**Security testing (DevSecOps)**

The latest trend with a terrible name - [DevSecOps](http://www.devsecops.org/). Security is becoming more and more
important as hacking is getting increasingly easier with powerful tools like [Burp](https://portswigger.net/burp/).
Sometimes you can have quick victories by integrating existing tools into your pipeline. Examples
are [the OWASP dependency check](https://www.owasp.org/index.php/OWASP_Dependency_Check), [OWASP Zed Attack Proxy (ZAP)](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project),
or[Gauntlt](http://gauntlt.org/). If you don't do security testing already it's highly recommended to start as soon as
possible.

**Exploratory testing**

Time for the most controversial topic of all - manual exploratory testing. The word which triggers endless debate here
is most likely 'manual'. Now I'm definitely no fan of manual activities, but I also see a value in skilled exploratory
testing. I think it's worth to execute them after completing big features and before releases.

Evaluate often if there is value in this step though - you don't want to have useless manual activities slowing down
your process.

If you want to expand your knowledge in exploratory testing I suggest
reading [Elisabeth Hendrickson](http://testobsessed.com/2006/04/rigorous-exploratory-testing/).

**Testing in Production (TiP)**  

Set of continuous activities which test live application. I already described it fully in my
previous [TestOps #2 - Testing in Production](https://awesome-testing.com/2016/09/testops-2-testing-in-production.html)
post.
