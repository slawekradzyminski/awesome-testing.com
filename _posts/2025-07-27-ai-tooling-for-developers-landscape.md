---
title: "AI Tooling for Developers Landscape"
layout: post
permalink: /2025/07/ai-tooling-for-developers-landscape
categories:
  - AI
tags:
  - AI
header:
  og_image: /images/blog/cursoragent.png
description: >
  A landscape of AI tooling for developers.
---

![AI Agents History](/images/blog/aiagentshistory.png)

At the end of 2024, in [From Live Suggestions to Agents: Exploring AI-Powered IDEs](https://www.awesome-testing.com/2024/12/from-live-suggestions-to-agents-exploring-ai-powered-ides), I described current landscape of AI tooling for developers. My focus was mainly on Agentic IDEs. A lot has changed since, but one quote remains relevant:

> With the rapid pace of innovation in this field, we can expect even more tools and features to emerge. Major investments from big players signal a bright future for AI-powered IDEs, making it an exciting time to explore and adopt these technologies.

As you can see in the timeline in 2024-2025 we saw the explosion of entirely new groups of tools:
- Project starters / boot-strappers (like [v0.dev](https://v0.dev), [Bolt.new](https://bolt.new), [GitHub Spark](https://githubnext.com/projects/github-spark/) or [Lovable.dev](https://lovable.dev)).
- CLI tools (like [Aider](https://aider.chat), [Claude Code](https://www.anthropic.com/claude-code) or [Gemini CLI](https://developers.google.com/gemini)).
- Autonomous agents (like [Devin.ai](https://devin.ai), [OpenAI Codex](https://openai.com/codex) or [Cursor Background Agents](https://cursor.sh)).

Together with traditional AI-powered IDEs/extensions like [Cursor](https://cursor.sh) and [GitHub Copilot](https://docs.github.com/en/copilot) we now have 4 distinct groups of tools which I'd like to describe in more detail in the following sections.

Of course this classification is not perfect and there are tools which can be classified in multiple groups. For example `Cursor` is both an AI-powered IDE and aims to become a strong competitor in autonomous agents space.

## AI tools for developers

### Project starters / boot-strappers

Project starters / boot-strappers are tools which can be used to create a new, fully-fledged project. They are often called No-Code / Low-Code tools and can be used by non-developers to create new projects from textual prompts, business requirements, design files, etc. This is highly controversial (due to security concerns, feasibility of making it production-ready, etc.) so I usually discourage non-developers from trying. Sooner or later real debugging and development skills will be required to modify the generated code.

For experienced developers they work as a initial 'idea to code' allowing rapid prototyping and experimentation. They're excellent for internal projects, side-projects, learning and teaching.

Here is a typical workflow:

![Project Starter Workflow](/images/blog/bootstrapworkflow.png)

The entry points vary from UI-based (directly in the browser, as for [v0.dev](https://v0.dev)), CLI-based to IDE-based. Below you can find a GitHub Spark screenshot from [Simon Willison blog](https://simonwillison.net/2025/Jul/24/github-spark/):

![GitHub Spark](/images/blog/spark-ui.jpg)

#### Tools

##### Quick Comparison Table

| Tool | Core Strength | Typical Output | Best Fit | Pricing |
|------|---------------|----------------|----------|---------|
| **[Lovable.dev](https://lovable.dev)** | Multi-persona chat builds full-stack apps (Supabase/Stripe) | React + Supabase repo pushed to GitHub | Indie hackers & MVPs | 5 msgs/day free; $20/mo ≈ 100 edits |
| **[Bolt.new](https://bolt.new)** | Lightning-fast React/Tailwind scaffolds in a StackBlitz IDE | Copy-paste-ready UI / full pages | Front-end devs & designers | ~1M free tokens, $20 for 10M |
| **[GitHub Spark](https://githubnext.com/projects/github-spark/)** | "Prompt-to-micro-app" with managed runtime | Deployed PWA + dashboard | Personal utilities & internal tools | Bundled with Copilot Pro+ ($19/mo) |
| **[Claude Artifacts](https://www.anthropic.com/news/build-artifacts)** | Turns any prompt into a shareable interactive app inside Claude | Self-hosted artifact (HTML / React) | Educators & knowledge workers | Available on all Claude tiers, even Free |
| **[Replit Agent](https://replit.com/)** | One-prompt cloud IDE that builds & deploys full apps | Live URL + editable Repl | Beginners, students, rapid prototypes | Usage-based pricing |
| **[Vercel v0](https://v0.dev)** | Chat-to-Next.js components with one-click Vercel deploy | Polished JSX/Tailwind blocks | React/Next.js teams & marketing sites | 200 free credits, plans from $10/mo |

##### Detailed Tool Reviews

###### [Lovable.dev](https://lovable.dev) — "Build something Lovable"

Lovable lets you brainstorm with a chat staffed by virtual personas (PM, Designer, Engineer) that iterate toward a working full-stack app. The generator can wire up Supabase for data and Stripe for payments, then push the code to a private GitHub repo so real developers can take over.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>End-to-end flow: prompt → design → code → deploy, entirely in-browser</li>
      <li>Real code export avoids lock-in; you own the repo</li>
      <li>Opinionated React + Supabase stack for consistency</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Security / responsiveness issues need manual polish</li>
      <li>Free token limits can interrupt longer sessions</li>
      <li>No in-app code editor; requires external IDE for modifications</li>
    </ul>
  </div>
</div>

###### [Bolt.new](https://bolt.new) — Frontend lightning in a browser

Born from StackBlitz, Bolt.new spins up a VS-Code-style web IDE and, from a single prompt, creates clean React + Tailwind components or full pages with live preview. Uses WebContainer tech (runs Node in-browser, no cloud VM).

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Instant visual feedback and editable code in the browser</li>
      <li>Perfect for dashboards or marketing pages; Netlify/Vercel deploy buttons included</li>
      <li>Token-based pricing (~1M free, $20 for 10M)</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Front-end only – you must supply your own back-end</li>
      <li>Daily free-token ceiling; heavy users hit paywall quickly</li>
    </ul>
  </div>
</div>

###### [GitHub Spark](https://githubnext.com/projects/github-spark/) — "Prompt-to-micro-app" in a managed runtime

Spark is a GitHub Next experiment that lets you describe a "spark" in plain English and receive a fully hosted, installable PWA—no local build or deploy steps. Bundled with Copilot Pro+ ($19/mo).

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>NL editor, revision history, and model picker (GPT-4o, Claude Sonnet 4, etc.)</li>
      <li>Share or remix sparks; access control down to read-only vs. read-write</li>
      <li>On-canvas model picker for different AI models</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Designed for micro apps; complex SaaS still needs a traditional stack</li>
      <li>Closed runtime (storage & LLM billing handled inside GitHub Cloud)</li>
    </ul>
  </div>
</div>

###### [Claude Artifacts](https://www.anthropic.com/news/build-artifacts) — Conversational app-in-a-box

Anthropic's Claude side-panel now promotes large outputs into artifacts: interactive apps, documents, or visualisations you can edit, fork, and share—all without leaving chat. Now interactive, shareable, and available on all Claude tiers, even Free.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Zero setup; any Claude chat can turn into a live widget or mini-site</li>
      <li>Billing shifts to each artifact's user, so creators don't pay ongoing API costs</li>
      <li>Available on all Claude tiers, including Free</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>No external API calls or persistent DB (yet); runs in Claude's sandbox</li>
      <li>Versioning and team collab still basic compared with GitHub repositories</li>
    </ul>
  </div>
</div>

###### [Replit Agent](https://replit.com/) — One-prompt cloud dev environment

Replit upgrades its cloud IDE with Agent, a chat that scaffolds, runs, and deploys code in the same browser tab; every project gets hosting, DB, and auth out-of-the-box.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>End-to-end flow (idea → URL) with mobile editing support</li>
      <li>Multi-model "power-up" modes for tougher tasks</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Platform lock-in — exporting to your own infra is possible but non-trivial</li>
    </ul>
  </div>
</div>

###### [Vercel v0](https://v0.dev) — Chat-to-Next.js components & sites

v0.dev is Vercel's AI UI builder: chat a request, get a live preview plus production-ready Next.js + Tailwind code, then hit Deploy → Vercel to go live.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Generates pixel-perfect shadcn/ui components that slot straight into existing repos</li>
      <li>One-click deploy inherits Vercel's edge functions, SSR, image opt, etc.</li>
      <li>Multi-framework output (React, Vue, Svelte, plain HTML)</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Front-end focus—no DB or auth scaffolding</li>
      <li>Opinionated toward Tailwind and Next.js; other stacks need adapters</li>
    </ul>
  </div>
</div>

##### Other Notable Starters

| Tool | Quick Pitch | Source |
|------|-------------|--------|
| **[Dyad](https://dyad.sh)** | Free, local, open-source Lovable alternative (no sign-up) | [dyad.sh](https://dyad.sh) |
| **Townie AI (Val Town)** | Claude-powered assistant that builds & edits serverless apps from chat | [blog.val.town](https://blog.val.town) |

##### Key Takeaways

- **Conversation-as-Creation** has become the norm: all six tools rely on chat or prompt interfaces rather than GUI wizards.

- **Scope divergence**: Lovable, Spark, and Replit aim for full-stack delivery, whereas Bolt and v0 double-down on front-end craft and Claude Artifacts stays in a sandbox.

- **Export vs. lock-in**: Tools that push real code to GitHub (Lovable, Bolt) mitigate lock-in, while closed runtimes (Spark, Artifacts) trade flexibility for speed and hosting simplicity.

- **Maturity curve**: incidents like Replit's rogue deletion underline that security & governance still lag behind raw generation power; treat generated scaffolds as prototypes until audited.

Used wisely, these project starters compress weeks of boilerplate into minutes, letting developers (or even non-developers) jump straight to feature work and feedback loops. Pick the one that aligns with your stack, hosting comfort, and appetite for vendor lock-in—and always keep that first manual code review in the checklist.

### AI-powered IDEs/IDE extensions

> Note: I've covered AI-powered IDEs extensively in [From Live Suggestions to Agents: Exploring AI-Powered IDEs](https://www.awesome-testing.com/2024/12/from-live-suggestions-to-agents-exploring-ai-powered-ides) blog post. For detailed coding guide see [AI Vibe Coding Notes from the Basement](https://www.awesome-testing.com/2025/04/ai-vibe-coding-notes-from-the-basement).

This remains the most important category because, in professional settings, we ultimately have to review the code generated by AI, improve it, and make it production-ready. Even when we bootstrap a project using a starter template, add features via CLI tools, or use autonomous agents, it's still up to us to refine and polish the code inside actual IDE.

AI IDE or AI extensions give us 3 main features:
- **Autocomplete** - when we type, we get suggestions for the next line, function or even a whole block of code.
- **Contextless code generation** - we can ask AI to generate / refactor a selected function, class, module, etc.
- **Agentic, context-aware feature generation** - AI IDEs are getting better and better at understanding our codebase and we can ask them to generate a new feature, fix a bug, etc.

#### Tools

##### Quick Comparison Table

| Tool | Core Pitch | Sonnet 4 Access | Typical Usage Pattern |
|------|------------|-----------------|---------------------|
| **[Cursor](https://cursor.sh)** | VS-Code-fork that embeds chat, tab-complete & background agents | Built-in on paid plans | Inline suggestions, project-wide refactors, dev-container agents |
| **[Windsurf](https://windsurf.com)** | "Flow-state" AI IDE with dual chat/completion panes | Built-in for Pro/Teams | Cascade tasks, multi-file edits, sandboxes for code execution |
| **[GitHub Copilot](https://docs.github.com/en/copilot)** | Universal extension + chat that taps GitHub's code graph | Built-in across all paid Copilot plans | Autocomplete, chat, PR reviews, terminal/CLI helper |
| **[IntelliJ Junie](https://www.jetbrains.com/help/idea/junie.html)** | JetBrains agent that can plan, code, run tests in IDE | Built-in — switch Sonnet 3.7 ↔ 4 in Settings → Tools → Junie → Models | Delegate a task, watch Junie patch & run project tests |
| **[Roo Code](https://roocode.com)** | Open-source VS Code plugin; orchestrates multiple AI agents | BYOK (Anthropic key or via OpenRouter) | Multi-agent "dev team" inside VS Code; diff-based commits |
| **[Cline](https://cline.sh)** | Transparent, open-source coding agent with Plan/Act modes | Built-in default (or BYOK) since v3.18 | Generates plans, executes terminal commands, edits repo files |
| **[Trae](https://trae.dev)** | Free all-in-one AI IDE from ByteDance with MCP tool plugins | Built-in (and free) since June 2025 | Builder mode scaffolds features; Agent mode auto-fixes bugs |

##### Detailed Tool Reviews

###### [Cursor](https://cursor.sh) — VS Code-fork with embedded AI

Cursor extends VS Code with token-aware completions ("Tab"), a sidebar chat, and optional background agents. Paid tiers include first-party Sonnet 4; free users can drop an Anthropic key under Settings → Models.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Large 120k-token window for whole-project refactors</li>
      <li>Background agents for autonomous development</li>
      <li>Familiar VS Code interface with AI enhancements</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Requires adaptation to new IDE workflow</li>
    </ul>
  </div>
</div>

###### [Windsurf](https://windsurf.com) — "Flow-state" AI IDE

Marketed as "the first agentic IDE," Windsurf offers cascade-style tasks and built-in sandboxes. In July 2025 it regained direct Sonnet 4 access for all paying users — and even free users via BYOK.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Cascade-style task execution</li>
      <li>Built-in sandboxes for code execution</li>
      <li>Dual chat/completion panes for better workflow</li>
      <li>Cascade agent chain and MCP plugin store</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Requires adaptation to new IDE workflow</li>
    </ul>
  </div>
</div>

###### [GitHub Copilot](https://docs.github.com/en/copilot) — Universal AI coding assistant

Copilot's docs list Claude Sonnet 4 and Opus 4 among chat models for every paid plan. The new model picker in VS Code and JetBrains lets developers switch between GPT-4o, Sonnet 4, Gemini 2.5 Pro, and others depending on the task.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Deep GitHub ecosystem integration</li>
      <li>Universal extension works across IDEs</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Ecosystem lock-in with GitHub</li>
    </ul>
  </div>
</div>

###### [IntelliJ Junie](https://www.jetbrains.com/help/idea/junie.html) — JetBrains AI agent

Junie lives inside JetBrains IDEs as a higher-autonomy agent. Users can toggle between Sonnet 3.7 and Sonnet 4.0 in settings. Now available to all licensed IDE users (free daily quota).

**Pros:**
- Can plan, edit, and run tests end-to-end
- Deep JetBrains IDE integration
- Built-in Sonnet 4 access
- Planning + test-running ability and Claude/Gemini model toggle

**Trade-offs:**
- Limited to JetBrains IDEs
- Doesn't support MCP yet

###### [Roo Code](https://roocode.com) — Multi-agent VS Code extension

Roo Code is a FOSS VS Code extension positioned as "a whole dev team of AI agents." Supports Sonnet 4 (plus Thinking variants).

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Open-source and transparent</li>
      <li>Multi-agent "dev team" approach</li>
      <li>Supports custom MCP tools for power users</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Requires BYOK for Sonnet 4 access</li>
      <li>More complex setup than single-agent solutions</li>
      <li>Can be expensive</li>
      <li>Limited to VS Code</li>
    </ul>
  </div>
</div>

###### [Cline](https://cline.sh) — Transparent coding agent

Cline markets "open, uncompromised coding." Use Sonnet 4 as the default for best diff-edit reliability.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Open-source and transparent</li>
      <li>Exposes every decision and action</li>
      <li>Plan/Act modes for structured development</li>
      <li>Supports custom MCP tools</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Requires BYOK for optimal Sonnet 4 access</li>
      <li>May require more technical setup</li>
      <li>Less polished than commercial alternatives</li>
    </ul>
  </div>
</div>

###### [Trae](https://trae.dev) — Free AI IDE from ByteDance

ByteDance's free IDE ships with Claude 4 out-of-the-box.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Completely free with built-in Sonnet 4</li>
      <li>All-in-one solution with MCP tool plugins</li>
      <li>Builder mode for feature scaffolding</li>
      <li>Agent mode for auto-fixing bugs</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>May have privacy concerns for some users (free Sonnet 4 is rather suspicious)</li>
    </ul>
  </div>
</div>

##### Key Insights

- **Pricing nuance**: Some tools (e.g. Cursor) have implemented weird Pricing rules, even for paid tiers. RooCode/Cline can quickly become expensive. Experienced AI users can utilise [OpenRouter](https://openrouter.ai) to minimise RooCode/Cline cost.

- **Tool by tool analysis recommended**: I suggest to try each of these tools first and decide which one is the best fit for your workflow. List down your requirements first, analyse pricing, and then decide.

The race is very competitive with new tools like [AWS Kiro](https://kiro.dev/) joining almost weekly.

### CLI tools

CLI tools represent the command-line interface to AI-powered development. Throughout 2024–25, the command line has become a hotbed for agentic coding tools. Aider, Claude Code, Gemini CLI, and Qwen CLI all allow you to chat with an LLM that can read, write, run, and test your local project. These tools differ mainly in:
- the model they use
- how much autonomy they take before asking for permission
- pricing
- default workflows
- context window size

Developers typically use the CLI to quickly prompt the model, then return to the IDE to review and refine the changes. Occasionally, we still need to step in to debug issues the AI struggles with.

![Gemini CLI](/images/blog/GeminiCLI.png)

#### Tools

##### Quick Comparison Table

| Tool | Built-in Model(s) | How it Edits Code | Autonomy Defaults | Ideal For |
|------|-------------------|-------------------|-------------------|-----------|
| **[Aider](https://aider.chat)** | BYOK – integrates with Claude Sonnet 4, GPT-4o, Gemini 2.5, DeepSeek, local Llama via Ollama | Generates git-aware diffs then applies them; auto-runs tests if configured | Prompt-by-prompt (asks before each commit) | Devs who want an open, hackable tool that speaks every model |
| **[Claude Code](https://www.anthropic.com/claude-code)** | Claude Sonnet 4 / Opus | Plans tasks, rewrites files, compiles & tests inside a sandbox; shows reasoning log | Semi-auto: will refactor & run tests on its own, pauses at risky ops | Large mono-repos needing refactor/analysis, users on Anthropic API |
| **[Gemini CLI](https://developers.google.com/gemini)** | Gemini 2.5 Pro / Flash | ReAct loop calls shell, git & unit-test tools; stores plan in .gemini dir | Ask-once-then-act (will iterate until tests green) | Teams in Google ecosystem or devs who want a free-tier frontier model |
| **[Qwen CLI](https://github.com/QwenLM/Qwen-Coder)** | Qwen 3-Coder (open-source 72B & 32B) | Fork of Gemini CLI; adds richer parser & diff printer for Chinese/English codebases | Same as Gemini CLI; can be tightened via `--confirm` flag | OSS contributors & mainland-China devs wanting local weights |

##### Detailed Tool Reviews

###### [Aider](https://aider.chat) — "AI pair programming in your terminal"

Aider maps your codebase, lets you chat about changes, produces a unified diff, then applies and commits it. It supports almost any model — Claude Sonnet 4 and GPT-4o are recommended, but release v0.32 added Gemini 2.5 and OpenAI o3-pro support.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Supports almost any model (BYOK approach)</li>
      <li>Git-aware diffs with safety-first approach</li>
      <li>Large-context editing (8k-token local LLMs or 120k Claude)</li>
      <li>Community plugins for Emacs/Neovim integration</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Prompt-by-prompt workflow (asks before each commit)</li>
      <li>Requires explicit `!` for shell commands</li>
      <li>More manual control means slower workflow</li>
    </ul>
  </div>
</div>

###### [Claude Code](https://www.anthropic.com/claude-code) — Anthropic's agentic coder

Claude Code reads an entire repo in seconds, builds a dependency graph, and then lets Sonnet 4 (or Opus) plan multi-step refactors. The tool's reason-and-act logs show every decision, giving users a chance to halt or tweak mid-flight.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Bundled Sonnet 4/Opus access</li>
      <li>Automatic codebase tour for onboarding</li>
      <li>Sandboxed test execution</li>
      <li>Detailed reasoning logs</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Anthropic ecosystem lock-in</li>
      <li>Limited write scope to avoid over-eager deletions</li>
    </ul>
  </div>
</div>

###### [Gemini CLI](https://developers.google.com/gemini) — Google's open-source terminal agent

Released as part of Gemini Code Assist in June 2025, this MIT-licensed CLI taps Gemini 2.5 Pro/Flash for free (login via Google account) or lets enterprises plug in Vertex AI keys.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Gemini 2.5 Pro/Flash</li>
      <li>Open-source and extensible</li>
      <li>ReAct loop with built-in tools (git, npm, pytest, Docker)</li>
      <li>Session persistence in `.gemini/work` folder</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Google ecosystem dependency</li>
      <li>Ask-once-then-act autonomy may be too aggressive</li>
    </ul>
  </div>
</div>

###### [Qwen CLI](https://github.com/QwenLM/Qwen-Coder) — Alibaba's fork for the Qwen 3-Coder model

Qwen Code started as a fork of Gemini CLI, optimized for Qwen3-Coder-72B & 32B weights. It includes parser tweaks that boost diff-edit accuracy and multilingual variable-name handling.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Open-source weights (Apache 2)</li>
      <li>Optimized for Chinese/English codebases</li>
      <li>50k-token contexts on single A100 GPU</li>
      <li>VS Code "Qwen Tasks" extension included</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Limited to Qwen models</li>
      <li>Requires `--confirm` flag for safety</li>
      <li>Smaller community compared to others</li>
    </ul>
  </div>
</div>

##### Key Insights

- **Model flexibility vs. bundling**: Aider is the BYOK champion, whereas Claude Code and Gemini CLI ship with opinionated defaults.

- **Autonomy spectrum**: All support hands-free loops, but Aider and Qwen default to ask first, act later; Gemini and Claude lean more autonomous.

- **Ecosystem pull**: Claude Code shines if you're already on Anthropic API; Gemini CLI integrates with Google Cloud; Qwen caters to open-weights or CN infra; Aider spans them all.

- **Extensibility**: Open-source bases (Aider, Gemini, Qwen) encourage custom tool plugins — e.g. adding Terraform or Kubernetes commands to the agent chain. Claude Code allows [Hooks](https://docs.anthropic.com/en/docs/claude-code/hooks).

- **Common best practice**: keep `git diff --staged` open — even the smartest agent occasionally deletes the wrong env file!

Consider [Open Interpreter](https://openinterpreter.com/) as a community-driven alternative for local development.

These terminal companions don't just suggest code; they run commands, write files, and validate results while giving you granular control over each step. Pick one that matches your model budget, autonomy comfort, and cloud allegiance.

### Autonomous agents

Autonomous Coding Agents are a relatively new but exciting category: these are AI systems that can take high-level development tasks and carry them out with minimal supervision, effectively acting as junior developers (or even an entire dev team for well-scoped problems). Unlike IDE or CLI helpers, autonomous agents chain together planning, coding, execution, and iteration. 

Given a goal (e.g. "implement a feature" or "find and fix a bug"), an agent will:
- plan a solution
- write or modify code across the codebase
- run tests or scripts to verify
- make commits or pull requests – all on its own or with occasional human approval steps.

You can set goal anytime—during a commute, meeting, or between tasks. You open the agent interface (in a web or mobile app), enter your request, and the system provisions a secure environment (usually a virtual machined spawned in the cloud) where the agent works autonomously. The isolation ensures the live codebase remains safe. Agents can invoke shell commands to install dependencies, compile, or test—all automatically, but with configurable feedback loops (tests, linters, type checks, CI gates) to validate correctness and safety.

![Cursor Agent](/images/blog/cursoragent.png)

Agents are usually rather slow, but considering you spawn them asynchronously, you should not expect immediate results. In fact, you should consider them as background workers which you manage, but not micro-manage. At some point, you should check the results and decide if you need to intervene. You need to act as a leader which is responsible for the outcome, not the process.

![AI Agent Flow](/images/blog/aiagentflow.png)

#### Tools

##### Quick Comparison Table

| Tool | Typical Inputs | What the Agent Actually Does | Default Autonomy | Time Budget | Best Fit |
|------|----------------|------------------------------|------------------|-------------|----------|
| **[Google Jules](https://jules.google)** | Repo + natural-language ticket | Clones repo into secure VM, writes/fixes code, runs tests, opens PR, posts audio changelog | Async "fire-and-forget"; pings you when done | Hours to days | Teams who want a hands-off background coder |
| **[OpenAI Codex](https://openai.com/codex)** | GitHub issue / chat prompt | Plans for ≤30 min, edits code in sandbox, runs unit tests, pushes branch + PR | Timed autonomous bursts, then hands back | 30-minute bursts | Cloud users already in ChatGPT ecosystem |
| **[Devin AI](https://devin.ai)** | High-level task or migration spec | Spins up cloud workspace, shells/browsers/scripts its way to solution, self-tests, produces multi-PR roadmap | Multi-day, multi-agent swarms; human only approves PRs | Multi-day swarms | Large refactors or backlog grind (e.g. Nubank ETL split) |
| **[Cursor Background Agents](https://cursor.sh)** | In-IDE command or Slack message | Launches remote container, edits & runs code, reports via sidebar/Slack, can be taken over live | Parallel async helpers; ask-then-act loops | Hours | Devs who already live in Cursor but want tasks off-loaded |

##### Detailed Tool Reviews

###### [Google Jules](https://jules.google) — "Asynchronous coding while you ride a bike"

Google Labs unveiled Jules as an asynchronous coding agent: you assign a GitHub repo and a detailed prompt, then Jules vanishes into a secure cloud VM to work on bug fixes, version bumps, or feature branches.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Completely off-device operation</li>
      <li>Self-healing plans (iterates if tests fail)</li>
      <li>Audio changelog narrates what it did</li>
      <li>"Fire-and-forget" in a secure VM</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Can burn through CI minutes if left unchecked</li>
      <li>Limited to Google's cloud infrastructure</li>
    </ul>
  </div>
</div>

###### [OpenAI Codex](https://openai.com/codex) — 30-minute "virtual coworker" inside ChatGPT

The new Codex agent (distinct from 2021's model) lives in ChatGPT Pro/Enterprise and as an open-source CLI. Give it a GitHub issue or repo link; Codex launches a sandbox, creates a plan, codes for up to 30 minutes, runs tests, and pushes a branch with a pull-request description.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>30-minute autonomous bursts</li>
      <li>Available in ChatGPT and as CLI</li>
      <li>Streams logs for transparency</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Limited external network access for security</li>
      <li>Limited to OpenAI's ecosystem</li>
    </ul>
  </div>
</div>

###### [Devin AI](https://devin.ai) — "Hire an army of junior engineers in the cloud"

Cognition Labs' Devin markets itself as the first AI software engineer and now powers multi-agent "cloud factories." Devin opens a full Linux workspace (shell + editor + browser), decomposes tasks, searches docs, writes code, runs integration tests, and learns from failures.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Full Linux workspace with shell, editor, and browser</li>
      <li>Multi-agent swarm capabilities</li>
      <li>Can handle large-scale migrations</li>
      <li>Learns from failures and iterates</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Enterprise pricing model</li>
      <li>Bills per-agent container</li>
    </ul>
  </div>
</div>

###### [Cursor Background Agents](https://cursor.sh) — Mini-Devin for Cursor users

Cursor added Background Agents so developers can off-load tasks (e.g., "convert our CSS-modules to Tailwind") without leaving the editor. A sidebar button spawns a remote container, where the agent clones your repo, edits files, runs tests, and updates status live.

<div style="display: flex; gap: 20px; margin: 20px 0;">
  <div style="flex: 1; background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%); border-left: 4px solid #28a745; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #155724; font-size: 16px; font-weight: 600;">✅ Pros</h4>
    <ul style="margin: 0; padding-left: 20px; color: #155724;">
      <li>Integrated into Cursor IDE</li>
      <li>Can be taken over live at any time</li>
      <li>Slack integration for notifications</li>
      <li>PR-template support and conflict handling</li>
    </ul>
  </div>
  <div style="flex: 1; background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%); border-left: 4px solid #dc3545; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
    <h4 style="margin: 0 0 10px 0; color: #721c24; font-size: 16px; font-weight: 600;">⚠️ Trade-offs</h4>
    <ul style="margin: 0; padding-left: 20px; color: #721c24;">
      <li>Limited to Cursor ecosystem</li>
      <li>Runs in Cursor's cloud infrastructure</li>
      <li>Charges per agent-hour</li>
    </ul>
  </div>
</div>

##### Key Insights

- **Shared recipe**: clone → plan → code → self-test → open PR. All four agents follow this loop, differing mainly in time budget (minutes for Codex, hours or days for Devin) and where they run (local sandbox vs. vendor cloud).

- **Human checkpoints matter**: whether it's Jules' PR, Codex's 30-min limit, Devin's manager approval, or Cursor's sidebar diff, each system inserts review gates to prevent runaway changes—an essential guard against LLM hallucinations.

- **Scale vs. cost**: Devin's swarm mode delivers massive throughput but bills per-agent container; Codex and Jules meter compute minutes; Cursor charges per agent-hour. Budget-conscious teams often start with Cursor agents for small chores and graduate to Devin for large migrations.

- **Definition still fluid**: Even VC panels admit the industry hasn't settled on what an AI agent is beyond "multi-step, self-directed LLM"—expect rapid feature overlap as each tool races toward greater autonomy.

In practice, autonomous agents excel at repetitive, well-scoped engineering chores—tests, refactors, dependency bumps, or large-scale code mods—while still needing humans for architecture, security, and taste. Pick the agent whose runtime model, sandbox policy, and pricing suit your workflow, then keep that review button close at hand.

## Future

It seems likely that the next iteration of tools will be based on multiple AI Agents (see Claude's [Subagents](https://docs.anthropic.com/en/docs/claude-code/sub-agents)), each focused on a specific task.

Imagine a bootstrapper agent that can create a new project from scratch, a backend code editor which optimises initial output, a DB specialist which creates a schema, a frontend code editor which fixes React components and a QA which verifies the whole thing. 

The agents can work together to review their respective outputs and improve the overall quality of the project. Perhaps additional PM AI agent can act as a entity which decide whether given outcome is good enough or not. Each Merge Request can be reviewed by a dedicated agents focused on various characteristics of software (e.g. security, performance, etc.).
