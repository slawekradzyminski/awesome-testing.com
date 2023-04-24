---
title: TestOps - Continuous Improvement 
layout: post
permalink: /2017/01/testops-4-continuous-improvement
categories:
  - TestOps
tags:
  - testops
  - learning 
---

[![Oscar De La Hoya Continuous Improvement quotation](https://4.bp.blogspot.com/-LEGBZzRgHVg/WHoI1mNkZVI/AAAAAAAACj8/l_BPjsJiVaAb4saZILsVsjLpjZmrExnzQCLcB/s400/There-is-always-space.jpg)](https://4.bp.blogspot.com/-LEGBZzRgHVg/WHoI1mNkZVI/AAAAAAAACj8/l_BPjsJiVaAb4saZILsVsjLpjZmrExnzQCLcB/s1600/There-is-always-space.jpg)

**Continuous Improvement / Kaizen introduction**

According to [Wikipedia](https://en.wikipedia.org/wiki/Continual_improvement_process) Continuous Improvement is a
never-ending process which focuses on increasing the effectiveness and/or efficiency of an organisation to fulfil its
policy and objectives. It was popularised by Lean movement in manufacturing and business. Usually Continuous Improvement
efforts include identifying opportunities for streamlining work and reducing waste.

[Kaizen](https://en.wikipedia.org/wiki/Kaizen) is the practice of Continuous Improvement which was first defined in
1986 [Kaizen: the key to Japan's competitive success](https://www.amazon.co.uk/gp/product/007554332X/ref=as_li_tl?ie=UTF8&camp=1634&creative=6738&creativeASIN=007554332X&linkCode=as2&tag=awesotesti-21%22)
book. You may think of it as a philosophy which focuses strongly on constant improvement of everything. I'd like to show
in this post how to adopt such approach into your TestOps activities.

**Beginner's Mind benefits**

In order to adopt Continuous Improvement philosophy you need healthy level of certain characteristic - modesty. Unless
you realise that not everything you do is perfect positive change is impossible.

Some time ago I found random article about Beginner's Mind which is a approach from Zen Buddhism. Zen Master Shunryu
Suzuki said,
in [Zen Mind, Beginner's Mind: Informal Talks on Zen Meditation and Practice](https://www.amazon.co.uk/gp/product/1590308492/ref=as_li_tl?ie=UTF8&camp=1634&creative=6738&creativeASIN=1590308492&linkCode=as2&tag=awesotesti-21%22):'
_In the Beginner's Mind there are many possibilities. In the expert's mind there are few_.'

In terms of learning I recommend trying to be a child again. Imagine 3 year old kid with almost insatiable level of
curiosity. Everything is new. Everything is fascinating. Everything is worth a try. Nothing should be left unexplored.
Risk of failure is non existing.

_Sidenote:_ I added 'healthy' word alongside modesty because in some situation you have to make bold demand. Job salary
negotiation is perfect example. Set your prize high
and [aim to earn above average](http://www.awesome-testing.com/2016/03/learning-pathways-for-testers.html).

**Continuous Improvement in TestOps**

I decided to focus on Continuous Improvement in
my [TestOps series](http://www.awesome-testing.com/search/label/testops), because I consider it necessary component for
success. IT industry is very demanding and without it you risk failing behind.

Here is my list of the most important things which can be constantly improved:

**Building the Pyramid**

[Thousands of workers](https://www.youtube.com/watch?v=lbrbNRhLbQ0)had to work in order to build Egyptian pyramids.
Creative effective [test pyramid](https://martinfowler.com/bliki/TestPyramid.html)today is much easier, and you should
take full advantage of that. It's surprising that there is quite a few articles about correct test design, yet
possibility of changing test strategy which turned out to be ineffective (not rare event
as [testing is sometimes harder](http://james-willett.com/2016/10/8-reasons-why-software-testing-is-harder-than-development/)
than actual development) is rarely analysed.

Applications, frameworks, requirements and almost everything in IT change over time. It may of course change to worse,
but I'm sure there is one thing that improved since last year - your knowledge. Look critically at your test scenarios
and ask yourself simple question: is there something that can be improved? For example let's say your application has
now new APIs available. Do you still test through GUI or have you moved your scenarios to service level?

Probably we all love Selenium tests as they're fun to create, but some functionalities can really be covered by unit
tests. That's huge amount of time and maintanability effort saved.

**Need for Speed**

Napoleon Bonaparte once said that '_Space we can recover; time never_'. Tests that don't give fast feedback are often
very frustrating, because they require context switching. It's not a big deal when real application bug was found, but
once it turns out to be a flake developers tend to lose faith in test suite reliability immediately.

Overall execution time should be carefully measured and never ignored. Parallelism in test execution is a must today,
and it's not even hard to achieve. All top frameworks support it, and for Selenium we have Grid.

Sometimes operational work has to be done in this area, hence good TestOps should be on top of things here.

**Refactor**

Every single line of code needs to maintained. Tester/developer maintenance work isn't free, so we can safely assume
that every single line of code cost your company money.

Programmers often ask POs for refactor time which not only makes work easier for them, but it also saves some money. We
should treat testing code in the same way as production code. That doesn't only mean that it should be in the same
repository, but also that there is necessity to make it better every day.

With IntelliJ IDE refactoring is pretty easy. Are you using it's features fully? Do you improve the code in the area
close to your current task?

**Automate Everything**

TestOps is all about automation. It doesn't mean only for testing, but also for infrastructure.
Actually, [Site Reliability Engineers](http://amzn.to/2jkXDHw)would argue that ability to recreate your testing
environment from scratch in seconds (using [Ansible](http://www.awesome-testing.com/2015/12/testing-with-ansible.html)
for example)is not enough. It should also be self-healing.

[Continuous Testing](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html)is prerequisite for fast
and quality software releases.

**Embrace Cloud Computing & Open Source Software**

This point is closely connected to c) and d). Effective usage of Spring Boot allows you to create working app in very
short time. Various people and companies offer working software which reduces our maintenance efforts. It not only saves
us time, but also money. Why not utilise them?

Physical servers require space, maintenance, management and constant cooling. Perhaps small server in the cloud would be
cheaper?

**Read**

Few years ago I started reading a lot a book. Now it's my habit and I feel really weird if I hadn't had a chance to do
that. Since then almost every aspect of my life improved, including personal relationships. I even dare to say that:

> Reading is a way to acquire someone else's experience.

You really should expand your testing knowledge and see how it's done in various companies.
Perhaps [How Google Tests Software](http://amzn.to/2iyhrK4)is a good place to start. Image you are asked on job
interview about the latest testing book you have read. What would you answer?

**Conclusion**

Adopting Continuous Improvement mindset is very beneficial in every single aspect of your life. I'm pretty sure that the
very best people you know all practice it a lot. Why not utilise it in testing as well?

**Further Reading**

Blogs:  
- [TestOps #3 - Continuous Testing](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html)
- [Learning Pathways for Testers](http://www.awesome-testing.com/2016/03/learning-pathways-for-testers.html)
- [Do's and dont's for Testers](http://www.awesome-testing.com/2016/02/dos-and-donts-for-testers-2016-edition.html)

Books:
- [Lean Software Development](http://amzn.to/2jGXvBO)
