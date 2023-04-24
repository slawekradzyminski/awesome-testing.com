---
title: Learning Software Testing Checklist - 2017 edition
layout: post
permalink: /2017/03/learning-software-testing-checklist
categories:
  - Testing thoughts
tags:
  - learning
  - testing thoughts
---

![](/images/blog/Unknown.png)

Time flies quickly, and it's been more than a year since one of my most popular
posts - [do and don't for testers](http://www.awesome-testing.com/2016/02/dos-and-donts-for-testers-2016-edition.html).
I decided to skip _dont's_ this year, because I you follow my advices closely you won't have time for them anyway. If
it's possible try to [learn mostly at work](http://www.awesome-testing.com/2016/03/learning-pathways-for-testers.html),
solving real issues. Fill your knowledge gap by reading ferociously after work. Do not hesitate
to [seek mentors](http://www.awesome-testing.com/2017/02/mentorship-how-to-skyrocket-your.html) in each of those fields.

Remember that it's the combination of all those skills that make you great tester. Choose one of them as a
long [T-shaped skills](http://www.ptc.com/product-lifecycle-report/why-engineers-need-to-develop-t-shaped-skills) tail
and become decent at the rest.

Part of the credit for this article belongs to Jasper Ottosen. His quality
post -[Testing roles are shifting](https://jlottosen.wordpress.com/2017/03/08/shift/)helped me confirm that I'm not the
only one who thinks that you should focus on:

## Programming skills

Despite of how often you hear that 'soft skills are the most important' mantra one thing hasn't changed that much
recently:

> Almost every job related to Software Engineering requires strong programming skills. Software Testing is no exception.
> You should be proficient at automating your checks/tests.

Most likely you are surrounded by great developers, and you work with them on daily basis. This is perfect opportunity
for learning begging to take advantage of. Pair with them as often as possible and use their broad knowledge.

_Sidenote:_ Do not steal programmers time asking silly questions. You may quickly discourage them. Google knows stuff.

## TestOps

[TestOps](http://www.awesome-testing.com/search/label/testops) is a loose term which keeps gaining popularity recently (I
like to believe that I helped resurrect it). To be excellent at TestOps (apart from reading
my [posts](http://www.awesome-testing.com/search/label/testops)) work on:

_a) CI/CD proficiency_ - a must for modern tester. Wherever there is possibility to work in this area volunteer and get
it done right. Automated regression tests should be run after each commit if possible.

_b) networking_ - often overlooked skill required to quickly configure web applications and their environment

c) _virtualisation/conternarisation_- make sure you understand how virtual machines and containers work

d) _cloud computing_ \- AWS, Google Clound, OpenStack. It's used everywhere.

e) _[Infrastructure as a Code](https://martinfowler.com/bliki/InfrastructureAsCode.html)_ \- Servers you manage should
come back as quickly as Phoenix (I
recommend [Ansible](http://www.awesome-testing.com/2015/12/testing-with-ansible.html)). Check linked Martin Fowler
article - it's excellent.

## Security - Pentesting 
My avid readers know that I want
to [get into security this year](http://www.awesome-testing.com/2016/12/2016-summary-planning-and-more.html). It's
becoming more and more interesting as I delve deeper into it. Looks like
in[my 2016 post](http://www.awesome-testing.com/2016/02/dos-and-donts-for-testers-2016-edition.html)emphasis on this
topic was too weak.

I recently finished security training run by leading polish company - [niebezpiecznik.pl](http://niebezpiecznik.pl/).
Lecturer was ex tester and I fully agree with one of his statement:

> Testers are excellent at finding security vulnerabilities, because the break-it mindset is already there.

Think about it. Developers often are blind to their errors so who, if not tester, is better qualified to find security
flaws in your application?

With enough TestOps knowledge testers should also lead Continuous Security, perhaps starting
with [OWASP Dependency Check](http://www.awesome-testing.com/2017/02/continuous-security-with-owasp.html).

## Coaching & Persuasion

Another hugely important topic that I overlooked entirely in 2016. Testers understanding how testing pyramid works and
with enough experience are in very peculiar situation. They want to improve application quality, but they also know it
requires whole team effort. Developers play crucial role here - without sufficient unit tests coverage application just
won't be successful. It may of course luckily work on first iteration, but with each new feature it's going to be worse.

So who should explain consequences of poor unit tests coverage? You guessed it right, software testers. What if there's
pressure to release low quality quality software? Who should explain consequences of possible production bugs? You
guessed it right again, software testers. There is no escape from this and the higher you go with your career, the more
important coaching & persuasion become.

Those skills are also important
in [mentoring](http://www.awesome-testing.com/2017/02/mentorship-how-to-skyrocket-your.html).

## Conclusions
[Continuous Improvement](http://www.awesome-testing.com/2017/01/testops-4-continuous-improvement.html) is the key.

## Further reading

Blog:

- [Do's and dont's for testers - 2016 edition](http://www.awesome-testing.com/2016/02/dos-and-donts-for-testers-2016-edition.html)  
- [Testing roles are shifting](https://jlottosen.wordpress.com/2017/03/08/shift/) - Jesper Ottosen
