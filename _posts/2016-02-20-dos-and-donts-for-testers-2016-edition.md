---
title: Do's and don'ts for testers - 2016 edition
layout: post
permalink: /2016/02/dos-and-donts-for-testers-2016-edition
categories:
  - Testing thoughts
tags:
  - testing
  - testops
  - test automation
  - learning 
---

![](/images/blog/dos_and_donts.jpg)

Time is flying pretty fast. Christmas has just finished and we have February already. Probably everyone who wanted to
post 2016 testing predictions has already done it. Hopefully, I'm the last one (lots of scientists say
it's [the best possible scenario](http://mrshmooze.com/2015/01/13/when-is-the-best-time-to-present-first-middle-or-last/)).
Before I start I'd like to introduce two controversial definitions, which are not covered
in [ISTQB Glossary](http://www.istqb.org/downloads/category/20-istqb-glossary.html). Quotes from James Bach and Micheal
Bolton ([source](http://www.satisfice.com/blog/archives/856)):

**Testing** is the process of evaluating a product by learning about it through exploration and experimentation, which
includes to some degree: questioning, study, modeling, observation, inference, etc.

**Checking** is the process of making evaluations by applying algorithmic decision rules to specific observations of a
product.

I'm not a fan of reinventing the testing field entirely, but this distinction seems pretty reasonable for me.

### Part I - Do's

**1\. Keep learning**

Probably the most important one. It can even mitigate our flaws in other areas. I have recently read great Erik
Dietrich's article about developers who have stopped learning and
become [Expert Beginners](http://www.daedtech.com/how-developers-stop-learning-rise-of-the-expert-beginner/). It can not
only lead to your personal stagnation but also affect our most ambitious peers who may decide
to [change their job](http://www.daedtech.com/how-to-keep-your-best-programmers). We have a great community with many
helpful people. With uncle Google, we find almost everything in space of a few minutes. It seems all we need to improve
is a little bit of desire. Keep your mind open and adapt the beginners' minds. Read an inspirational book
like [Mastery](http://awesome-bookreviews.blogspot.com/2016/01/mastery-robert-greene.html) to find motivation.

**2\. Improve your skills in check automation**

The ability to automate checks in one of the
leading [programming languages](http://blog.testproject.io/2015/12/03/worlds-most-desirable-automation-skills/)(Java,
C#, Python, JavaScript, Ruby...) is crucial. That's definitely the most important hard skill for testers. We should be
proficient with Selenium and API level testing. I'm not sure about unit testing (shouldn't we coach programmers to write
them?), but some knowledge about Mockito and EasyMock is required. Our peers (developers, business, managers) all expect
us to write working (stable!) automated checks on
all [pyramid levels](http://googletesting.blogspot.com/2015/04/just-say-no-to-more-end-to-end-tests.html). Personally, I
hope to spend a considerable amount of time working to improve my skills in this area.

**3\. Learn to manage the testing environment**

It seems like the time when testers asked for deployment and just waited are long gone. Now we should be able to care
about our environment (configure CI tool, manage Selenium Grid, etc.) and prepare appropriate scripts (Bash, Perl).
Servers need to be orchestration by a tool (Puppet, Ansible, Chef...). We have virtualization (Vagrant), clouds (AWS,
Google Cloud), and containers (Docker). This is a lot to learn, but we don't have to be experts in this field (unless of
course, we test app that uses them). They're just useful tools, and we should know how to use them appropriately. I
would say that more and more companies expect testers to maintain those tools not only for themselves but also for
developers.

**4\. Adopt Agile / Lean principles and improve social skills**

Software development
is[a social activity](http://glen-ford.blogspot.com/2009/04/software-development-is-social-activity.html)now. Crazy
geeks who can speak only boolean aren't really desirable. The tester should add value to a team. We need to coach
programmers how to care not only about new features, but also unit tests, quality, and refactoring. I strongly suggest
reading both Lisa Crispin and Janet Gregory's books,
especially [More Agile Testing](http://www.amazon.com/More-Agile-Testing-Addison-Wesley-Signature/dp/0321967054). They
are available via Safari Books. I'm not an expert in Lean, but kaizen / continuous improvement is surely worth applying.
I'd like to read a lot in this area this year.

**5\. Find your niche, specialize in one type of testing**

From my perspective, there is a huge demand for skilled testers. Pentesting has to performed almost in every company,
but even after [the OWASP](https://www.owasp.org/index.php/Main_Page)project, those skills aren't common among testers.
If you love nitpicking give yourself a chance. With various online scanners and powerful tools
like [Burp](https://portswigger.net/burp/), it's no longer rocket science. Performance/user testing skills are desirable
too. Rare testing field specialization is the only reasonable alternative for automation.

**6\. Go Mobile**

Mobile is booming. We are more and more addicted to our smartphones. It's kinda sad, but it's reality. The good company
simply has to have a mobile site version and Android/iOS native app. Those are at least three more products to test.
With [the mobile-first](https://codemyviews.com/blog/mobilefirst) movement, we need to make a good first impression,
i.e. release quality product. There are so
many [mobile testing frameworks](http://testdroid.com/tech/top-5-android-testing-frameworks-with-examples)what this
branch of testing already has its own life. Surely, we will have to join it eventually.

### Part II - Don'ts

**1\. Manual checking is dead**

A few years ago[Google testers](http://www.amazon.com/Google-Tests-Software-James-Whittaker/dp/0321803027)realized that
people in their company are valued by coding skills. So they dumped manual checking completely and started writing
automated checks. Sooner or later this activity will be abandoned entirely (replaced by automated checks and skilled
exploratory tests). If you have doubts just ask yourself a question: would you hire someone who only writes test cases
and checks if it works as desired?

**2\. Don't go all-in on ISTQB certificates**

This topic probably bore you already, so only a few words. Pass ISTQB FL because it may give you an edge during
recruitment, but don't waste time going higher. Read
my [recent post](http://awesome-testing.blogspot.com/2016/01/infamous-testers.html)
or [Rob Lambert's book](https://leanpub.com/theproblemswithsoftwaretesting) for details.

**3\. Don't treat external training as shortcuts**

We are lazier and lazier as a society. That's why we love shortcuts. People naively send SMS, because they except big
rewards. Yet even if they win, they
usually [lose it right after](http://www.cleveland.com/business/index.ssf/2016/01/why_do_70_percent_of_lottery_w.html).
Shortcuts don't work, we have to slowly go forward. Don't expect external coaches to teach you everything. Even if
training is perfect, there is simply not enough time. Make sure you pay for quality stuff before attending.

**4\. Don't be shy**

In my previous post**,**I talked about
our [testing brand](http://awesome-testing.blogspot.com/2016/01/infamous-testers.html). If you are smart share your
knowledge. I guarantee you will gain a lot by doing it. Submit a paper for the conference, start blogging or just
comment here :)
