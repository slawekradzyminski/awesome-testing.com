---
title: What CIA teaches us about productivity
layout: post
permalink: /2017/12/what-cia-teaches-us-about-productivity
categories:
  - Testing thoughts
tags:
  - testing thoughts 
---

![](/images/blog/declassified.jpg)

I've done lots of code-rich posts this year which may leave some of my readers disappointed. Today there would be no
code and the topic would be much broader - productivity. Christmas time favors off-topic so this post (and next one)
would showcase useful things that I have read in 2017.

I'll be using a CIA document that I'm sure most of you haven't heard of -
declassified[CIA Simple Sabotage manual](https://www.cia.gov/news-information/featured-story-archive/2012-featured-story-archive/CleanedUOSSSimpleSabotage_sm.pdf).
It's addressed to agents who were supposed to recruit workforce (saboteurs) in other countries. I suggest to read every
single chapter (just to learn how easily mishandling breaks things), but section 11 _'General interference with
Organizations and Production'_ is absolutely fascinating and would be the core of my post.

Each point would additionally include testing perspective explaining how to apply it in our profession.

**Productivity vs sabotage**

In the simplest possible definitions:

\- productivity is a measure of the efficiency of a person, machine, factory, system, etc., in converting inputs into
useful outputs,

\- sabotage is intentional obstruction of an activity, or willful and malicious destruction of other's property.

To make things even simple we can say that productive employee increases company value, whereas saboteur decreases it (
for example by not allowing it to grow).

**My productivity tips vs CIA sabotage tips**

I'll be formulating productivity suggesting as a opposite of cited sabotage tip. Productivity & active sabotage aren't
of course perfect contradictions, but I'm sure your experience would confirm that it is often the case.

Please do not treat them too seriously ;)

**Don't be afraid to make decisions**

> Insist on doing everything through "channels." Never permit short-cuts to be taken in order to expedite decisions.

It's been proven both by Napoleon and modern military leaders (
see [Team of Teams](https://www.amazon.com/Team-Teams-Rules-Engagement-Complex/dp/1591847486)) that explaining strategy
to subordinates and empowering them to choose appropriate tactics is the most effective way of leading troops. The same
is true for modern leadership - even the smartest person can't decide in matters they have only vague understanding.
It's much better to train people and fully support their decisions.

CIA shows that shrinking the numbers of people who can decide on matters creates management bottleneck and slows down
productivity. Point 3 in Simple Sabotage manual is interesting too: '_Attempt to make committees as large as possible -
never less than five_'. Generally speaking in larger groups every decision process is extremely slow. Also large groups
are prone to [groupthink](http://www.psysr.org/about/pubs_resources/groupthink%20overview.htm).

Testing perspective:

(Un)fortunately software testers have to make decisions every day. We need to decide what can be checked manually, what
requires automation, what functionalities to cover before introducing new functionalities, how much invest in
performance/security testing etc. Also we often have to tell developers how to test their cost in most
efficient/effective way. Don't be someone who shy away from taking responsibility.

**Try and fail fast**

> Advocate "caution." Be "reasonable" and urge your fellow-conferees to be "reasonable" and avoid haste which might
> result in embarrassments or difficulties later on.

The[Lean startup](https://www.amazon.com/Lean-Startup-Entrepreneurs-Continuous-Innovation/dp/0307887898) movement
changed the way approach business these days. Eric Ries discusses organization performance in conditions of extreme
uncertainty. The main theme of the book focuses on shortening feedback loops. Every idea should be tested before moving
into full-scale development. Product doesn't have to perfect, it should just allow us to verify ideas first.
See [Pokemon GO](https://www.itx.com/ITX-Blog/Article/408/Pokemon-GO-is-a-Minimal-Viable-Product) minimum viable
product (MVP) story for perfect example.

Looks like CIA knew that before Eric Ries. Agency suggests their saboteurs 'reasonable' decisions precluded by lengthy
speeches ('_Talk as frequently as possible and at great length_'). The thing is, even after long consideration we can't
be sure that our approach is good. Better to start with faulty idea and change course / iterate later then wait.

Testing perspective:

Automation effort are often thwarted by unreasonable caution. I generally agree with industry leaders that there is too
much bad automation around, however it's more or less similar to every single IT project. Usually there is lots of
enthusiasm at first, but at some point hurdles appear. Always. You will have to face them no matter what.

**Work on the most important items first**

> In making work assignments, always sign out the unimportant jobs first. See that the important jobs are assigned to
> inefficient workers of poor machines.

Prioritization importance is omitted in so called self-help books. Their usual claim is to work like crazy (bad idea)
and strive to attain 'goal' that would 'change your life'. At some there is a realization that not everything can be
done now. I suggest to ask yourself a couple of questions which proven beneficial for me:

- Which task would add the most value to our test suite?
- Which task would bring the most value for our business?
- Which task would improve the system I work with?
- Which task has the highest priority for my peers?

CIA-recruited saboteurs have actually pretty easy job in this matter. It's extremely hard to correctly prioritize
endless stream of work. Always have in mind the importance of it.

Testing perspective:

Software bug enforced Chrome browser update which lead to chromedriver update necessity which lead to... It happens all
the time. Tester's job is very difficult when it comes to finding out proper priorities. Is failed regression test more
important than testing new feature? Is security more important than performance? I let you decide.

**Avoid unnecessary meetings**

> Hold conferences when there is more critical work to be done.

I'm sure you have recently attended a meeting which you summarized as a waste of time. From my experience every non
daily standup meeting that require no prior preparation is a waste of time. I don't like the usual approach that
everyone should attend every meeting - it just doesn't make sense. Especially having in mind that meeting attended by
more then 5 people are recommended by CIA Simple Sabotage manual (see 3a).

Testing perspective:

We are often invited for random meetings as a mysterious quality guardians. That's especially the case on test
management level. The higher you go in company ladder, the more you should watch out for useless meetings.

**Continuously improve**

> Work slowly. Think out ways to increase the number of movements necessary on your job: use a light hammer instead of a
> heavy one, try to make a small wrench do when a big one is necessary, use little force where considerable force is
> needed, and so on."

Continuous improvement is the main ingredient
of [Lean organisation](https://leankit.com/learn/kanban/continuous-improvement/). There are always multiple things to
improve in the way we work. Even such a small things as work hours, coffee, chairs may have significant outcome on
productivity.

I'm sure you saw it before, but it perfectly summarizes my post. Daily 1% improvement can lead to gigantic gains,
whereas 1% sabotage to gigantic losses. It's scary by the way how impactful saboteurs can be.

![](/images/blog/Nr1R3e5.png)

Testing perspective:

My [Continuous Improvement](http://www.awesome-testing.com/2017/01/testops-4-continuous-improvement.html) covers this
topic in detail. I believe that moving the tests on lower, faster levels is usually the highest priority improvement.

**Pass your knowledge**

> Never pass on your skill and experience to a new or less skillful worker.

> When training new workers, give incomplete or misleading instructions.

Having grasped the full content of my post you can't be surprised by teaching necessity. Complex systems are incredibly
complicated (most of them are probably in [Cynefin chaos](https://en.wikipedia.org/wiki/Cynefin_framework) domain) and
new joiners just have to struggle at first.

Remember that the training completes when the trainees not only implement given improvement, but learn to find them all
by themselves. The same goes for prioritization - at first tasks should be assigned, but then trainees should be able to
figure priorities out by themselves.

Testing perspective:

Training testers is very important topic. Usually the job market sucks experts quickly and we are forced to hire
juniors / regulars. I have written many times here that senior testers should be able to effectively pass the knowledge
and coaching/mentoring skills are on high demand.
