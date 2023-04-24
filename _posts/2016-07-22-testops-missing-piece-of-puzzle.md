---
title: TestOps - missing piece of puzzle
layout: post
permalink: /2016/07/testops-missing-piece-of-puzzle
categories:
  - TestOps
tags:
  - testops
  - devops 
---

![](/images/blog/CPBtwnKWgAIne5H.jpg)

Some time ago in
my [do/don't recommend](https://awesome-testing.com/2016/02/dos-and-donts-for-testers-2016-edition.html)I encouraged you
to take care of your testing environment and learn orchestration tool
like [Ansible](https://awesome-testing.com/2015/12/testing-with-ansible.html). Somewhere between writing automated tests
and
implementing [Continuous Delivery](http://awesome-bookreviews.blogspot.com/2016/06/se-classics-1-continuous-delivery.html),
I came across interesting concept popularised
by [Seth Eliot](https://twitter.com/setheliot) - [TestOps](http://www.ministryoftesting.com/tag/seth-eliot/). Even
though [Richard Bradshaw](https://twitter.com/friendlytester/status/644135471329738752)didn't like the name I really
think there is something smart in this concept. By googling the name I
found [a great paper](http://uploads.pnsqc.org/2015/papers/t-054_Howlett_paper.pdf)which says:

> TestOps as a concept revolves around ensuring product teams have access to any required test infrastructure, platforms
> and frameworks they require without needing large amounts of time consuming configuration before commencing tests. Any
> benefit from use of a CI system will be lost if the QA process takes days to complete due to environmental setup and
> tear down on the part of the QA person on a team.

This post will start a new series which will focus on various technical testing topics like:

* Testing in Production
* Testing in Continuous Delivery era
* Testing in the Cloud
* Testing in Agile/Lean
* Monitoring (+ Alerting?)
* Data-Driven Quality
* Pentesting

Why bother though? Here are the benefits:

### Stepping outside the comfort zone

In almost every area of life, it's worth to try new things. Whether it's a journey to an unknown country, a new dish, or
studying new language benefits are unquestionable. You get yourself familiar with the learning process, which I believe
is a skill. Many people in our society fear to even take a different route to work (usually they're older, that's why
companies prefer younger employees accustomed to continuous change). If you don't have a continuous improvement mindset
you can't excel in the IT/testing industry. Train yourself to change it.

> If you want to be an effective employee, then take a look at your job description and treat the description a soft
> boundary.

_[Rob Lambert. “10 Behaviours Of Effective Employees.”](https://leanpub.com/10behavioursofeffectiveemployees)_

### Deepening your Software Engineering understanding

In my post about[learning](https://awesome-testing.com/2016/03/learning-pathways-for-testers.html)pathways for testers,
I mentioned already that you should be very critical about which sources you choose to follow. The amount of online
resources/blogs/books is pretty much unlimited. Before starting something new ask yourself a few questions:

a) What business problem am I trying to solve?

b) How much would my solution benefit stakeholders?

c) Why am I doing this?

Usually, those questions require you to look at your work from the bigger picture. By extending your knowledge in
software engineering via valuable books four answers to those questions would be more precise. That's why senior,
experienced engineers are so valuable on the job market - they not only have broad knowledge from the books but also
hands-on experience. You can't beat them by experience, so there is only one way.

In the Google era, and with the right amount
of [soft/teamwork skills](http://awesome-bookreviews.blogspot.com/2016/02/team-geek-software-developers-guide-to.html)
you can solve almost every **precisely** defined problem.

### Possibility to learn new things

Don't get yourself entrapped in a small testing world. Expand your all-around knowledge in IT.

Selenium Grid doesn't crash because it's unstable. It has a custom configuration, limited Java resources, and network
configuration. Did you try to change them to make it work?

Slow integration tests? Did you try to run them simultaneously? Did you stop trying after encountering the first
obstacle?

Slow application build? Did you try to change Jenkins/TeamCity/Bamboo server/agent configuration?

There are so many testing related things that can be improved by skilled Operations work that it simply can't be
ignored. Viktor Farcic in ['The DevOps 2.0 Toolkit'](https://leanpub.com/the-devops-2-toolkit) gives us an almost
unlimited amount of knowledge. It's not rocket science by any means.

### Possibility to discover new areas of testing

Experienced exploratory testing. Crème de la crème of the testing industry. I wouldn't say that manual tests would be
soon replaced by automated checks in 100%. However, to make them really effective from a business point of view they need
to find serious bugs as soon as possible. It can't be misspelling and it can't be wrong error message (unless of course,
it's a sign of something bigger in application core). It has to be a serious performance problem, slow application speed
under large traffic, unscalable design, or something big.

All those things require deep knowledge. Architecture knowledge. Coding knowledge. Software Engineering knowledge. You
won't gain it just by reading ISTQB syllabuses.

### Making your contribution indispensable

At first, I titled this chapter as 'Making yourself indispensable', however it has very bad connotations. Some people
naively think that by writing obscure code and by designing silly architecture they are making yourself irreplaceable.
That's not true. Real security comes from broad knowledge. Always try to improve your employability (Rob Lambert has
written a nice [book](https://leanpub.com/remainingrelevant) about that).

You should aim at making your [day-to-day](https://leanpub.com/remainingrelevant) **contribution** indispensable. This
gives you real job security. By being smart you can sleep well.

> If you are among the top 1% in the world at what you do, you will never have to worry about “making it”. It’s the
> surest path there is.

[Peep Laja - This I believe](http://conversionxl.com/this-i-believe/)
