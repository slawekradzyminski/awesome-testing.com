---
title: TestOps - Engineering Productivity
layout: post
permalink: /2017/07/testops-5-engineering-productivity
categories:
  - TestOps
tags:
  - testops 
---

![](/images/blog/focus-productivity-green-highway-signpost-wording-sky-background-44076365.jpg)

**Introduction**

Google has recently surprised everyone by renaming their
famous [GTAC](https://developers.google.com/google-test-automation-conference/)
into [Engineering Productivity](https://testing.googleblog.com/2017/07/evolution-of-gtac-and-engineering.html)
conference. It means that already complicated and confusing testing dictionary received one more
entry ([ISTQB dictionary](http://glossary.istqb.org/search/engineering%20productivity)for instance, fails to explain the
meaning of this term). The meaning of Engineering Productivity is very broad, and it's not easy define it in one blog
post. With help of various resources I'll try.

**What is Engineering Productivity?**

As described in [How Google Tests Software](https://www.amazon.com/Google-Tests-Software-James-Whittaker/dp/0321803027)
Engineering Productivity in testing context was first introduced by Patrick Copeland:

> So I decided to make it official and I changed the name of the team to Engineering Productivity. With the name change
> also came a cultural adjustment. People began talking about productivity instead of testing and quality. Productivity is
> our job; testing and quality are the job of everyone involved in development. This means that developers own testing and
> developers own quality. The productivity team is responsible for enabling development to nail those two things.

As noted by Patrick (later confirmed by Ashley Hunsberger
on [Souce Lab Blog](https://saucelabs.com/blog/qa-is-not-enough-you-need-to-engineer-productivity))QA people may not be
enough to guarantee demanded quality. Engineering Productivity team is kind of extension which allow companies to focus
on quality from start of Software Engineering process (often called '_left_') to the product release and live
maintenance/monitoring ('
_right_' - [Testing in Production](http://www.awesome-testing.com/2016/09/testops-2-testing-in-production.html)). I'm
sure that most of my readers employed as QA/testers observe that their responsibilities often go beyond simple testing
role. At least that's what I encouraged you to do in my posts, for
example [Testing Learning Checklist](http://www.awesome-testing.com/2017/03/learning-software-testing-checklist.html).
It's worth to remain once again that traditional (mostly manual) QA is getting obsolete. It was confirmed
by [Yahoo](https://news.ycombinator.com/item?id=10718742)decision to disband their team.

**Engineering Productivity goals & responsibilities**

In summary Engineering Productivity team wants to make sure that:

- software is released as fast as possible
- software has the highest quality possible
- software works correctly on production

In the past QA team was focused mostly on quality leaving release to developers and maintenance to operation team.

New goals have impact on tasks performed by EP (Engineering Productivity) team. Testers responsibilities change in the
following way:

- More focus on test frameworks, internal consulting and coaching

Demanding business realities usually mean that developers have to write tests. To be fully effective They need
guidance & tools provided by experienced testing specialists.

EP team should also provide correct guidelines. For example 100% unit tests coverage probably won't detect performance
problems. Limited testing effort should be used in correct place.

- Shift left in software engineering process

Obviously testing at the beginning is the cheapest. Spending time on things like IDE plugins, unit tests, code coverage
tools, effective code
review, [OWASP secure coding practices](https://www.owasp.org/index.php/OWASP_Secure_Coding_Practices_-_Quick_Reference_Guide)
usually have high ROI(Return of Investment). EP team should also make sure that no failures are allowed to move
downstream on Continuous Integration process.

- Shift right in software engineering process

Successful release doesn't end EP team duties. They need to constantly monitor how their application perform on
production. See my[Testing in Production](http://www.awesome-testing.com/2016/09/testops-2-testing-in-production.html)
post for detailed techniques how it's done.

I have also covered shift left & right in software engineering process in
my [Continuous Testing](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html) post.

- Need for speed

EP team should make sure that testing doesn't become a bottleneck and it doesn't slow down developers. For example if
Selenium E2E run too long at some point they will stop giving any feedback at all, because people won't run them.

See my [Continuous Improvement](http://www.awesome-testing.com/2017/01/testops-4-continuous-improvement.html) post for
details.

**Roles in Engineering Productivity team**

Looks like there are no _correct_ EP team structure, and it's implementation varies in various companies, but we can
distinguish:

- Test Engineers (TE)

Testers with broad product & business domain knowledge who focus on what should be tested. They drive test strategy and
help to identify product risks. Usually aligned in Scrum Team.

- Software Engineers in Tests (SETs)

Software Engineers (developers) interested in testing domain who build frameworks and tools aiming to speed up software
engineering process.

- Software Engineers, Tools & Infrastructure (SETI)

Google name for SETs.

- Release Engineers, CI Engineers, DevOps Engineers, TestOps Engineers

Highly technical role which focuses on Continuous Integration, Continuous Delivery and whole release process automation.

- Site Reliability Engineers, Software Reliability Engineers (SRE)

Another highly technical role which focus on production platform maintenance, performance, monitoring and scalability.
Google described this role in detail in their [open sourced book](https://landing.google.com/sre/book/index.html).

- Product Owner, Product Manager

According to already mentioned Ashley Hunsberger if we invest in such a big team it should be led by someone who not
only plan work, but also stays in contact with business. Generally speaking he should make sure that EP team goals are
aligned with business goals. I highly recommend Ashley's talk from Selenium Conf 2017
called [Transformative Culture](https://www.youtube.com/watch?v=GYXm8gpE5_c&index=2&list=PLRdSclUtJDYXFVU37NEqh4KkT78BLqjcG)
about this role in EP team.

**Further reading & talks**

- [Overview](http://www.awesome-testing.com/2016/07/testops-missing-piece-of-puzzle.html) 
- [Testing in Production](http://www.awesome-testing.com/2016/09/testops-2-testing-in-production.html)
- [Continuous Testing](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html)
- [Continuous Improvement](http://www.awesome-testing.com/2017/01/testops-4-continuous-improvement.html)
- [How Google Tests Software (book)](https://www.amazon.com/Google-Tests-Software-James-Whittaker/dp/0321803027)
- Ashley Hunsberger - [Blog](https://saucelabs.com/blog/qa-is-not-enough-you-need-to-engineer-productivity),
- [Selenium Conf talk](https://www.youtube.com/watch?v=GYXm8gpE5_c&index=2&list=PLRdSclUtJDYXFVU37NEqh4KkT78BLqjcG)
- Google Testing Blog - [From QA to EP](https://testing.googleblog.com/2016/03/from-qa-to-engineering-productivity.html)
- Manasi Joshi - [GTAC 2016 talk about EP in Google AdSense](https://www.youtube.com/watch?v=Vf7axkwtTOw&feature=youtu.be&list=PLSIUOFhnxEiAeGHYoBZCvEMY5wCOIpyOM)
