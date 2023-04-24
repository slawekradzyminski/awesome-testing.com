---
title: Tester's toolbox - an alternative guide
layout: post
permalink: /2016/04/testers-toolbox-alternative-guide
categories:
  - Toolbox
tags:
  - resources for testers
  - testing
  - pentesting
  - BDD
  - test automation
  - UI testing
  - learning
  - testing tools
  - automation
  - usability testing 
---

![](/images/blog/bob.png)

When you type 'test tools' in Google you can see a lot of links to Selenium, cURL, Cucumber, or even Firefox. I agree
they are useful, but we are testers, and we shouldn't test tools, but real systems. Below I give a lot of links to
playgrounds when you can train your skills. I hope this will help you to understand that you should always pair 'test
tool' with the system you test, not vice-versa. Also, in my opinion, by solving real problems you learn faster than by
following tutorials.

## GUI testing

- [automationpractice.com](http://automationpractice.com/)- This is a virtual shop that was designed for testing purposes
only (unfortunately it's in maintenance mode as I write this post...)

- [the-internet.herokuapp.com](http://the-internet.herokuapp.com/) - Fantastic site with real exercises :)

Use the same sites for Mobile app testing.

## API testing

- [httpbin.org](http://httpbin.org/)- Fantastic resource for everyone tired of flaky GUI tests and wants to go lower. All
endpoint responses (except /XML) are JSON-encoded.

- [jsonplaceholder.typicode.com](http://jsonplaceholder.typicode.com/)- Fake online REST API for testing and prototyping.
I have a few tests written against Java + RestAssured. I will show them in one of the future posts.

- [requestb.in](http://requestb.in/)- Testing POST requests I be tricky sometimes. This site allows you to generate a
private endpoint where you can send everything you want. All that can be verified in a human-friendly way.

## Integration & Unit testing

I believe this should be mainly developers' duty, but it wouldn't be bad to have some skills in this area too. Don't
look for online tutorials, just exercise your app, or delve into framework code (deeper understanding may help you write
better tests on higher levels as well).
Examples: [Selenium](https://github.com/SeleniumHQ/selenium), [RestAssured](https://github.com/jayway/rest-assured), [Appium](https://github.com/appium/appium).

## White-box code internal testing

- [www.javadeathmatch.com](http://www.javadeathmatch.com/)- a cool site that allows you to identify code smells. It even
has multiplayer mode :)

## Mail testing

- [mapil.co](http://mapil.co/)- As a tester, you probably know how annoying and time-consuming testing emails can be. Mail
can make it smoother - it stores emails for us and allows us to query them using custom API.

## Text messages and call services testing

- [tropo.com](http://tropo.com/)- Tropo adds communications features to your app with just a few lines of code. Free for
development & testing.

## BDD, Cucumber & other frameworks

- [www.softwaretestinghelp.com](http://www.softwaretestinghelp.com/cucumber-bdd-tool-selenium-tutorial-30/)- This is a
little bit tricky because BDD requires clearly defined use cases. I managed to find them here.

## Testing basics - writing test cases

- [testingchallenges.thetestingmap.org](http://testingchallenges.thetestingmap.org/)- The site has few exercises which all
you to identify all the tests required for given scenarios, and then evaluate it. Mostly for beginners.

## Usability testing (user testing)

- [nngroup.com](https://www.nngroup.com/articles/task-scenarios-usability-testing/)- this is tricky once again. Try to
identify scenarios for your app & context using those tips. Really cool article

## Penetration testing

The hacking community seems to be very active and resource-rich. If you want to train you can easily find quite a few
resources. Let me give you just a couple of them (most of them
from [the sekurak](http://sekurak.pl/trenowanie-testow-penetracyjnych-na-zywych-systemach/)polish security portal).

- [21LTR](http://21ltr.com/2012/06/19/21LTR-Scene-One-LiveCD/)

- [PenTestLaboratory](http://pentestlab.org/project/lab-in-a-box/)

- [Exploit Exercise](https://exploit-exercises.com/)

- [Metasploit](https://www.offensive-security.com/metasploit-unleashed/requirements/)

- [Hack This Site](https://www.hackthissite.org/)

- [Game of Hacks](http://www.gameofhacks.com/)

## Text testing

- [Text Test](http://texttest.sourceforge.net/index.php?page=main)- If you want to compare texts (like log outputs) this
tool is for you. TextTest is an open-source tool for text-based functional testing.

## Performance, load, stress testing

I didn't manage to find any punching bags. Any suggestions? It seems like you have to stick with your own website or
app.

**But I want to learn a few things first...**

Ok, here are some awesome links :)

- [Useful Java Links](https://github.com/Vedenin/useful-java-links/#iv-testing)- Fantastic list of useful Java frameworks,
libraries, software, and hello worlds examples. If Java is your main language you should really check it.

- [Awesome Test Automation](https://github.com/atinfo/awesome-test-automation)- A curated list of awesome test automation
frameworks, tools, libraries, and software for different programming languages. In many programming languages.

- [Awesome Penetration Testing](https://github.com/enaqx/awesome-pentest)- A collection of awesome penetration testing
resources.

The list is by no means complete. What else can you suggest?
