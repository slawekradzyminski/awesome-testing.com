---
title: TestOps - the most antifragile testing role
layout: post
permalink: /2018/02/testops-most-antifragile-testing-role
categories:
  - TestOps
tags:
  - testops
  - testing thoughts 
---

![](/images/blog/antifragile.jpg)

I have read many fascinating books in 2017 which influenced me a lot. Among the very best are Nassim Nicholas
Taleb's [Fooled by Randomness](https://www.amazon.com/Fooled-Randomness-Hidden-Markets-Incerto/dp/0812975219/ref=asap_bc?ie=UTF8), [The Black Swan](https://www.amazon.com/Black-Swan-Improbable-Robustness-Fragility/dp/081297381X/ref=asap_bc?ie=UTF8)
and [Antifragile](https://www.amazon.com/Antifragile-Things-That-Disorder-Incerto/dp/0812979680/) which is perhaps the
most important, although which can't be fully understood without reading the remaining two. Taleb has a very original
style which is very unique, but I noticed few similarities
to [Thinking Fast and Slow](http://thinking%2C%20fast%20and%20slow/) (Daniel Kahneman)
and [Surely You're Joking, Mr. Feynman!](https://www.amazon.com/Surely-Youre-Joking-Mr-Feynman/dp/0393355624/) (Richard
Feynman). Taleb loves science (especially math), but his books aren't strictly scientific. There are multiple unproven
commonsense theories which I find very smart.

**How to be antifragile?**

Fragility is the quality of being easily broken or damaged by various activities. You may say the opposite of fragility
is toughness, but is it really the case? If we replace 'easily broken or damaged by various activities' into 'easily
strengthened or improved by various activities' we instantly realize that such word is missing in our dictionary.

Well, it was missing. Thanks to Nassim Nicholas Taleb we can come up with the following definition:

> Antifragility is the quality of being strengthened or improved by various activities

If you stop here and think for a moment you may realize that there are not many things which can be labeled as
antifragile. Wine gets better after each year, but after opening, it quickly degenerates. Rock, even though looks
indestructible doesn't improve in any way. What about the content of the book? It usually loses its value over time and
never gets automatically updated. Does publishing second edition of the book increases its antifragility? Nope, it still
can't improve by itself. So which things are antifragile? There is interesting discussion
on [Quora](https://www.quora.com/What-are-some-things-that-are-antifragile)which lists: optionality, mother nature and
evolution.

Let's discuss optionality. How can we take advantage of it? Imagine you and your spouse are working full-time job in
company _A_. As a first step for being more antifragile you should diversify companies. One of you should quit current
job and move to company _B_. In such scenario if comapany _A_ goes bankrupt you still have a steady income from company
_B_.

What if you want to try to create a new company? Should both of you quit your current jobs? If you want to be
antifragile it would be best if none of you quit. You should work after hours and during the weekends. This minimises
the risk of a new company going down (which has high probability) and still leaves you some chance of a huge money from
the new business (which has low probability).

As you probably see already completely antifragile things are extremely rare. We should rather make comparisons. Which
of two options are more antifragile?

Let's consider two career paths: midwife and personal trainer. Theoretically in the era of people who are scared to lift
anything in gym without the coach assistance second occupation looks better. Which of those are more antifragile though?
Most likely midwife because there is very little chance of people suddenly stop having children. Personal trainers can
be replaced with tutorials, videos, or even coaches appointed full-time by gym.

**Why is TestOps antifragile?**

As you probably now already I'm a huge fan of a somehow abstract
term - [TestOps](http://www.awesome-testing.com/search/label/testops). I have resurrected this term from oblivion few
months ago and now a lot of people use it. To put it shortly TestOps can be described as a strong desire to automate
everything. Please have in mind that it's not only about test automation. I mean also Continuous Integration and
Continuous Delivery. Senior TestOps Enginner in my opinion should be master of Unix who knows how to make one-click
production deployment.

TestOps Engineer is also very technical. He can do proper performance test (i.e. fully understand results), he can hack
if necessary, he can also work with his peers following business priorities. If necessary he can even test application
manually. I have created a graph with potential TestOps Engineer job switches:

![](/images/blog/pobrane.png)

As you can see as a TestOps expert you shouldn't really be worried about job loss. You have almost unlimited options on
what to do next. More importantly with TestOps experience you can easily follow the path you love. Whether it's
business (Product Owner), Management (Team Leader) or Software Reliability Engineer (who does a lot
of [testing in production](http://www.awesome-testing.com/2016/09/testops-2-testing-in-production.html)).

**Why it's better to learn programming first before testing basics?**

My acquaintance from days in which I played StarCraft a lot has recently created a very good blog post about
his [job switch into software testing](http://scvconsultants.com/2018/02/08/kilka-rzeczy-o-ktorych-zaluje-ze-nie-powiedziano-mi-gdy-zmienialem-branze-na-it/)(
article in polish, please use Google translator). I'm surprised that polish Software
Testing [Facebook group ](https://www.facebook.com/groups/TestowanieOprogramowania/)found it controversial. One of the
most the discussed item was the following advice (translation by me):

> If you want to become a software tester start learning programming first, testing basics later.

It's worth to analyse this statement in antifragile context. Which skill (programming vs testing) guarantees you more
job possibilities? The answer is very simple here - programming. You can become both software developer and tester. Even
when it comes to testing job chances trust me, a lot of companies care more about test development skills then ISTQB
formulas. Start with programming basics!
