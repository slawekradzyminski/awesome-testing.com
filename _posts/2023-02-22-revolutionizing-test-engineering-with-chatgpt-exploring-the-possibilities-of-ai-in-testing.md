---
title: Revolutionizing Test Engineering with ChatGPT
layout: post
permalink: /2023/02/revolutionizing-test-engineering-with
categories:
  - Generative AI
tags:
  - AI
  - ChatGPT
  - test automation 
---

![](/images/blog/b9093e86-a249-44ed-88bb-b9a578fd5ac0_nEcoIDXz_400x400.jpg.webp)

The field of test engineering is constantly evolving, with new tools and technologies emerging every day. One such
innovation is the use of language models like ChatGPT in test engineering. ChatGPT's ability to generate text based on
patterns it has learned from large amounts of training data has the potential to revolutionize the way we approach
testing. In this blog post, we will explore the various ways that ChatGPT could impact the craft of test engineering,
including its use in generating test cases, improving test coverage, and automating test maintenance. Whether you are a
seasoned test engineer or just starting out, this post will give you a glimpse into the exciting possibilities that
ChatGPT offers for the future of testing.

Here are top 5 examples I use daily in my various freelancing gigs:

### Test generation

ChatGPT has the capability to generate UI test examples in various programming languages such as Selenium/Java,
PlayWright/Python, and Cypress/JS. The generated test cases can be used to verify that a specific website or web page is
functioning correctly by searching for a keyword, such as "ChatGPT," and verifying that the website or page is listed in
the search results. The examples provided by ChatGPT are designed to be concise, easy to understand, and flexible,
allowing developers to quickly and easily create automated UI tests. This capability of ChatGPT can save valuable time
and resources for organizations by reducing the need for manual testing and allowing developers to focus on more complex
tasks.

**Prompts:**

_Generate a Selenium/Java, PlayWright/Python, Cypress/JS UI test example that searches for ChatGPT on Bing page and
verify that you have been found_

_You have verified the title. Please verify that ChatGPT website is listed in search results. Fix the examples please_

**Results:**

![](/images/blog/Screenshot%202023-02-07%20at%2015.01.50.png)

![](/images/blog/Screenshot%202023-02-07%20at%2015.02.09.png)

![](/images/blog/Screenshot%202023-02-07%20at%2015.02.16.png)

### CI configuration generation

ChatGPT can provide users with a wide range of possibilities for generating Continuous Integration (CI) configurations.
With its advanced language processing capabilities and deep understanding of software engineering practices, ChatGPT can
assist users in automating the process of building, testing, and deploying their applications. Whether it's creating
GitHub Actions workflows for CI/CD, writing scripts to run tests on a build server, or generating Dockerfiles for
containerizing applications, ChatGPT can assist with all aspects of CI generation. Additionally, ChatGPT can provide
recommendations and best practices for setting up CI/CD pipelines, ensuring that the generated configurations are
optimized for maximum efficiency and scalability. This can save developers valuable time and effort, enabling them to
focus on writing code and delivering new features to their users.

**Prompts:**

_Create GitHub Actions configuration that runs Gatling maven tests written in Java. The tests contain maven wrapper and
require Java 17. If possible split the the configuration into multiple steps. The first step should use artifact upload
action for target folder. The target folder should then be downloaded via appropriate action and tests should be
executed via command:_

_mvn gatling:test -Dgatling.simulationClass=com.awesome.testing.BasicSimulation_

_I have made a mistake in the prompt. Please split the configuration into two jobs, not steps. The second one should
depend on the first job success_

**Result:**

![](/images/blog/Screenshot%202023-02-07%20at%2015.14.58.png)

### Tool comparison, advices

ChatGPT can assist in choosing the right tool for a given task by providing tailored recommendations based on a
comprehensive understanding of the task requirements and user preferences. With its advanced language processing
capabilities, ChatGPT can analyze the requirements and match them with the strengths and capabilities of various tools,
taking into account factors such as ease of use, scalability, integration with other tools, reporting and analysis,
community and support, and cost. By providing an objective, data-driven evaluation of each tool, ChatGPT can help users
make an informed decision and choose the right tool for their specific needs. Additionally, ChatGPT can provide guidance
on how to get started with the selected tool, including information on installation, configuration, and best practices,
making the tool selection process a seamless and efficient experience for users.

**Prompt:**

_I need to create performance tests soon and I am currently doing tool research. The team is quite skilled at coding and
I would prefer to store tests as a code. After initial research I have identified 4 free tools: JMeter, k6, Locust and
Gatling. The team has very mixed programming experience. There is no preference for Python, JS or JVM language. What do
you think I should take into account while making a decision?_

**Result:**

![](/images/blog/Screenshot%202023-02-07%20at%2015.23.16.png)

### Influential writing

ChatGPT can be used to generate influential and error-free argumentative text by leveraging its advanced natural
language processing capabilities and vast database of information. With its ability to analyze and understand complex
data, ChatGPT can generate well-researched and logically structured arguments that effectively support a particular
viewpoint. Additionally, ChatGPT can identify and eliminate potential errors or inconsistencies in the argument,
ensuring that the text is accurate and convincing. Whether you need to write a persuasive essay, a compelling argument
for a business proposal, or an influential piece of content, ChatGPT can help you create error-free text that is backed
by strong evidence and logic. This makes it a valuable tool for anyone looking to communicate their ideas effectively
and make a lasting impact with their writing.

**Prompt:**

_I'd like to convince my team that Cypress is a better tool for out needs because it is widely used across company and
has very low entry level. The team would like to use Playwright in order to learn something new and experiment. I
understand that but I'm worried it may take too much time. How do I convince them that Cypress is a better choice for
them? Please consider their internal motivation for work. I don't want them become discouraged and unmotivated for
work._

_Please write a few strong paragraphs. Use the arguments you find the most powerful. Is it better to focus on one major
aspect or multitude minor ones? Please decide yourself_

**Result:**

![](/images/blog/Screenshot%202023-02-07%20at%2015.32.55.png)

Please note error in last sentence :)

### Creative tasks

ChatGPT can be a valuable tool for test engineers looking to generate creative and innovative testing scenarios. With
its advanced natural language processing capabilities, ChatGPT can assist in generating unique and imaginative test
cases, testing scenarios and edge cases that are based on user inputs and information from its vast database. This can
help test engineers uncover new testing perspectives and challenge the assumptions of a system, ultimately leading to a
more comprehensive and effective testing process. Whether you need to come up with new test cases for a complex
application, generate test ideas for a new feature, or identify edge cases that need to be addressed, ChatGPT can help
you generate creative testing content that goes beyond the traditional testing methods. Additionally, its ability to
understand language and context enables it to generate testing content that is relevant, comprehensive and tailored to
the specific needs of the application being tested. Whether you're a test engineer, QA analyst, or software tester,
ChatGPT can help you take your testing process to the next level and deliver better quality software.

**Prompt:**

_Write testing manifesto in the style of agile manifesto_

**Result:**

![](/images/blog/Screenshot%202023-02-07%20at%2015.38.11.png)
