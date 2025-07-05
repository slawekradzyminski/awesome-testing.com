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
- [Birgitta Boeckeler](https://martinfowler.com/articles/exploring-gen-ai.html)

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

Coding is by far my top use case for AI. My entire [awesome-localstack](https://github.com/slawekradzyminski/awesome-localstack) project was created with the help of AI—it’s been my personal playground to experiment with different approaches, test new tools, and validate ideas. Whether it's experimenting with IDEs like Cursor or working through development plans using Claude or Gemini, AI has become an indispensable part of how I build.

My daily work reinforces these skills. I regularly use tools like GitHub Copilot and Junie in a professional setting, which helps me stay sharp and continuously refine my approach to AI-assisted software engineering.

The pace of change in this space is staggering. What’s not discussed enough—at least not in most mainstream engineering circles—is just how impactful Claude 4.0 Sonnet has been. In many real-world scenarios, it's raised the bar on reasoning, structure, and consistency in output.

One of the most important takeaways from this experience is simple: the smarter the model, the better the results.

Take, for example, LLM function calling. The model itself decides which tools to invoke and how to structure the response. Whether it’s generating an email, optimizing a class, or picking the right CLI tool for a job, model intelligence makes all the difference. Improvements in planning, tool orchestration, or reasoning directly translate into more useful, higher-quality outcomes.

Analyse carefully the image below (*PS: It is a mermaid graph generated by AI*). In case something in not clear copy-paste it to ChatGPT and start asking questions.

![LLM Function Calling](/images/blog/llmfunctionalling.png)

Clear AI-Assisted Coding trends and best practices seem to have emerged:

#### Use custom instructions

AI practitioners have introduced a term that’s gaining traction: context engineering. At its core, it’s about equipping the model with the right context and constraints to produce more tailored, reliable outputs. One of the most practical applications of this is custom instructions—which allow you to shape how the model codes.  

With custom instructions, you can enforce stylistic or architectural preferences. For example:
- Use the latest language syntax.
- Prefer arrow functions in JavaScript.
- Avoid Lombok in Java by explicitly using records and modern Java features.

In short, you're telling the model how to think like you. This is especially useful when collaborating on large projects or aligning with your team’s coding standards.

Sometimes, the simplest and most effective approach is to copy and paste a representative portion—or even the entire codebase—into the session. Modern models are often capable of learning your conventions on the fly, without the need for heavy prompt engineering. Once the model has your project as reference, it can adopt your structure, naming conventions, and patterns with impressive accuracy.

#### Plan first

As mentioned earlier, different models excel at different tasks. While some are outstanding at coding, others—like OpenAI’s o3—shine when it comes to planning and high-context reasoning. Personally, I always prefer to start with a plan, and this approach is increasingly recommended by experienced practitioners.

Why? Because it mirrors traditional development workflows:

First, we clarify the requirements. Then, we draft a plan, review it, discuss it with peers, and only then do we begin implementation. This intentional pause forces critical thinking and reduces downstream confusion.

Planning also makes it easier to break work into smaller, trackable tasks. It naturally supports iteration and visibility, which directly benefit the next two principles: small task execution and tracking progress.

Even JetBrains Junie is nudging users in this direction. It includes one-click built-in prompts that encourage developers to "plan first" before jumping into implementation. That alone is a good signal—it’s now considered a best practice.

#### Keep tasks small

This isn’t a new concept. Since the early days of ChatGPT, we’ve known that small, focused tasks yield better results. But with smarter models and more powerful agents, there's a growing temptation to let them handle larger chunks of work at once. That’s risky.

Keeping tasks small still matters. It creates clear feedback loops, reduces error rates, and makes debugging easier. Here's a simple flow that still works incredibly well:

- Implement the controller.
- Then the service.
- Then the repository.
- Then the test (or even better: test first, then implement until it passes).

Even better—after each step, ask the agent to review the code or run the tests. You don't have to do it manually; you can delegate these tasks. This way, you keep iterations tight and quality high while still working at AI-accelerated speed.

#### Update the progress / use some sort of memory

Tracking progress is essential—especially when things go off the rails. You should always be able to revert to a known working state, which means committing changes often and in small chunks.

The simplest and most effective habit I've found is to ask the agent to maintain a `progress.md` file. After each completed unit (e.g., controller, service, repository), I prompt the agent to update that file. It becomes a living changelog for the entire session.

There’s also a growing trend toward storing the entire task history and conversation as part of the file or within custom memory layers. While we don’t yet have robust tools to do this seamlessly, the idea is gaining momentum—and I expect the ecosystem to catch up soon.

For now, combining traditional version control with smart use of context-aware notes (like `progress.md`) gets the job done well.

You can find more detailed example of my coding workflow in my [AI-Vibe Coding Notes from the Basement](https://www.awesome-testing.com/2025/04/ai-vibe-coding-notes-from-the-basement) post.

### Learning

Learning might be the most underappreciated aspect of the current AI revolution—but for curious minds like mine, it’s an absolute game changer.

Whether I want to understand how the LinkedIn or Instagram algorithms work, explore the history of conflicts in the Middle East, get personalized book recommendations, find Booker Prize winners by year, or look up films starring Sydney Sweeney—I just ask. And I ask a lot. The sheer speed and quality of answers make AI my first-stop resource for exploring almost any topic.

For IT professionals, my top recommendation is this: whenever you encounter something you don’t understand—ask. No matter how experienced you are, there will always be unfamiliar terms, frameworks, or concepts. For example, Claude Code recently released Hooks—a notable update that most people probably missed. Or take OpenAI’s Codex Cloud Agent. When something like that comes up, the best habit you can develop is to simply ask:

- What is it?
- How does it work?
- What does it mean for my role or industry?

AI can help you answer those questions in minutes—saving hours of scattered research.

I also frequently use AI to generate learning paths. When I’m exploring a new topic or trying to level up in a specific area, I’ll ask for a structured roadmap, recommended resources, or even quiz-style prompts to check my understanding.

This is especially valuable for software testers. We are often testing complex systems, and to test them effectively, we need to understand them deeply. I’ve always emphasized that strong testers have both technical and business understanding. Historically, the industry has leaned heavily toward the business side—ensuring we're building the right thing. But I believe the technical side has been underrepresented, especially in conferences and thought leadership.

Now is the perfect time to change that.

When you test a feature, take a step back and ask:

- How does the server actually work?
- How does the frontend communicate with the backend?
- What security mechanisms are in place?
- How does state persist across sessions?

Build your technical intuition. Not only is it more accessible than ever—it’s what separates average testers from great ones. And with AI at your side, there’s no excuse not to go deeper.

Example: [How Playwright MCP works?](https://chatgpt.com/share/6868e15f-bd20-800a-9f00-146d4537bb32)

### Writing

Writing is a core part of my work. Whether it’s blog posts, internal proposals at Ocado, training plans, or presentation slides—I write a lot. And AI plays a key role in almost every part of that process.

My workflow usually starts with voice input—like I’m doing right now. I dictate my thoughts naturally, then use AI to clean up, restructure, and refine the output. Over the past few months, I’ve tried various approaches, and one thing is very clear:

> Generating complete content from scratch—without your own input—is a mistake.

If your goal is to publish a blog post without putting in any real effort, please don’t. The internet doesn’t need more low-effort content. Instead, AI should be treated as a writing assistant, not a ghostwriter. You bring the insight—AI helps with clarity, structure, and tone.

For me, as a native Polish speaker, AI has been transformative. I can speak in Polish, let the model translate my thoughts into English, and then refine that output—resulting in content that’s not only accurate but polished and professional.

Sometimes I revisit old blog posts just to remind myself how much smoother and faster the writing process has become with AI in the loop. The improvement is obvious.

Of course, we’re also seeing an explosion of AI-generated content online—and much of it is low quality. But let’s not forget: blog posts from 10 years ago were often rough too—many weren’t proofread, and some were hard to follow. Tools like ChatGPT absolutely raise the baseline quality of writing. That said, they often produce too much text. Verbosity is a known issue. Even this post might feel too long for some readers.

That’s why it’s important to find the right balance:

- Be clear, but not over-explained.
- Be helpful, but avoid fluff.
- Be human, even with machine support.

As you grow into senior or staff engineering roles, writing becomes even more important than coding. You’ll write proposals, documentation, team updates, and strategic plans. Writing clearly is part of leadership—and AI can absolutely help you get there faster.

So yes, use AI to write. But write intentionally. Your ideas still matter most.

### Image generation

Since I regularly create presentations, slides, and technical documents, I often use AI to generate visuals that complement my content. This has become an integral part of my workflow—and it's surprisingly simple.

My typical process starts with voice input. I describe what I need, and then ask ChatGPT to help me craft a prompt that will generate the right image. When needed, I provide full context to help the model understand the intent behind the visual.

Here’s a real example from one of my prompts:

[Example](https://chatgpt.com/share/6868e299-2104-800a-8c73-6cdabbc472a6):

>I need an image which will emphasize the triangle needs of my tests: speed, effectivess and cost. Give me a prompt which I can use to generate such image

[Result](https://chatgpt.com/share/6868e2b2-d750-800a-8029-2c9b580234e3):

![Image generation](/images/blog/imagegeneration.png){:width="50%"}

The results aren’t always perfect on the first try—but more often than not, they’re good enough to include in a deck or a document. And more importantly, they save me a lot of time. No more searching endlessly for the “right” stock photo or diagram.

When I don’t use AI-generated images, I often fall back to [Unsplash](https://unsplash.com), which offers a wide range of high-quality, royalty-free photos that work great in professional materials.

The bottom line: visual content matters, and AI makes it faster and easier to create. Whether you’re trying to explain a concept, emphasize a trade-off, or just make a slide more engaging—don’t overlook the power of AI-generated visuals.

## 4. Conclusion

AI is fundamentally changing how I work—and I’m sure it’s changing how you work too. At this point, there’s no going back. AI continues to improve across the board: coding, writing, image generation, planning, even how we read and process information. It’s not just a trend—it’s a transformation. And it’s a big deal.

I’ve always been an AI enthusiast, but with each passing month, I’m more convinced that everyone in tech should become one—regardless of your role.

If you're on a team, I strongly encourage you to start learning how AI works under the hood. Understand not just what it can do, but why it works the way it does. Go beyond surface-level prompt use. Experiment with different models, compare tools, and document your findings.

Here are a few practical ways to integrate AI into your team's workflow:

- Share your prompts internally—what worked, what didn’t.
- Experiment with AI-powered IDEs, CLI tools, and async agents.
- Use AI to assist with retrospectives, planning, test documentation, or even refining your test cases.
- Let AI generate or validate your reports, technical documentation, or code reviews.
- Use it. Test it. Break it. Refine your process.

The more you engage with these tools, the more value you’ll get—and the better prepared you’ll be for what’s coming. Because the future will look different. Drastically so.

Stay curious. Stay adaptable. And build with AI in the loop.

Further reading:
- [The rise of AI-Driven Development](https://www.awesome-testing.com/2024/09/the-rise-of-ai-driven-development)
- [From Live Suggestions to Agents: Exploring AI-Powered IDEs](https://www.awesome-testing.com/2024/12/from-live-suggestions-to-agents-exploring-ai-powered-ides)
- [AI Vibe Coding Notes from the Basement](https://www.awesome-testing.com/2025/04/ai-vibe-coding-notes-from-the-basement)
