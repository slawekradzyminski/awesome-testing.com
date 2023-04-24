---
title: Mapping lean principles to testing
layout: post
permalink: /2016/03/mapping-lean-principles-to-testing
categories:
  - Testing thoughts
tags:
  - lean
  - testops
  - poppendieck
  - test automation
  - agile
  - testing thoughts 
---

![](/images/blog/manifesto-thinklean.jpg)

[Do's and don'ts for testers](https://awesome-testing.com/2016/02/dos-and-donts-for-testers-2016-edition.html) is my most
viewed post so far. Because of that (and because it's always better to leave various doors open) I wouldn't focus on
technical posts only. Time for something my colleague accurately calls computer science belles-lettres.

If you had read
my [Management 3.0 review](http://awesome-bookreviews.blogspot.com/2016/02/management-30-jurgen-apello.html)you know
that I like to get familiar with views on software testing not only from our (QA's) side, by also from our peers (team
members, managers, project stakeholders, and clients) perspective. Actually, in my opinion, focusing only on the
testers' view is probably [ISTQB's](http://www.istqb.org/)biggest flaw. Never mind ISTQB, and let's move to the
business.

Today I gave myself rather ambition task to
map [Lean principles](http://www.slideshare.net/mvax/introduction-to-lean-software-development-5505495)to testing
activities. Why lean? I read recently Mary & Tom
Poppendieck[Lean Software Development - an Agile Toolkit](http://www.amazon.com/Lean-Software-Development-Agile-Toolkit/dp/0321150783)
and Aaron Hodder [blog post](http://testerkiwi.blogspot.com/2016/02/lean-testing-in-theory-and-practice.html)which
inspired me. Also, I like how lean practitioners focus on system thinking, trying
to [optimize the whole](http://qaspire.com/2015/03/09/optimize-the-whole/) instead of a single activity.

So how we, as testers, can adopt lean principles?

**Eliminate waste**

Anything that does not add value to a customer is a waste. In many old software testing books, we can read that every
release candidate has to be blessed by testers, and deployment to production without manual regression is not
acceptable. If you are familiar
with [the Netlflix deployment](http://techblog.netflix.com/2013/08/deploying-netflix-api.html)cycle you know that smart
deployment is possible without any testing at all. However, in most cases, that's not possible, so how do we decide when
to go live?

I think we should measure two things - **the cost of delayed-release** (due to testing) and **the cost of finding a bug
in production**. I can't tell you how to measure it, because it depends on your type of business. Make sure you're not
delaying your awesome feature release because you want to find all bugs in the manual regression process. We can't find
100% of bugs anyway. Simple as that.

So to summarise it I suggest:

- expanding automated checks suite (according
to [test pyramid](http://googletesting.blogspot.com/2015/04/just-say-no-to-more-end-to-end-tests.html))
- hiring skilled exploratory testers which can quickly find flaws in release candidates
- automating deployment and measurement how it's working on production (all those continuous delivery and DevOps stuff)
- calculating costs of activities which I bolded above

**Amplify learning**

This one is simple and hard simultaneously. Software testing is a technical activity that requires more and more skills.
You may like it or not, but the best testers I had encountered in my short career had a broad knowledge of almost
every [do's from my post](http://awesome-testing.blogspot.com/2016/02/dos-and-donts-for-testers-2016-edition.html). So
the recipe here is simple: learn, analyze, make mistakes, fix, learn. Adopting the right mindset may be helpful here (
see
my '[Obstacle is the Way review](http://awesome-bookreviews.blogspot.com/2015/12/the-obstacle-is-way-ryan-holiday.html)').

I'm planning to write a post 'Recommended resources for testers' soon. This may be helpful for you. Stay tuned :)

**Decide as late as possible**

Throughout every software project, the product under development changes considerably (if you don't believe just see
screenshots from an alpha version of video game - [Starcraft](http://starcraft.wikia.com/wiki/StarCraft_alpha) for
example). Because of that preparing, detailed scripted test cases before is a waste of time. We should focus on building
a common understanding of business goals. If you are a BDD practitioner you probably know that's the key to success.

The most popular testing design style - [Page Object](http://martinfowler.com/bliki/PageObject.html)Pattern was
implemented to simplify maintenance work. When you write automated tests have in mind not only stability but and
maintainability. The product will change eventually.

**Deliver as fast as possible**

Make successful delivery of the right product (and in the right quality) your goal. We shouldn't block release just
because we think more will help us find more bugs. I had discussed it already in point 1. Testers should not be
considered as project bottleneck, because smart people tend to focus on them. Yahoo probably thought that, and
they [fixed it](http://spectrum.ieee.org/view-from-the-valley/computing/software/yahoos-engineers-move-to-coding-without-a-net)
spectacularly. Once again, because I think it's important: make successful delivery of the right product (and in the
right quality) your goal.

**Empower the team**

That's right, the team. Not developers, not managers, the team. This means that lean practitioners want to empower you.
All you need to do it to take this responsibility. In healthy companies, power depends on knowledge and experience. So,
theoretically, a tester can be the most important person in a team. Because why not?

**Build integrity in**

According to Poppendieck team, we have two types of integrity:

- Perceived integrity - a system is perceived to have integrity when a user thinks, 'Yes! That is exactly what I want.
Somebody got inside my mind!'

- Conceptual integrity - a system has conceptual integrity when it's stable, expandable, fast, releasable, meets legal
constraints and all those `*ility` testing types you may have encountered in books

It's tester job to think about that and ask developers unwelcome questions during standup meetings. :)

**See the whole**

Last but not least. As I said before, we should always try to optimize the whole project, not just testing. This means
that tester should do some quality control (QC) work too. If the process is inefficient, if we build a bad product it's
our job to report it and give it to consider. We should measure quality be project revenue, not by the number of bugs.
