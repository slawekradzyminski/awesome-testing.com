---
title: Automated testing vs manual testing - security perspective
layout: post
permalink: /2017/03/automated-testing-vs-manual-testing
categories:
  - Testing thoughts
tags:
  - security
  - testing thoughts 
---

![](/images/blog/computer-1591018_640.jpg)

Throughout this document you will see the term 'pentester'. Precise definitions vary, but at its core a penetration
tester's job is to demonstrate and document a flaw in security. In a normal situation, a pentester will perform
reconnaissance to find some vulnerabilities, exploit those vulnerabilities to gain access, then possibly extract some
small piece of data of value to prove that the system is not secure.

With this in mind, read on.

I'm having a lot fun lately trying to figure out various security tools. One of my April/May posts would finally be
technical - I'll show you how to make automated scanners (Burp, OWASP ZAP) more intelligent by using Selenium tests.

'More intelligent' is still far from being smart, i.e. far from being a real human. This leads us naturally to the very
popular automation vs manual testing topic, which I'd like to analyse here.

In my [Testops - Continuous Testing](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html) post
DevSecOps a short description focused mostly on automated tools, omitting the human perspective entirely. Today I would
certainly write it differently. How? Read on.

**Human - manual testing**

Most of the automated functional testing enthusiasts say human intelligence is the number one argument as to why
automated scripts will never replace manual testing entirely. The reason why they are losing more and more ground every
year is very simple - Continuous Delivery. With strong emphasis on short release cycles humans have less and less time
to use their intelligence. They may be sick, they may be out of office, or they may just feel bad.

Eventually we end up having a risk analysis dilemma. Should we release a new version knowing that we may have missed few
bugs? Or should we wait for manual testing to finish? What if we wait and still miss a few bugs? Was it worth it?

In [TestOps - Testing in Production](http://www.awesome-testing.com/2016/09/testops-2-testing-in-production.html) I
described Blue/Green deployment which may greatly reduce the risk of functional bugs. We guarantee ourselves rollback
capabilities, meaning the clients can be redirected to a stable software version almost immediately.

Unfortunately some bugs aren't functional and their impact can't be easily mitigated. Have you heard of stolen customer
data? '[Have I been pwned](https://twitter.com/haveibeenpwned)' informs on security breaches almost daily. It's usually
much wiser to wait for skilled pentesting to finish before committing to a release. The Risk analysis dilemma from
paragraph two skews significantly to one side here.

**Machine - automated testing**

Now, let's say you agree that manual security tests are important. So you finish development and start testing on the
finished software, right? Not really. In agile it's all about iterations. We want to build incrementally, delivering
stuff that works at the end of each sprint. How do you ensure sound security despite tight sprint schedules and lots of
deadlines?

You should start with security awareness in your people. It can be introduced during the recruitment process and then
continuously learned and improved upon. I will soon describe what I mean by security awareness in the TestOps -
Continuous Security post.

With the right people various tools can be used in very efficient ways. We may use Sonar for early whitebox
vulnerabilities detection, OWASP Dependency Check for library scanning, OWASP ZAP for app scanning, Burp for spidering,
fuzz testing for SQL injection/XSS, etc, etc. Below is a screenshot taken from the Kali Linux application folder. All of
those tools can be used during the early development life-cycles.

![](/images/blog/burp.jpg)

Please observe an interesting duality here - manual pentesting can't be done without automated tools, and automated
tools can't be used effectively without skilled pentesting. I'll come back to this statement later.

**Social Engineering**

Some time ago I had the opportunity to read Christopher
Hadnagy [Social Engineering](https://www.amazon.co.uk/Social-Engineering-Art-Human-Hacking/dp/0470639539/ref=as_li_ss_tl?ie=UTF8&qid=1490900806&sr=8-1&keywords=social+engineering&linkCode=sl1&tag=awesotesti-21&linkId=75a7b829b9ac91b9090e4d5cb5976496)
book which is absolutely amazing. In my latest
post ([Learning checklist](http://www.awesome-testing.com/2017/03/learning-software-testing-checklist.html)) I
encouraged you to study the persuasion aspect of social engineering. Whereas Cialdini's Influence covers, more or less,
ethical methods, Hadnagy goes for extreme examples where the attacker's goal is to make a human being lose his mind.

You probably often receive phishing attempts - in most cases these are masterfully crafted emails aiming to encourage
you into doing something (usually to provide credentials, but an attacker may also want to
exploit [CSRF vulnerabilities](https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF))). Interestingly, we
see again that to protect yourself from social engineering we need to study both people as well as technical stuff.

Humans are often the weakest point of the system. Don't ignore social engineering risks during security assessment.
This [McAfee paper](https://www.mcafee.com/hk/resources/reports/rp-hacking-human-os.pdf) nicely describes Social
Engineering basics.

**Conclusions**  

It's amazing how much knowledge you need to absorb to be good pentester. Networking, programming, psychology, social
engineering and a lot more.

Pentesting remains very old-fashioned for a reason - it requires both highly skilled humans and effective software.
Hopefully I have showed you above how intertwined manual & automated testing is when we seek out security holes.

If you like exploratory testing I recommend you delve deeper into security - with the 'break it approach'. You may be
good at it... and earn good money :)
