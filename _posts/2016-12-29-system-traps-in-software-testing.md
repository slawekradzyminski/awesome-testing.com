---
title: System traps in software testing
layout: post
permalink: /2016/12/system-traps-in-software-testing
categories:
  - Testing thoughts
tags:
  - testing thoughts 
---

![](/images/blog/system.jpg)

I had written several times on this blog that from my perspective majority of testers today lack full Software
Engineering Life-Cycle (SDLC) understanding. As a community we should also look at our projects not only through
tester's eyes, but also acknowledge stakeholders goals & needs (focusing mostly on customers). In the end our common
goal is to make money for the company, not to ship bug-free software. Recently I read gripping book which may help in
looking at software engineering from different
angle: [Thinking in Systems](https://www.amazon.com/Thinking-Systems-Donella-H-Meadows/dp/1603580557) by Donella H.
Meadows. It's not classic book about SDLC, but rather [systems theory](https://en.wikipedia.org/wiki/Systems_theory)
primer.

I strongly recommend reading Donella's book and those two blog
posts - [Part I](https://medium.com/@Smrimell/it-s-a-trap-systems-traps-in-software-development-dc6341022795#.62m17ayj0), [Part II](https://medium.com/@Smrimell/escape-the-trap-avoiding-traps-in-software-development-with-systems-thinking-cbc20af7c719#.d6nlbrtes)
which extend chapter 5 of the book. Having understood those I figured out I would try to show the same traps in software
testing. All those examples are based on my personal experience, books, blogs and chats with other testers. All quotes
below are from sources listed above.

## Trap 1 - Policy Resistance: separate development teams and testing team

> Otherwise known as ‘Fixes that fail’, this trap prevents system change due to the conflicting needs of multiple actors
> in the system.

Imagine you are creating a complicated system which require multiple parts developed by separate teams. You know that
integration will be painful, so you decide to create new team responsible for end-to-end system testing. Unfortunately
as soon as they start working you realise that most of the integrations don't work and they struggle to pass even the
most basic test case. What happened?

By creating separate team you reduced product responsibility from development teams. In such case they were focusing
more on meeting deadlines at their end than on common goal - making it work for end customer. You also started
waterfall-like process in which teams think only on basic level testing (unit, integration) without E2E perspective.
Performance? Let's leave it to system testing team. They will check that.

Worst of all this separate team of testers which now tries to prove it's usefulness by focusing on finding as many bugs
a possible without thinking of improving the whole process/product.

I understand that having system testing team is sometimes necessary, but always pay close attention how it cooperates
with others.

## Trap 2 - Tragedy on the commons: disposable, temporary tester

> Tragedy of the commons is a systems archetype that describes an escalation in the usage of a common resource,
> eventually resulting in its depletion and ultimate destruction.

Let's say you don't want to invest too much into quality, so you figure out that your testers would temporarily join
projects which require them most. The idea is very alluring, but the results not so much. Developers know that their
code would be tested a some point, but they don't think about quality on daily basis. Again, we have waterfall-like
process. When something is ready for testing you call Mr. Tester, and he joins the project.

At first, it takes some time for Mr. Tester to read all the documentation and requirements. He then performs manual
testing which can't really be called exploratory, because he's application knowledge is nowhere near being expert (those
are all basic checks really). Soon he's more familiar with a team and project he's ready to start improve the process
and automate test cases. But what happens? He's delegated to different project and everything starts again.

If you ever want to get rid of testers in your organisation this is a way to go. They'll be so demotivated after working
in such style that they will leave on first opportunity. Tester is not a commodity.

## Trap 3 - Drift to low performance: getting used to poor tests

> Drift to low performance describes a trap where a system not only resists positive change, but continually drifts
> towards poorer performance.

Failed tests? Ignore them. Flaky tests? Ignore them. I'm pretty sure every tester know what I'm talking about. This is
why reliability of automated test suite is crucial. If tests start to fail developers care less and less ignoring them
at some point entirely. Worst of all even valid findings are getting lost in flakiness noise.

This is classic example of drift to low performance and by doing nothing about it situation quickly gets out of control.
As a tester you should act fast. Identify issues, prepare a plan and involve product owner into task prioritisation. You
shouldn't work alone on fixing that (quality is everyone responsibility).

Google Testing Blog has nice post
about [flakiness](https://testing.googleblog.com/2016/05/flaky-tests-at-google-and-how-we.html).

## Trap 4 - Escalation: rating testers by number of bugs found

> This trap is about keeping slightly ahead of the Joneses.

Perfect sub-optimisation example - you start rating your local or outsourced testers by number of bugs reported. If you
add priorities into the mix it's even worse. You end up with dozens of over-prioritised tickets and daily developer vs
tester arguments.

Not a great way to create common goal mindset. Don't do it. No exceptions here.

If you really want to somehow rate your individual tester ask people he works with and gather
feedback. [360-degree feedback](https://en.wikipedia.org/wiki/360-degree_feedback) is the most popular way of doing it.

## Trap 5 - Success to the successful: giving up testing improvement in legacy apps

> The rich get richer while the poor stay poor.

It's easy to say that monolithic applications can't be tested in effective, unreliable and fast way. A lot of people at
this point start dreaming about microservices migration and future in which everything would be much easier. What about
now? Why bother? It would better soon.

Well, no. Testers should improve continuously having in mind what's now and what we release for customers now. Are you
testing GUI or through GUI? Are your test following test pyramid as much as possible? Do you setup your tests in most
effective way? Are your tests covering as much as possible?

There is so much things we can improve daily that we should never ever give up on that. Poor don't always have to be
poor.

## Trap 6 - Shifting the burden to the intervenor: blaming tester for poor quality

> Addiction occurs when reliance on a particular solution to a problem undermines the capacity of the system to support
> itself.

In ancient times it was dangerous to report bad news. Kings in their delusional rage may have ordered to kill you, even
when you were just messenger. Surprisingly scapegoating is still popular, and as a testers we may be in danger.

Not long ago someone thought that testers should be 'promoted' into quality keeper role. He certainly didn't read
Donella's systems theory book, cause the experiment failed dramatically. Developers had a perfect excuse not to test too
much. It was quality keeper responsibility to make sure their code works. And if something went wrong on production?
Blame tester. He didn't find the bug.

Once again - quality is everyone responsibility. Quality is also the result of complicated system and no single person
has the power to improve it alone.

## Trap 7 - Rule beating: dummy Definition of Done activities

> You have a problem with rule beating when you find something stupid happening because its a way around the rule.

[Definition of Done](https://www.scrumalliance.org/community/articles/2008/september/what-is-definition-of-done-(dod)) -
very useful checklist in determining if we have finished our work on given feature or not. DoD should be very carefully
written though (tester should be actively involved in creating it btw). Don't add unreal amount of testing until you are
ready from automation point of view.

Let's say you check you data and find 5 most popular desktop resolutions, 5 browsers and 5 mobile devices. Even with
this relatively low number it's almost impossible to cover it manually. Before adding it to DoD create visual
verification test suites with [Galen Framework](http://galenframework.com/)
or [BackstopJS](https://github.com/garris/BackstopJS) and run functional tests on various browser. I don't recommend
doing it in opposite way, because most of the manual checks would be omitted entirely, or done just to follow the law
with resentment.

I recommend creating a document of supported configurations and let teams decide the correct amount of testing. Risk
assessment is much better than dummy activities just to follow the bad rules.

## Trap 8 - Seeking the wrong goal: quality by numbers

> This trap often occurs when one’s progress towards a goal is evaluated via a proxy measure rather than the goal
> itself.

With 90% code coverage we can be sure that everything works well. Well, sort of. If you enforce level of coverage bad
things start to happen. Developers write tests not because they think it's useful, but because they need to reach magic
number required by code coverage tool. I don't like this approach. I may be little naive, but I like to let others
decide how to their job in the best possible way.

Instead of enforcing a value testers should show the developers value of extensive unit tests safety net. Interestingly
enough most of the programmers don't want to work with legacy code. It's hard to refactor the code without unit tests
though... so conclusion is obvious.

From my personal observations senior software engineers write a lot more unit tests than beginners. With their vast
experience they understand the value without any quality gates.

The only reliable product quality metric can be customer satisfaction and amout of money you made selling your products.
