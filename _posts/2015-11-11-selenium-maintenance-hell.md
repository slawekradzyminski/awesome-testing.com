---
title: Selenium maintenance hell
layout: post
permalink: /2015/11/selenium-maintenance-hell
categories:
  - Selenium
tags:
  - selenium
---


So often we find ourselves scratching our heads thinking 'Why did it fail? It works perfectly well locally...'. Timeout
or 'Session ID is null' (my favorite) errors can be especially annoying when we are currently working on the most famous
testing task: make all test pass. Let's analyze together how to fix this unhealthy situation.

First of all, we need to redefine our task with management. Why so? Having dummy test methods is not what we want to
achieve (and not what managers expect from us). Our real task can be defined as:

Make your tests cover as many functionalities as possible, but avoid false results at all costs.

I emphasized 'all costs' because I want to make a point which you may find controversial:

Even the most important tests should be excluded from the automated suite if they are unstable. After exclusion we need
to:

- prioritize test-fixing task (according to test importance/coverage)

- perform the manual test until automated one isn't stable

Certainly do not run tests locally (and do not force programmers to do that...). This approach leads to nowhere.

I know we shouldn't, but what if we depend on other services, DBs, factors? Automated test dependencies should be
verified before test execution, and if such one exists test should be ignored.

There is one thing which we often forget about. As QAs/testers we are responsible for building trust in automated tests
throughout team/company. False test results are the single most important factor which reduces (or even destroys) this
trust.

Even from the most selfish perspective, there is an important argument against non-stable tests. Writing/maintaining
tests with false results will combine your work image in the eyes of others with the word 'FAILURE'. Avoid it at all
costs.
