---
title: "Learning AI"
layout: post
permalink: /2025/12/learning-ai
categories:
  - AI
tags:
  - AI
header:
  og_image: /images/blog/ailearning.png
description: >
  Exploring the convergence of learning AI through three distinct paths: as a student learning, as a user in daily tasks, and as a builder creating systems. Discover how these paths merge into a unified journey of AI mastery.
---

![Learning AI - Convergence Point](/images/blog/ailearning.png)

Recent LLM releases such as Opus 4.5 and GPT-5.1 Codex (used via Codex CLI) have once again pushed the boundaries of what we thought possible. These models generate remarkably high-quality code and demonstrate capabilities that would have seemed out of reach not long ago. Combined with modern agentic workflows built on function calling, they can now support — or even automate — almost any engineering task we can imagine.

Unsurprisingly, companies and organisations have taken notice. There is growing pressure on engineers of every kind to keep up: to experiment, explore new use cases, understand the theory behind these systems, and adopt the practices that allow us to use them effectively. Many employers now expect their teams to stay close to the cutting edge, track breakthroughs, and pay active attention to emerging tools and techniques. Multiple studies proved already that productivity boost isn't guaranteed, it requires a lot of effort and time to learn and adopt to new tools and techniques.

When I talk to people about AI, I often hear the same concern: the field feels enormous and the amount of information overwhelming. It’s hard to know where to begin — and even harder to know whether you’re learning the right things. That’s why this post is written for everyone: those just starting out, and those who have already begun but may have followed one path too deeply at the expense of others.

A natural question follows: what does it actually mean to “learn AI”? Should you focus on the underlying theory? Should you start by building tools and APIs? Or should you concentrate on using AI effectively in your daily work? Over the past three years — ever since I began exploring the field shortly after ChatGPT’s release — I’ve come to see AI learning as three complementary paths that form a single journey.

In this post, I’ll walk through each of these paths, explain how they fit together, and share how I’ve approached developing my own AI skills. My goal is simple: by the end of this piece, you should know exactly where to focus next and how to continue your AI learning journey with clarity and intent.

## The Three Paths of AI Learning

Before diving deeper, it’s worth acknowledging something upfront: learning AI is not a single, linear route. It naturally branches into three distinct paths, each with its own mindset, skill set, and outcomes. The opening image captures this well — three roads that ultimately converge at the same point: becoming genuinely fluent in AI.

### The Student Path — understanding how AI works

This path is about learning the fundamentals: how modern models process information, why they behave the way they do, and what the underlying mechanics look like. It covers the essential building blocks — tokens, embeddings, attention, transformers — as well as the operational pieces that sit around LLMs today: function calling, tool execution, agent loops, MCP servers, and RAG pipelines.

A good starting point is to start with simplified diagrams of how LLM works. For example [The Average Gal](https://medium.com/@theaveragegal/transformer-architecture-simplified-3fb501d461c8) created this simplified diagram of the Transformer architecture. Now, having that model in mind, you can dig deeper. What are embeddings? You can't understand that without the concept of tokens.

![Transformer architecture simplified](/images/blog/transformersimplified.webp)

Knowing how LLM works is often not enough these days due to Agentic workflows which are becoming more and more popular. Many authors, including [Temportal.io](https://temporal.io/blog/a-mental-model-for-agentic-ai-applications) claim that agents just execute tools in a loop. What are LLM tools? How do they work? What problem MCP servers solve? 

![Agentic loop](/images/blog/agenticloop.png)

And the truth is simple: the theory matters. Many people skip it, often because the surface-level interfaces (chat UIs, coding assistants) make AI feel like magic. But without the foundations, everything downstream becomes harder — prompting feels unpredictable, agent behaviour looks mysterious, and debugging AI workflows becomes guesswork.

The Student Path doesn’t require a PhD. What it does require is curiosity and a willingness to peek under the hood. Even a high-level understanding dramatically sharpens your ability to reason about the systems you use.

### The User Path — mastering AI in daily work

The second path is the one most closely tied to practical impact. This is the User, the person who leverages LLMs, research tools, coding copilots, and agents to get real work done. Surprisingly, this remains a niche skill — even though organisations increasingly expect their teams to become fluent AI users.

As I’ve written elsewhere, modern AI tools already allow users to express highly structured, multi-step requests and receive meaningful, actionable results. Yet despite this capability, the User Path is still undervalued. Many companies implicitly assume that employees will “figure it out”, even though effective AI use is a skill in its own right — one that improves with deliberate practice, domain knowledge, and experience.

This path deserves far more attention than it gets. It is, in my view, the route that delivers the fastest and most tangible return. Teams do not need everyone to build infrastructure — they need people who know how to use what already exists to produce outcomes.

### The Builder Path — creating tools, systems, and infrastructure

The third path is the Builder: engineers and tinkerers who create applications, agent workflows, integrations, or AI-powered services. It’s a popular route, and perhaps the most glamorised. Books often encourage people to “start building”, managers push teams towards rapid prototypes, and the community itself frequently celebrates shipping new tools.

The result is a growing wave of products — many valuable, many educational, and many… unnecessary. There’s even a running meme, especially in the MCP ecosystem, that there are more people building servers than using them. That observation isn’t entirely unfair.

![MCP meme](/images/blog/mcpbuilders.jpeg){:width="50%"}

Building is important, but it’s easy to over-index on this path. Without a strong grounding in user needs, Builders risk producing wrappers, dashboards, or agents that don’t solve real problems. The best Builders usually spend a long time as Users first; they understand the friction, the gaps, and the opportunities worth solving.