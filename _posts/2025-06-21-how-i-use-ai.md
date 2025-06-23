---
title: "How I use AI"
layout: post
permalink: /2025/06/how-i-use-ai
categories:
  - AI
tags:
  - AI
header:
  og_image: /images/blog/aislawek.png
description: >
  How I use AI to code, learn, write and generate content.
---

![AI Slawek](/images/blog/aislawek.png){:width="35%" loading="lazy"}

## 1. Introduction

I've come across a few "How I use AI" posts recently, which inspired me to write my own. I’m curious to see how my approach evolves by 2026. There’s still plenty of discussion about how AI is shaping software engineering, testing, and the broader IT industry—but what’s often missing are concrete prompts and real-world use cases. That’s what I aim to share here.

The topic of artificial intelligence continues to stir up a lot of debate. Two opposing voices tend to dominate the conversation:

- One group insists AI is overhyped and practically useless—it can’t deliver anything truly valuable.
- The other believes AI is on the verge of taking over everything, including our jobs.

As with most things, the truth likely lies somewhere in between. If you’ve read my previous posts—especially  [The rise of AI Driven Development](https://www.awesome-testing.com/2024/09/the-rise-of-ai-driven-development)—you’ll know I’ve always been focused on identifying where AI can genuinely help. And the reality is, I’m discovering more and more practical use cases. The pace of progress is fast, and at this point, AI is part of my daily workflow.

## 2. How I use AI

Now that AI is part of my daily workflow, I’ve developed a set of habits and preferences that help me get the most out of these tools. From voice input to paid subscriptions and model selection, here’s how I integrate AI into different aspects of my work.

### Voice over Text

One of the first things I do when prompting AI—whether it’s ChatGPT, Cursor, Gemini, or another tool—is use voice input. Dictating my prompts helps me provide richer context and more detail naturally, often resulting in better responses. It’s also simply faster than typing. Of course, I still switch to text when needed—like when copy-pasting code from a project—but voice remains my go-to for most interactions.

Tools like [Wispr Flow](https://wisprflow.ai/) work seamlessly with Cursor and even with ChatGPT. If you haven’t tried voice prompting yet, give it a shot—you might be surprised by how much it improves your results.

### Paid subscriptions

I think a great litmus test for any tool is simple: *Would you pay for it out of your own pocket?*

I currently subscribe to ChatGPT Plus at $20/month, which I use for a wide range of general tasks—as well as anything my wife needs help with. I also pay $20/month for Cursor, which has become my primary coding assistant outside of work at Ocado Technology.

Most of that work is preparation for upcoming trainings. But I also use Cursor to write this blog, maintain my website [awesome-testing.com](https://www.awesome-testing.com), and work on my local [awesome-localstack](https://github.com/slawekradzyminski/awesome-localstack)—which I try to keep modern and efficient. It’s also where I automate everything I need for projects beyond my day job.

I may soon start paying for [Wispr Flow](https://wisprflow.ai/), which has been on my radar lately. Beyond that, I regularly use Gemini—primarily because it supports a 1 million token context window, which makes it a great fit for working with full codebases. I’m currently on the free tier, and so far it’s been more than sufficient for my needs.

### Understanding

From the beginning, I’ve always aimed to truly understand the tools I use—how they work under the hood, how components communicate, and where the "magic" really happens. That mindset hasn’t changed. Recently, I’ve been diving deeper into topics like LLM function calling and [MCP servers](https://github.com/slawekradzyminski/mcp).

These days, prototyping something from scratch is remarkably easy. Tools like Cursor make building proof-of-concepts insanely fast—it’s incredible how quickly a working example can come together. Of course, building a production-grade system is a different story. But for me, creating PoCs isn’t just about speed or output; it’s a way to validate my understanding. I don’t just want to read books or blog posts—I want to build things to confirm that I truly grasp the concepts.

To stay sharp and informed, I regularly read the following blogs:

- [Simon Willison](https://simonwillison.net/)
- [Shrivu Shankar](https://blog.sshh.io/)
- [Addy Osmani](https://addyosmani.com/blog/)
- [Pragmatic Engineer](https://www.pragmaticengineer.com/)

I also maintain an O’Reilly subscription, which gives me access to early-access titles like [AI Engineering](https://www.amazon.com/AI-Engineering-Building-Applications-Foundation/dp/1098166302) and [Beyond Vibe Coding](https://www.oreilly.com/library/view/beyond-vibe-coding/9798341634749/), which I’ve found quite valuable.

### Models

The days of using a single AI model like GPT-4 are behind us. Today, we have a variety of models, each optimized for different tasks. Some are built for speed (like GPT-4o), others for deep reasoning (like OpenAI's o3), and some excel at coding (like Anthropic's Claude models).

#### GPT-4o

I use GPT-4o for fast, everyday tasks like:

- "Is this code snippet optimized?"
- "Can this class be simplified?"
- "Can common logic be extracted into a utility class?"
- "How to find files above 1GB via Mac terminal?"
- "Which local LLM can run on my Mac?"

These types of ad hoc queries—code refactoring, syntax cleanup, quick translations, or refining the language in something I’m writing (like this blog post)—are perfect for GPT-4o. It’s quick, responsive, and good enough for most practical tasks.

Even outside of software, it proves useful. For instance, my wife, a urogynecological physiotherapist, often uses GPT-4o to refine her ideas, whether she’s writing Instagram Reels scripts or preparing educational content.

We don't really put much effort into the prompt engineering, we just ask the model to do the job in the simplest way possible. Usually that's enough.

#### o3 and Gemini 2.5 Pro

When it comes to more complex, high-context tasks—especially planning—I turn to o3 or Gemini 2.5 Pro.

For example, before jumping into implementation, I often design a high-level plan. I load up the codebase, ask the model to analyze it, and request a Markdown-formatted plan. Once that’s done, I take it to Cursor and begin implementation.

I tend to prefer o3, partly because I’m comfortable with ChatGPT’s interface and really like the UX that OpenAI provides. But Gemini 2.5 Pro has one major advantage: its 1 million-token context window. When I’m working with large codebases—think 200,000 tokens or more—ChatGPT simply can’t handle it, and I have to switch to Gemini.

This kind of context-heavy analysis is one of my main use cases. Whenever a new task comes in, I rely on o3 or Gemini to generate a thoughtful implementation plan based on the full context of the project.

Examples (implemented thinking support in my awesome-localstack project):

- Backend (Java): [https://chatgpt.com/share/68570bde-0e08-800a-95cd-5e43a0db55da](https://chatgpt.com/share/68570bde-0e08-800a-95cd-5e43a0db55da)
- Frontend (React): [https://chatgpt.com/share/68570c1d-0f8c-800a-87de-dbb245c8aa33](https://chatgpt.com/share/68570c1d-0f8c-800a-87de-dbb245c8aa33)

#### Claude 4.0 Sonnet

In Cursor, I primarily use Claude 4.0 Sonnet, with fallback to older versions like 3.5 and 3.7 Sonnet for executing plans. I previously used Gemini 2.5 Pro for this, but in practice, I’ve found Claude to be noticeably better—especially in reasoning and structured output.

While Anthropic employees reportedly use the higher-tier Opus models, I haven’t found a compelling enough reason to justify the cost for my use cases. Sonnet strikes the right balance of performance and value for what I need.

## 3. Use cases

Of course, tools and models are only part of the picture. The real value comes from how I apply them to solve problems, speed up development, and explore ideas. Below are some of the recurring use cases where AI consistently adds value to my workflow.

### Coding



### Learning


### Writing


### Image generation






