---
title: Best software testing books - 2
layout: post
permalink: /2020/06/best-software-testing-books-2
categories:
  - Books
tags:
  - learning
  - books
---

![](/images/blog/photo-1457369804613-52c61a468e7d.jpeg)

**Introduction**

My first post about
the [best software testing books](https://www.awesome-testing.com/2017/04/best-software-testing-books.html) introduced you
to a few great titles which should be read by every ambitious software tester. After three years of reading, I'd like to
expand my list.

Before I start a side-note. Don't read only technical or self-improvement non-fiction books. Create a habit of reading
every day first and pick serious titles only from time to time. Reading can be a pleasurable experience that brings you
joy. After a while, you start noticing connections and build wisdom that transcends every field (including software
testing). Arguably, [The Count of Monte Cristo](https://www.amazon.com/Count-Monte-Cristo-Penguin-Classics/dp/0140449264)
can be considered as systems thinking book. There is only one way of seeing such connections: read, read, read...

**[Complete Guide to Test Automation](https://www.amazon.com/Complete-Guide-Test-Automation-Maintaining-ebook/dp/B07FKGVQP6)- Arnold Axelrod**

![](/images/blog/testautomation.jpg)

A surprisingly unknown book. The first part contains an in-depth description of every possible aspect of test
automation. The author goes through the whole journey from old-school manual testing to modern continuous delivery
solutions. We can read about topics like record-playback tools (and why are they unreliable), the importance of test
stable test environments, fast feedback loops, flaky tests, isolated tests, etc.

The human aspect is considered as well. Automated tests require good programming skills. Who should write them? How to
convince business stakeholders that they're worth the effort? How to accommodate them into the team process? Arnon
Axelrod answers all those questions.

The second part expands the preceding section with practice. Instead of theory, we have actual test automation code (in
C#), test environment, and CI setup.

I liked this book so much because the author went from answering 'why' question (part one) into answering 'how'
question (part two). That's pretty much how I structure my blog posts as well. If you want to understand what kind of
problems testers solve every day grab your copy now.

**[Thinking-Driven Testing](https://www.amazon.com/Thinking-Driven-Testing-Reasonable-Approach-Quality-ebook/dp/B07BN17VZ7)-
Adam Roman**

![](/images/blog/thinking.jpg)

I recommend this book for four different reasons:

a) Fundamentals of Software Testing chapter is an excellent knowledge refresher. It's 50 pages of the condensed theory
explained in easy words. I recommend you read it every time you go to a software testing job interview. Much better than
ISTQB Foundation Level Syllabus.

b) It goes against the current fashion of elevating the importance of test automation. Contrary to what most temporary
testing writers (including me) present in their text testing != automation. Adam Roman claims that the most important
thing in testing is thinking, analyzing, and creating good, effective tests.

c) The author recommends a multidisciplinary approach. My readers know that I often seek connections between testing
craft and other fields (systems thinking, antifragility, testops, etc.). Adam Roman goes as far as to connect philosophy
with testing. I loved the explanation of why testers should have a broad set of various skills. Fully agree.

d) We have something new: the TQED modal. Time, Quantity, Events, and Data. Those are the four distinct things you
should build your test cases on. How? Read a book.

**[Fundamentals of Software Architecture](https://www.amazon.com/Fundamentals-Software-Architecture-Engineering-Approach-ebook/dp/B0849MPK73)-
Mark Richards & Neal Ford**

![](/images/blog/architecture.jpg)

To effectively test your system you need to have a complete understanding of it. During job interviews, I'm often
surprised by how shallow software testers describe applications they test. A lot of the times even basic questions
like 'how web services communicate between each other' or 'what is the technology stack' are too hard.

Gaps in knowledge are especially glaring for asynchronous, event-based communication. Whenever there is a message broker
involved in a SUT the testers tend to struggle. Of course, such architectures are harder to test but the first step is
understanding.

As remediation, I suggest reading a book about software architecture. Here is my recommendation. Fundamentals of
Software Architecture were published in 2020 so you are guaranteed to have the latest architectural trends covered by
it.

**[Incerto](https://www.amazon.com/Incerto-Deluxe-Randomness-Procrustes-Antifragile/dp/198481981X)- Nassim Nicholas
Taleb**

![](/images/blog/incerto.jpg)

In the first post, I
recommended [Thinking Fast and Slow](https://www.amazon.com/Thinking-Fast-Slow-Daniel-Kahneman/dp/0374533555) by David
Kahneman. Books which sharpen thinking skills should be read regardless of your current profession. I find each of
Nassim Nicholas Taleb very interesting, hence Incerto (which is a whole bibliography) recommendation.

My readers may be already familiar with the antifragility concept which I explained
in [TestOps - the most antifragile testing role](https://www.awesome-testing.com/2018/02/testops-most-antifragile-testing-role.html).

[The Black Swan](https://www.amazon.com/Black-Swan-Improbable-Robustness-Fragility/dp/081297381X/) explains how unlikely
events (like COVID pandemic) are largely ignored during risk calculation. I am almost certain that you ignore them
during feature planning as
well. [Fooled by Randomness](https://www.amazon.com/Fooled-by-Randomness-audiobook/dp/B0012IZFRW) follows up this
concept.

[Skin in the Game](https://www.amazon.com/Skin-in-Game-audiobook/dp/B077BSK9LC) presents an interesting decision
framework based on self-accountability. According to an author, you should avoid relying on people who don't risk
anything by their mistakes. That would mean all kinds of financial recommendations, journalism, economic predictions,
etc. In the IT world, you should pay special attention to consultants employed part-time.

**[Professional Javascript for Web Developers](https://www.amazon.com/Professional-JavaScript-Developers-Matt-Frisbie/dp/1119366445)-
Matt Frisbie**

![](/images/blog/javascript.jpg)

A single language book recommendation? You may be wondering why I selected JavaScript instead of other languages. The
reason is simple: Javascript is running in your browser right now. Every software tester was, is, or will be testing a
web application. That's the future you should be prepared for.

Atwood’s Law says that any application that canbe written in JavaScript will eventually be written in JavaScript. I'm
not convinced entirely, but right now we have Node.js for backend and React Native for mobile. That means your whole
technology stack can be based on a single programming language.

In the testing world, the trend seems to go towards JavaScript as
well. [Puppeteer](https://github.com/puppeteer/puppeteer), [WebDriverIO](https://webdriver.io/),
and [Cypress](https://www.cypress.io/) seem to be preferred choices in browser automation. API can be tested
with [Jest](https://jestjs.io/), [Mocha](https://mochajs.org/), [Chai](https://www.chaijs.com/), [Sinon](https://sinonjs.org/),
etc. Even for performance testing, we have a new [K6](https://k6.io/) tool.

Also, don't be discouraged by the world 'professional'. On more than 1000+ pages you will find basic, intermediate, and
advanced theory.

**[Leonardo da Vinci](https://www.amazon.com/Leonardo-Vinci-Walter-Isaacson-ebook/dp/B071Y385Q1/ref=sr_1_1?dchild=1&keywords=Leonardo+da+vinci&qid=1591035104)-
Walter Isaacson**

![](/images/blog/davinci.jpg)

Every good tester I know is very curious about how things work. Leonardo da Vinci is perhaps the most curious-driver
person who ever lived. Apart from painting, he was doing post-mortem examinations, architecture, wetland drying,
cannons, mines, siege machines, and much more. Just take a look at how his
famous [motivation letter to Ludovico Sforza](https://genius.com/Leonardo-da-vinci-letter-to-ludovico-sforza-annotated)
looked like.

I feel like there is too little multidisciplinary in the world right now. That applies to testers as well. Don't sit
too long in one project. If you test the web seek a movement into mobile native apps testing. Try a new tool, language,
approach. Expand soft skills. Do something, just like Leonardo da Vinci would do. You will find inspiration here.
