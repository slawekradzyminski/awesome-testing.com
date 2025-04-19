---
title: "Deep Technical Understanding: Beyond Business Knowledge"
date: 2025-04-19
excerpt: "Why senior engineers need both business and technical depth to excel."
last_modified_at: 2025-04-19
tags: [career, technical-skills, architecture]
---

{% raw %}
In our testing bubble, much is said about a deep business understanding of the tested application/functionality. We have
coined many terms, more or less useful, which we can ask about in an interview (Three Amigos in Agile, BDD). Here, I'm
deliberately omitting the effectiveness of these practices. Every Senior+ should organize this in a way that works for
them. It's unquestionable that building such understanding has been, is, and will be important. Incidentally, this is
still an area where people have a huge advantage over generative AI.

For some reason, another aspect that I consider equally important hasn't yet penetrated our bubble - a deep TECHNICAL
understanding of the tested application. What communicates with what? Where are the boundaries of our system? Where do
we integrate with other systems maintained by teams in our company? Where do we have integration with systems maintained
by other companies (3rd-party dependency)? How to test integration within our system, between systems in the company,
and between our system and external service providers? What protocol is used for communication? What are WebSockets? How
do frontend and backend know we are logged in? How to circumvent this? Can we move tests to a lower level?

Building a deep technical understanding is very important in the era of microservices and ubiquitous asynchronous
communication. How to test an event-based architecture? Why do architects decide to introduce queues/topics instead of
relying on a synchronous HTTP interface? How does this affect our functional and non-functional tests?

Building a deep technical understanding is an excellent way to maximize the benefits we can derive from our work. By
organizing this in our heads, we not only become better testers of the current system but also build transferable
knowledge that becomes our personal capital. We build an advantage over the competition in the job market.

Books that are great for connecting the dots:
- [Understanding Distributed Systems](https://amzn.to/4hdUjKQ)
- [Fundamentals of Software Architecture](https://amzn.to/4h8J7yX)
- [Software Architecture - the Hard Parts](https://amzn.to/48aefKt)
- [Thinking in Systems](https://amzn.to/3Yv4O4Y)
- [System Design Interview - Volume 1](https://amzn.to/48fMfoP)
- [System Design Interview - Volume 2](https://amzn.to/48cAtLI)
{% endraw %}
