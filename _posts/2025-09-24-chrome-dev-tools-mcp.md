---
title: "Chrome DevTools MCP for Performance: tracing, insights, and fixes with an AI agent"
layout: post
permalink: /2025/09/chrome-dev-tools-mcp
categories:
  - AI
tags:
  - AI
  - MCP
header:
  og_image: /images/blog/devtoolsmcp.png
description: >
    How DevTools MCP enables AI agents to record real performance traces (LCP/CLS/TBT), analyse them, and apply fixes—bringing Lighthouse-style audits into an iterative debugging session.
---

![Chrome DevTools MCP](/images/blog/devtoolsmcp.png){:width="60%"}

Google has released a potentially significant tool for AI-driven web development and testing: an official [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp) integration. In plain terms, Chrome DevTools can now hook into AI coding assistants via the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/). Let's look at what it is and how it works.

Chrome DevTools MCP is a new MCP server that exposes Chrome's debugging and performance surface to AI assistants. Beyond the usual "click, navigate, inspect" flows (which are very similar to [Playwright MCP](https://www.awesome-testing.com/2025/07/playwright-mcp)), the standout feature is performance work: an agent can start a DevTools trace, capture Core Web Vitals signals, and return concrete improvement suggestions—directly from a real Chrome session.

This post is a personal tour of what Chrome's MCP integration is, how it fits into the fast-evolving AI tooling space (as surveyed in my [AI Tooling for Developers Landscape](https://www.awesome-testing.com/2025/07/ai-tooling-for-developers-landscape) article), and—most importantly—the new workflows and use cases it unlocks for developers and testers.

## What is MCP and Why Should We Care?

Before we get into Chrome DevTools MCP specifically, it helps to know what MCP (Model Context Protocol) is in general. Think of MCP as a sort of universal adapter for AI tools—Gergely Orosz calls it the ["USB-C port of AI applications"](https://newsletter.pragmaticengineer.com/p/mcp). It's an open standard (originally introduced by Anthropic in late 2024) that lets large language models (LLMs) connect to external tools and data sources in a structured way. For a deeper dive into MCP theory and implementation, check out my article on [How Playwright MCP works](https://www.awesome-testing.com/2025/07/playwright-mcp). In other words, MCP defines how an AI can call out to a tool—whether it's a database, a browser, an OS command, you name it—and get results back.

```mermaid
flowchart TD
  A[AI Assistant] -->|Tool calls via MCP| B[MCP]
  B --> C[Chrome DevTools MCP]
  B --> E[Supabase MCP]
  B --> F[BigQuery MCP]
  B --> G[Other MCP Servers]

  %% Styling
  classDef hub fill:#f0f9ff,stroke:#0284c7,stroke-width:2px,rx:8,ry:8;
  classDef node fill:#ffffff,stroke:#94a3b8,rx:6,ry:6;
  classDef ai fill:#ecfdf5,stroke:#059669,stroke-width:2px,rx:8,ry:8;

  class A ai;
  class B hub;
  class C,D,E,F,G node;
```

MCP acts as a universal adapter between AI assistants and tool-specific servers.

```mermaid
flowchart
  subgraph After: Live connection
    A2[AI Assistant] --> B2[Chrome DevTools MCP]
    B2 --> C2[Chrome]
  end
  subgraph Before: Blindfolded
    X[AI Assistant] -. no live context .-> Y[(Browser)]
  end
```

This visual contrast shows how MCP removes the "blindfold" from AI assistants, giving them direct access to live browser state.

Under the hood, this builds on the idea of LLM function calling. Modern AI models like GPT-4, Claude, etc., can execute `tools` if those tools are defined in their environment. Traditionally, AI app developers had to hard-code a set of available tools (APIs for the AI) into their assistant. If you wanted your AI to do something new—say control a browser—you'd have to update the app with new functions. MCP flips that script. It allows AI assistants to dynamically discover and use tools from external MCP servers without the client app needing to know all the details upfront. The MCP server advertises what it can do (through a standardised handshake), and the AI can invoke those capabilities as needed. It's like plugging a new peripheral into your computer and having it instantly recognised—here the "peripheral" could be Chrome DevTools, and the "computer" is your AI agent.

Now, Chrome DevTools MCP is essentially [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/) exposed as an MCP server. The Chrome DevTools team built a bridge that connects an AI agent to Chrome's debugging interface (the same low-level protocol that tools like Puppeteer or VS Code debugging use). Once connected, the AI can drive the browser and retrieve data via [DevTools](https://developer.chrome.com/docs/devtools)—all through standardised MCP calls. [Google's announcement](https://developer.chrome.com/blog/chrome-devtools-mcp) frames it nicely:

>The Chrome DevTools MCP server brings the power of Chrome DevTools to AI coding assistants.

In practice, this means an AI can launch Chrome, open pages, click around, inspect elements, read console logs, record performance metrics—basically everything you and I do in DevTools, but automated.

## Why Performance is the Unique Angle Here

While actions like navigation, DOM inspection, console checks and basic UI testing map closely to Playwright MCP (see my earlier deep dives), DevTools MCP goes further on performance: it exposes trace recording and analysis primitives (`performance_start_trace`, `performance_stop_trace`, `performance_analyze_insight`) so an agent can collect evidence and interpret it in one loop.

Further reading on Playwright MCP and agentic testing flows: my articles on [Playwright MCP](https://www.awesome-testing.com/2025/07/playwright-mcp) and [Agentic Coding Tips](https://www.awesome-testing.com/2025/09/playwright-agentic-coding-tips). These workflows carry over; the key difference here is the built-in performance tooling.

## Lighthouse in Brief

Lighthouse is Google's automated auditing tool that runs lab checks for Performance, Accessibility, SEO and more. It measures Core Web Vitals like LCP (loading), CLS (visual stability) and uses TBT as a lab proxy for responsiveness. Traditionally we ran Lighthouse in DevTools, CI, or via PageSpeed Insights to get a score and a list of opportunities.

**What changes with DevTools MCP?**

Instead of a one-off audit, you can orchestrate: record a DevTools trace, get insights, apply a code change, and re-trace—all inside the same agent session. This tight feedback loop moves performance work from "report then manually fix" to "investigate → change → re-measure" with the browser and agent in lock-step.

## Chrome DevTools MCP Tool Overview

Before diving into practical examples, let's explore the actual capabilities available in Chrome DevTools MCP. The integration provides 26 specific tools across 6 categories, giving AI assistants precise control over browser automation and debugging.

Here's the complete visual breakdown of available tools:

```mermaid
flowchart LR
  A[Chrome DevTools MCP]

  subgraph PF[Performance]
    PF1[performance_analyze_insight]
    PF2[performance_start_trace]
    PF3[performance_stop_trace]
  end

  subgraph IA[Input automation]
    IA1[click]
    IA2[drag]
    IA3[fill]
    IA4[fill_form]
    IA5[handle_dialog]
    IA6[hover]
    IA7[upload_file]
  end

  subgraph NA[Navigation automation]
    NA1[close_page]
    NA2[list_pages]
    NA3[navigate_page]
    NA4[navigate_page_history]
    NA5[new_page]
    NA6[select_page]
    NA7[wait_for]
  end

  subgraph EM[Emulation]
    EM1[emulate_cpu]
    EM2[emulate_network]
    EM3[resize_page]
  end

  subgraph NW[Network]
    NW1[get_network_request]
    NW2[list_network_requests]
  end

  subgraph DB[Debugging]
    DB1[evaluate_script]
    DB2[list_console_messages]
    DB3[take_screenshot]
    DB4[take_snapshot]
  end

  A --> PF
  A --> IA
  A --> NA
  A --> EM
  A --> NW
  A --> DB

  %% Optional subtle styling
  classDef hub fill:#f7f7ff,stroke:#6366f1,stroke-width:2px,rx:8,ry:8;
  classDef group fill:#f8fafc,stroke:#cbd5e1,rx:10,ry:10;
  classDef perf fill:#fef3c7,stroke:#f59e0b,stroke-width:2px,rx:10,ry:10;
  classDef item fill:#ffffff,stroke:#94a3b8,rx:6,ry:6;

  class A hub;
  class PF perf;
  class IA,NA,EM,NW,DB group;
  class IA1,IA2,IA3,IA4,IA5,IA6,IA7,NA1,NA2,NA3,NA4,NA5,NA6,NA7,EM1,EM2,EM3,PF1,PF2,PF3,NW1,NW2,DB1,DB2,DB3,DB4 item;
```

For the complete technical reference and detailed tool specifications, see the official Chrome DevTools MCP [tool reference](https://github.com/ChromeDevTools/chrome-devtools-mcp/blob/main/docs/tool-reference.md).

The real power comes from how these tools work together. An AI agent can chain multiple operations: navigate to a page, wait for elements to load, inspect the DOM, check for errors, analyse performance, and even simulate user interactions—all while providing contextual insights based on the actual browser state.

Configuration is straightforward. It can be enabled by adding the following to your application:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"]
    }
  }
}
```

Note that we are always using the latest version of the Chrome DevTools MCP server hence the number of tools may change over time. That's the actual benefit of MCP - we can use the latest server implementation without any updates on client side.

## Performance-First Debugging with DevTools MCP

Use these prompt patterns (they mirror the Chrome team's guidance) to shift from generic checks to trace-driven performance work:

**Automate a page-load trace**

```text
Start a performance trace for /path, reload, and analyse LCP, CLS and TBT. List the top main-thread long tasks and render-blocking resources.
```

**Compare device/network profiles**

```text
Repeat the trace with mid-tier mobile CPU emulation and Slow 4G. Summarise deltas in LCP and TBT, and point to the culprit scripts.
```

**Actionable follow-ups**

```text
Suggest code-level changes to cut TBT by 30% (splits, defer, scheduler.postTask). Then re-run the trace and show before/after numbers.
```

These are powered by DevTools MCP tools like `performance_start_trace`, `performance_stop_trace`, and `performance_analyze_insight`, plus standard navigation/DOM utilities when you need context.

**What I run day-to-day:**

- **Baseline trace**: start a trace, reload, report LCP/CLS/TBT and the critical path.
- **Bottlenecks**: list long tasks, blocking CSS/JS, and image decode costs; attach a screenshot of the LCP element.
- **Hypotheses & patches**: propose specific code-splits, defer/async, preload/inline critical CSS, and font loading fixes; commit a small patch.
- **Re-measure**: repeat the trace on mid-tier mobile + Slow 4G to ensure the win holds for users.

## Primer: What to Look at in Traces

**LCP**: keep ≤2.5s; identify render-blocking CSS, image decode/size, and main-thread tasks delaying paint.

**CLS**: should be ≤0.1; watch for late-loading fonts/ads/images causing shifts.

**TBT** (lab proxy for responsiveness): reduce long tasks >50 ms; split bundles, lazy-initialise work, offload to workers.

**Network waterfall**: critical chain length, blocking CSS/JS, preloads. DevTools Performance docs have a good reference for reading these tracks.

## AI-Enhanced Functional Testing Workflows

Chrome DevTools MCP also enables UI testing workflows that are functionally similar to [Playwright MCP](https://www.awesome-testing.com/2025/07/playwright-mcp). The agent can generate tests, execute them, and maintain them adaptively. The key differences are that DevTools MCP uses [Puppeteer](https://pptr.dev/) under the hood instead of Playwright, and adds the performance tooling capabilities we've discussed.

For detailed examples of functional testing, exploratory testing, and AI-driven test maintenance workflows, see my [Playwright MCP](https://www.awesome-testing.com/2025/07/playwright-mcp) and [Agentic Coding Tips](https://www.awesome-testing.com/2025/09/playwright-agentic-coding-tips) articles. The patterns transfer directly—the real differentiator here is the integrated performance analysis.

## Example: Real Performance Analysis Session

Here's a detailed write-up of an actual session analyzing `/register` on localhost:8081 using DevTools MCP. This demonstrates the performance-first approach in action:

### The Prompt
```text
Using Dev Tools MCP analyse the performance of http://localhost:8081/register page. 
Are there any suggestions how to improve it?
```

### Performance Metrics Captured
- **LCP (Largest Contentful Paint): 271ms** - Under the 2.5s threshold ✅
- **CLS (Cumulative Layout Shift): 0.00** - Perfect, no layout shifts ✅  
- **TTFB (Time to First Byte): 8ms** - Very fast server response ✅

### Key Insight: Render Delay Bottleneck
The agent identified that **97.2% of LCP time (264ms)** was spent on element render delay, while only **2.8% (8ms)** was server response time. This immediately pointed to client-side rendering as the main bottleneck—not the backend.

### Detailed Findings
**Render-blocking resources:**
- CSS file `index-C3W9awP0.css` taking 77ms total duration
- 45ms spent on main thread processing
- Critical path latency: 93ms (HTML → JS + CSS)

**Console issues:**
- Missing `autocomplete` attribute on password field

### AI-Generated Recommendations
The agent provided specific, actionable fixes:

**High Impact:**
```html
<!-- Preload critical CSS -->
<link rel="preload" href="/assets/index-C3W9awP0.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="/assets/index-C3W9awP0.css"></noscript>
```

**Medium Impact:**
```html
<!-- Add resource hints -->
<link rel="preconnect" href="http://localhost:8081">
<link rel="dns-prefetch" href="http://localhost:8081">

<!-- Fix accessibility warning -->
<input type="password" autocomplete="current-password" />
```

**Strategic suggestions:**
- Code splitting to reduce initial bundle size
- Consider SSR for faster initial paint
- Implement performance monitoring

### Why This Matters
This isn't just a performance report—it's a **live debugging session** where the agent:
1. Recorded a real DevTools trace
2. Analyzed Core Web Vitals automatically  
3. Identified the root cause (render delay vs server response)
4. Provided specific code fixes
5. Could immediately re-test changes in the same session

This is the Lighthouse-style diagnosis, but **integrated into an iterative debugging loop**—trace → analyze → fix → re-trace—all without leaving the agent conversation.


## Conversational Debugging

DevTools MCP also enables conversational debugging workflows that are similar to [Playwright MCP](https://www.awesome-testing.com/2025/07/playwright-mcp)—you can ask questions about the live page state and get data-driven answers. The agent can inspect CSS rules, check console errors, analyze network requests, and correlate user actions with backend responses, all using Puppeteer under the hood.

For detailed debugging workflow examples, see my [Playwright MCP article](https://www.awesome-testing.com/2025/07/playwright-mcp). The key difference with DevTools MCP is the integrated performance analysis capabilities demonstrated above.

## Side-by-Side: Playwright MCP vs DevTools MCP

**Shared (broad parity)**: navigation, clicks, form-fill, JS eval, console/network inspection, screenshots—your [Playwright MCP](https://www.awesome-testing.com/2025/07/playwright-mcp) mental model transfers well.

**Technical difference**: DevTools MCP uses [Puppeteer](https://pptr.dev/) under the hood, while Playwright MCP uses Playwright's automation framework.

**DevTools MCP edge**: first-class performance tracing & insights from Chrome's Performance panel surface—the unique value for perf engineering.

If readers want the Playwright angle, check my two pieces on [theory](https://www.awesome-testing.com/2025/07/playwright-mcp) and [agentic execution tips](https://www.awesome-testing.com/2025/09/playwright-agentic-coding-tips).

## Conclusion

Chrome DevTools MCP turns performance optimisation into a conversational loop with Chrome: trace → analyse → change → re-trace. By letting AI agents "see" the running application through structured performance data, we bridge the gap between generic advice and actionable insights. The AI is no longer guessing—it has direct access to Core Web Vitals, network waterfalls, and long task analysis from a real Chrome session.

For technical readers eager to leverage this: explore the official [DevTools MCP tool reference](https://github.com/ChromeDevTools/chrome-devtools-mcp/blob/main/docs/tool-reference.md) and [Chrome's documentation](https://developer.chrome.com/blog/chrome-devtools-mcp) for setup. Experiment with prompts like:

```text
Use Chrome DevTools MCP to start a performance trace on http://localhost:8081/register,
reload, then analyse LCP/CLS/TBT and list top long tasks (>50ms). Propose code changes
and re-run the trace to validate improvements.
```

The responses you get will likely surprise you with their detail and accuracy. Over the coming months, expect this integration to mature and expand. It's part of a broader trend (my [AI tooling landscape](https://www.awesome-testing.com/2025/07/ai-tooling-for-developers-landscape) article describes the big picture) where AI agents become full collaborators in our development environments.

In my own workflow, I've started treating the AI as a performance companion that sits inside Chrome. It's not perfect—complex optimisations still sometimes require human insight—but it already saves time on routine analysis and catches issues I might miss. And each month it improves. I, for one, welcome this new kind of co-optimiser. After all, I prefer focusing on creative architecture rather than manually parsing every trace myself. With DevTools MCP, I finally have an AI that's well-equipped to help.

Give it a try: launch your site, enable DevTools MCP, and ask "Record a performance trace and tell me the top 3 bottlenecks." You might just find actionable insights from your new AI performance assistant.
