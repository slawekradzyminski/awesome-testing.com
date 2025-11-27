---
title: "Agentic Testing - The New Testing Approach"
layout: post
permalink: /2025/11/agentic-testing
categories:
  - Testing
  - AI
tags:
  - Testing
  - AI
  - Agentic
  - Automation
header:
  og_image: /images/blog/
description: >
    
---

Over the last year or so, **agentic coding** has gone from novelty to serious contender for “default way of working” in many engineering teams. Tools like Claude Code, Cursor, Copilot and the various Codex descendants are no longer just autocomplete toys – they’re starting to write whole features, fix bugs, wire up tests and keep up with reviews. Plenty of companies are now asking a very practical question: how do we adopt this safely and at scale, without breaking everything or annoying our engineers?

What’s interesting is that these tools are already doing far more than writing code. Anthropic’s own internal report on how their [teams use Claude Code](https://www-cdn.anthropic.com/58284b19e702b49db9302d5b6f135ad8871e7658.pdf) shows it being used across data infrastructure, security, product, marketing and even legal – debugging Kubernetes clusters from screenshots, navigating huge codebases for new hires, and automating complex data workflows for non-technical colleagues. In other words, these "coding agents" are already behaving like **general-purpose engineering agents** that happen to live in an IDE, CLI or in the cloud.

If we accept that, it becomes natural to ask a follow-up question: if AI coding agents are effectively general-purpose agents, what happens if we point them at testing? Instead of only helping us write tests, could they test the application instead?

That’s what I want to explore in this post. I’ll look at agentic testing – letting agents test the application – from two angles:

- **White-Box Agentic Testing** – where the AI analyses the codebase, architecture and requirements directly, looking for bugs, gaps and risky areas before (or alongside) execution.

- **Black-Box Agentic Testing** – where the AI exercises a running application using the tools we give it: HTTP clients, terminals, MCP servers, browser automation, and so on.

The goal is not to sell a magic replacement for your existing regression suite, but to evaluate where these agents genuinely add value today, and how they might fit alongside the good old test pyramid rather than trying to blow it up.

## Classic Test Pyramid

![Classic Test Pyramid](/images/blog/geminipyramid.png)

Most of us still think about testing through the classic pyramid: lots of cheap checks at the bottom, fewer expensive ones at the top. At the base, you have static checks and compilation. This is where AI already helps set up linters, configure sensible rules, and wire them into your editor so they act as a fast feedback loop while you type, rather than as a noisy afterthought in CI.

A step up, at the unit level, AI makes it much easier to work in a TDD-ish way. You describe the behaviour you want, and the agent can sketch out test cases, propose edge conditions and turn them into executable tests. It’s surprisingly good at nudging you towards effective tests instead of a pile of trivial “assert true” noise.

Higher up, around the API layer, you can hand the agent your OpenAPI spec or docs and ask it to actually hit the service. It can sit in a terminal and drive `curl` commands, try different payloads, inspect responses and tell you where the behaviour diverges from the documentation.

At the top, on the UI side, the same idea applies but with a browser. Give the agent Playwright MCP or Chrome DevTools MCP as tools and it can open your app, click through flows, fill forms and report what it sees. In other words, the pyramid stays the same, but AI is already quietly embedded at every level, from linters through TDD to API and UI checks. Agentic testing is just the next step: instead of asking AI to help us write tests, we start letting it run them.

## Coding agents are already testing agents in disguise

Most marketing around Claude Code, Codex, Cursor, Copilot and the other top tools still frames them as coding assistants. They sit in your editor, suggest snippets, write boilerplate and occasionally generate half a feature. But if you actually use them day to day, you quickly notice something else: they’re weirdly good at general computer work, not just code.

![Coding agents are already testing agents in disguise](/images/blog/oroszadobe.png)

You can ask them to tweak your shell prompt, install and configure a new CLI tool, clean up a nasty docker-compose file, or help debug a broken local setup. They read terminal output, propose a fix, run a command, look at the error, adjust the plan and try again. That’s no longer autocomplete with extra steps – that’s an agent quietly running a reason–act loop over your machine.

Under the hood, they keep doing the same thing: reason about the current state, decide what to do next, call a tool, look at the result, update the plan. Think → act → observe → repeat. Because they’re good at that pattern – at planning, making decisions and following through – they end up being useful far beyond writing `for` loops and React components.

This is where the usual “let’s build a new agent for every use case” story starts to look a bit unnecessary. A lot of books and tutorials push you towards creating a fresh agent for each problem: a research agent, a shell agent, a Jira agent, a testing agent, each with its own loop and tooling. But if you look at what we already have in Claude Code, Cursor, Copilot and friends, the picture is different. These agents are already wired into your editor, your terminal, sometimes even your browser. They already know how to read code, run commands, call APIs and keep context across multiple steps.

So the real question is: do we actually need a separate “testing agent”? Or can we just reuse the coding agents we have and point them at our testing problems? In practice, you can say to the agent: here is the codebase, here are the APIs and the docs, here are the tools you’re allowed to use – curl, Playwright MCP, Chrome DevTools MCP, test runners – and here is what I want you to check. From that point on, the difference between a coding agent and a testing agent is mostly in how we prompt it and what outcome we care about.

The heavy lifting is already there: reasoning, planning, calling tools, handling errors. That’s the core idea behind agentic testing in this post. Instead of obsessing over building bespoke “QA agents”, we can start by squeezing more value out of the powerful agents already sitting in our IDEs and terminals, and see how far they can take us into testing.

## So what is agentic testing, exactly?

This naturally brings us to the question: what do I actually mean by agentic testing?

In this post I’ll use a very simple definition: agentic testing is testing done by AI agents. Not scripts, not humans clicking around, but the same kind of agents we just talked about – the ones you can install in your IDE or editor with almost one click today.

Once you look at it this way, the interesting bit is how to slice the space. A useful, high-level split is into two flavours.

The first is a white-box approach. Here we let the agent peek inside the code and reason about it directly. You can ask it to walk through error paths, think about edge cases, spot risky patterns, suggest missing tests or even point out potential bugs just from reading the implementation and the surrounding context. It’s essentially giving the agent read access to the internals and saying: “tell me what could go wrong here”.

The second is a black-box approach. In this mode we treat the system as a running application and let the agent exercise it using the tools we provide: terminal commands like curl, HTTP clients, browser automation via MCP servers, Playwright, Chrome DevTools MCP and so on. The agent doesn’t need to see the code – it interacts with the system like an external tester would, sends requests, clicks through flows, observes responses and reports what it finds.

Both are agentic testing. One thinks over the code, the other plays with the live system. In the rest of the post I’ll keep coming back to this distinction, because it shapes both what’s possible today and where the sharp edges are.

## White-box agentic testing

White-box agentic testing is the part where we let the agent actually look inside the code. This is where today’s coding agents are already very strong, and where you can get value almost immediately without building any custom framework. You give the agent your repository, your build system and a rough goal, and let it reason about the codebase directly.

### 1. Let the agent wire in analysis and coverage

The first, almost boring, use case is simply getting all the static analysis and coverage machinery in place. Coding agents are excellent at this.

You can ask the agent to introduce and configure whatever makes sense for your stack: linters, type checkers, PMD, SpotBugs, ESLint, style checkers, you name it. You can then ask it to plug in a coverage tool such as JaCoCo, hook it into your build, make sure reports are generated, and, if you want to be fancy, surface those numbers in CI or in a dashboard.

The important bit is that this work has a very clear goal and a very clear feedback loop. If coverage is at 42%, the agent knows it hasn’t finished yet. If the linter fails, the agent can see the error and fix the config. This kind of “plumbing” used to be a half-day of documentation reading and trial and error; now you can offload most of it to an AI that doesn’t get bored.

### 2. Let it critique and evolve your unit tests

Once the tools are in place, you can ask the agent to turn its attention to the tests themselves.

Here the agent can read your unit tests and production code side by side and give you an opinion. It can highlight branches that are never exercised, boundary conditions that are missing, and areas where you are obsessively testing trivial getters while ignoring real logic. You can push it further and ask for suggestions on how to improve specific tests, or how to restructure code to make certain behaviours easier to test.

In the past we tried to answer the question “are my tests any good?” with mutation testing: randomly tweak the code, see which mutants survive, treat surviving mutants as a sign of weak tests. Now you can ask the agent to do a more targeted version of that in its head. It can propose realistic mutations that are likely to reflect real bugs, reason about whether your current tests would catch them, and then either strengthen existing tests or generate new ones. Generating unit tests, improving them and assessing their quality becomes a single conversation instead of three different tools.

### 3. Let it simulate test execution

The third use case is the one that feels odd at first: asking the agent to simulate running tests without actually executing anything.

You can take real test cases or test ideas and ask the agent to mentally step through them against the code. Given this setup and these inputs, which paths are taken, what values do variables have at each step, where are the surprising branches, what could go wrong if some precondition is violated? For a human, doing this across a non-trivial codebase is exhausting. For an LLM, it’s just more tokens.

This means you can ask questions like “if I change this function, which tests would realistically start failing?”, “what hidden coupling exists between these two parts of the code?”, or “what edge cases are missing from this test class?”. The agent can explore multiple paths, track different outcomes and report back scenarios you might not have considered.

Adding static analysis and coverage, generating and improving unit tests – those are essentially accelerators for techniques we already know. Letting an AI simulate execution and reason about how tests would behave before you run them is genuinely new. And the nice part is that you don’t need a special research model to try it; the coding agents already sitting in your IDE are usually enough to start experimenting.

### Example 1 - Java Spring Boot application



## Black-box agentic testing: what makes it possible

Before we talk about how an agent can test a running system, it’s worth looking at what actually makes that possible in the first place. In practice, most coding agents today have two main ways of touching your application: the terminal, and MCP servers.

```mermaid
flowchart TB
    A[AI coding agent]:::agent

    subgraph L[ ]
        B[[Terminal access]]:::terminal
        Bnote[Raw shell<br/>• start app<br/>• run curl / CLI<br/>• run tests<br/>• tail logs / inspect files<br/>• touch DB]:::note
        B --- Bnote
    end

    subgraph R[ ]
        C[[MCP servers]]:::mcp
        C1[HTTP client tool]:::tool
        C2[Playwright / DevTools MCP<br/>browser tool]:::tool
        C3[Test runner tool]:::tool
        C4[Log viewer tool]:::tool
        C --> C1 & C2 & C3 & C4
    end

    D[System under test<br/>]:::sut

    A --> B
    A --> C
    B --> D
    C1 --> D
    C2 --> D
    C3 --> D

    classDef agent fill:#fef9c3,stroke:#a16207,stroke-width:1px;
    classDef terminal fill:#fee2e2,stroke:#b91c1c,stroke-width:1px;
    classDef mcp fill:#dbeafe,stroke:#1d4ed8,stroke-width:1px;
    classDef sut fill:#e5e7eb,stroke:#4b5563,stroke-width:1px;
    classDef tool fill:#eff6ff,stroke:#1d4ed8,stroke-width:0.5px;
    classDef note fill:#fff7ed,stroke:#ea580c,stroke-width:0.5px;
```

The terminal is the blunt instrument. If your agent can run shell commands, it can in theory do almost anything you can: start the app, run curl against your APIs, execute your test suites, tail logs, inspect files, hit databases, the lot. That’s exactly why many companies are understandably nervous about enabling it. An agent that can execute arbitrary commands is powerful, but it’s also a risk if you don’t trust the model, the prompts or the surrounding controls. When you do turn terminal access on in a controlled environment, though, black-box agentic testing suddenly becomes very straightforward. The agent can build or start the system under test, exercise it via HTTP or CLI, and observe real behaviour end to end.

The second path is through MCP servers. MCP was designed precisely to give models a structured, explicit way to call tools. Instead of saying “here’s a shell, good luck”, you say “here are a few well-defined tools you’re allowed to use, described by a protocol”. Those tools might include a HTTP client, a Playwright-driven browser, a test runner, a log viewer, or anything else you expose as an MCP server. The coding agent doesn’t need to know how they’re implemented; it just calls named operations with parameters and gets structured results back.

This means we can extend a coding agent with very specific testing powers without giving it raw access to a whole machine. Through MCP we can bolt on a “call this API endpoint” tool, or a “click this selector in the browser” tool, or a “run this test suite and return the summary” tool. From the agent’s perspective, both the terminal and MCP look like ways to act in the world. The difference is that MCP lets us shape and constrain those actions very precisely, which is exactly what we want when we move into black-box testing of real systems.

## AI posts archive

  - [The rise of AI-Driven Development](https://www.awesome-testing.com/2024/09/the-rise-of-ai-driven-development)
  - [From Live Suggestions to Agents: Exploring AI-Powered IDEs](https://www.awesome-testing.com/2024/12/from-live-suggestions-to-agents-exploring-ai-powered-ides)
  - [AI Vibe Coding Notes from the Basement](https://www.awesome-testing.com/2025/04/ai-vibe-coding-notes-from-the-basement)
  - [How I use AI](https://www.awesome-testing.com/2025/06/how-i-use-ai)
  - [How does Playwright MCP work?](https://www.awesome-testing.com/2025/07/playwright-mcp)
  - [AI Tooling for Developers Landscape](https://www.awesome-testing.com/2025/07/ai-tooling-for-developers-landscape)
  - [Playwright Agentic Coding Tips](https://www.awesome-testing.com/2025/09/playwright-agentic-coding-tips)
  - [Mermaid Diagrams - When AI Meets Documentation](https://www.awesome-testing.com/2025/09/mermaid-diagrams)
  - [AI + Chrome DevTools MCP: Trace, Analyse, Fix Performance](https://www.awesome-testing.com/2025/09/chrome-dev-tools-mcp)
  - [Test Driven AI Development (TDAID)](https://www.awesome-testing.com/2025/10/test-driven-ai-development-tdaid)
  - [Testing LLM-based Systems](https://www.awesome-testing.com/2025/11/testing-llm-based-systems)
  - [Building RAG with Gemini File Search](https://www.awesome-testing.com/2025/11/gemini-file-search-managed-rag)
  - [Playwright MCP Security](https://www.awesome-testing.com/2025/11/playwright-mcp-security)
