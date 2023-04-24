---
title: How to start learning test automation
layout: post
permalink: /2016/08/how-to-start-learning-test-automation
categories:
  - Testing thoughts
tags:
  - learning 
---

![](/images/blog/selenium.png)

In one of my previous
posts - [How to become a software tester](https://awesome-testing.com/2016/06/how-to-become-software-tester.html), I
gave you 10 practical advice on how to get yourself running in a fascinating software testing industry. On another
post - [Learning pathways for testers](https://awesome-testing.com/2016/03/learning-pathways-for-testers.html), which
was addressed for more experienced engineers, I described how to thrive as a tester not only now, but also in the long
run. Today I'd like to describe a topic which places somewhere between those two. I know that there is a lot of people
who do only laborious manual testing and would like to automate it but don't know-how.

The following post is based on my personal experience (as I successfully completed such a journey for myself) and
numerous online discussions.

### Prerequisites 

Before you start the est automation journey make sure you have at least a basic understanding of the following topics:

**1.** Agile and general software development life cycle knowledge

Testing should be actively presented throughout each software development life cycle phase. You need to make sure that
your application would be testable. Some decisions made at the beginning of the project can greatly simplify automated
testing. For example sites with nicely implemented 'id' names are much easier to test via Selenium.

Thankfully there are two great books on this topic written by Lisa Crispin and Janet
Gregory - [Agile Testing](https://www.amazon.com/Agile-Testing-Practical-Guide-Testers/dp/0321534468/)
and [More Agile Testing](https://www.amazon.com/More-Agile-Testing-Addison-Wesley-Signature/dp/0321967054/).

**2**. Continuous Integration, Delivery, and Deployment basic knowledge

You need to understand where testing stands when it comes to CI & CD. Think for a moment where would you like to place
testing in your application pipeline.

Jez Humble and David Ferley wrote a nice book about this topic, which you really should read,
called [Continuous Delivery](https://www.amazon.com/Continuous-Delivery-Deployment-Automation-Addison-Wesley/dp/0321601912).

**3.** Test automation return of investment consideration

This is a very complicated topic (
see [SQE training](http://www.sqetraining.com/sites/default/files/articles/XDD8502filelistfilename1_0.pdf)
and [ISPE](https://www.ispe.org/pe-ja/roi-of-test-automation.pdf)papers for details) and your expectations should be
real. Do not think that automated tests would solve all the problems and magically improve application quality.
Automation done wrong can give you a lot of headaches. Don't forget that the test automation code almost always requires
maintenance.

### Motivation - Personal benefits of being a highly technical tester

If you're still not sure whether automation path is correct, here is a list of obvious benefits that can motivate you:

**1.** More fun

If you have ever done manual regression testing you know the pain.

Technical tester analyses problems, investigate possible solutions, implement them, on an almost daily basis. The job
becomes more and more intellectually demanding. You start taking coffee breaks not only because you're bored, but
because your mind really needs them.

**2.** More possibilities

By expanding your knowledge on the automation field you become more and more desirable not only by peers but also for
recruiters. Your employability is skyrocketing. This gives you a certain level of security - you know that even in the
unlikely event you got fired, you will quickly find a new job.

**3**. More respect

In [How Google Tests Software](https://www.amazon.com/Google-Tests-Software-James-Whittaker/dp/0321803027)authors
describe that at one point they realized a simple truth - in order for them to be fully respectable team members, they
need to start coding. They finished the journey and are now Currently they are fully integrated team members (as you can
read in
nice [Trish Khoo interview](http://blog.fogcreek.com/embedded-testers-in-development-teams-interview-with-trish-khoo/)).
Aim for the same.

**4.** More money

With more skills come more money. Simple as that :)

### Learning at work 

You should have as many learning opportunities at work as possible. This requires both companies that understands test
automation benefits and skilled people around you.

**1.** Company consideration

> There are three types of management commitment needed for successful test automation: money, time and
> resources.[Automated Testing Handbook](http://www.softwaretestpro.com/itemassets/4772/automatedtestinghandbook.pdf)

Test automation is a software engineering project. It needs to planned, managed, developed, and maintained by skilled
people. As a lone manual tester without necessary programming skills, you won't be able to transition. This is harsh
true whether you like it or not. You can play with Selenium on free time, but don't expect anything fancy. Get
managerial buy-in, change project, or seek junior tester position somewhere else.

After acquiring basic skills you will be able to choose correct frameworks, languages, setup CI, etc., but you really
shouldn't do that as ex manual tester. Don't fight uphill battle... yet.

**2.** People consideration

If you're my avid reader you know how my emphasis I put on mentorship. This is especially true when it comes to skill
transition. You really should begin your journey with someone who can help you get started. Focus on writing automated
tests and expanding your programming knowledge only. Skilled mentor or just senior tester can give you fast feedback,
propose solutions, review code, and show areas of improvement. He can also handle a few harder tasks for you so that you
won't get stuck at one thing forever.

Always try to surround yourself with smarter people.

### Learning after work

If you're determined enough to learn you can do that after work by yourself. This obviously has a multitude of
drawbacks. I don't recommend it, make sure you have used every opportunity for learning at work first. After finishing
something try to seek mentors online as it's always better to have your work
reviewed.[Here](https://awesome-testing.com/2016/06/how-to-become-software-tester.html)is a decent list of helpful
online communities.

I'll give you two recommended learning paths. I chose Java, Selenium, and Rest-Assured because they have a multitude of
online tutorials. If you happen to know any other language use it. In case you get stuck use Google to find solutions.
There would be plenty of them available.

**Path 1 - GUI Automation with Selenium**

1\. Learn the basics of programming language first - preferably with [Java for Testers](http://javafortesters.com/)
book.

2\. Learn the basics of Selenium - preferably with [Guru99 Selenium](http://www.guru99.com/selenium-tutorial.html)
course.

3\. Start writing real tests on the existing website, for
example,[http://the-internet.herokuapp.com/ ](http://the-internet.herokuapp.com/)

4\. Make sure you understand how Maven/Gradle, TestNG/Junit work.

**Path 2 - REST API Automation with Rest-Assured**

1\. Learn the basics of programming language first - preferably with[Java for Testers](http://javafortesters.com/)book

2\. Learn HTTP protocol with[HTTP: The definitive guide](http://shop.oreilly.com/product/9781565925090.d)

3\. Learn about REST API - Microsoft has recently published
its [API Guide](https://github.com/Microsoft/api-guidelines/blob/master/Guidelines.md) with useful links

4\. Learn Rest-Assured
with [Baeldung](http://www.baeldung.com/rest-assured-tutorial), [Test Detective](http://testdetective.com/rest-assured-framework-overview/)
or some different guide (there is plenty of them)

5\. Write tests against real API.
Check [my post](https://awesome-testing.com/2016/07/restful-api-testing-with-rest-assured-1.html)which you can use as a
reference.

6\. Make sure you understand how Maven/Gradle, TestNG/Junit work.

After completing those two paths you shouldn't have problems finding a new & better job.
