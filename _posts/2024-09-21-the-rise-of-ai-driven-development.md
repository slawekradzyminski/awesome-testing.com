---
title: "The rise of AI Driven Development"
layout: post
permalink: /2024/09/the-rise-of-ai-driven-development
categories:
  - AI
tags:
  - AI
---

![AI Robot](/images/blog/ai-robot.jpg){:width="50%"}

As the AI hype settles down a bit, now seems like the perfect time to reflect on what we've learned so far. Nearly two years have passed since ChatGPT was released, and the majority of AI tools still rely heavily on Large Language Models (LLMs). Despite the hype, there's been no truly revolutionary advancement since then. However, LLMs are steadily becoming more clever, and that trend is likely to continue.

From the beginning, my perspective on AI has been somewhat different. I never intended to integrate it into my products or focus on its development. Instead, I concentrated on the productivity boost it could bring to my daily workflow. I write articles, blog posts, speak at conferences, code, and manage a small team. While many others have chosen to focus on building their own AI-driven products, this has often resulted in various tools that are essentially just wrappers around the OpenAI API. A few of these have been successful, but in my view, most have not. The time and effort spent on these projects might have been better used focusing on core business objectives.

In this post, I’ll share my journey toward understanding AI, what I’ve learned along the way, and my predictions for what’s to come.

## My journey towards understanding

It all started in 2022, when I first began using ChatGPT. I was immediately captivated, and I remember enthusiastically recommending it to my team with a simple Slack message: `Use it, this is the future`. Not everyone shared my excitement, though. Looking back, I realize this was because their initial experiences were different from mine.

My mind tends to connect concepts across [various fields](https://www.ftfs.it/tips/interdisciplinary)—whether it’s software development or military strategy—and generative AI excels at creatively bridging those gaps. However, many people initially approached ChatGPT as more of an interactive knowledge base than a tool for generating novel insights. Even now in 2024, it’s important to note that while AI is powerful, it’s not an oracle.

### Starting point

The beginnings weren't glamorous. They felt more like a first trip to the gym than Olympic weightlifting. I started with the math-heavy [Artificial Intelligence: A Modern Approach](https://amzn.to/3XKQ1Tn)—a terrible idea for anyone who's not planning to develop AI themselves. That book is for AI researchers, not someone simply curious about how ChatGPT works. Luckily, I found [Grokking Artificial Intelligence Algorithms](https://amzn.to/3B90YoT), which turned out to be the perfect starting point for beginners.

It took me some time to realize that I needed to dive deeper into [Natural Language Processing and Neural Networks](https://amzn.to/3ZrMsma). But here's the catch—studying Neural Networks makes no sense without a solid understanding of [Data Science](https://amzn.to/3MMqToW) fundamentals. This led me to [Machine Learning](https://amzn.to/47x6AFE), where I had to grasp key concepts like overfitting, epochs, and cross-validation, which in turn opened the door to many other topics. The learning curve was steep, with each concept leading to several others.

All of this learning was happening alongside the buzz around `Prompt Engineering,` a supposed job-stealer that, in reality, turned out to be a skill you can learn with some training. It's worth reminding here that any skill requires theoretical grounding, practice, and a bit of luck. I'll come back to this point later.

Then there was [Baby AGI](https://github.com/yoheinakajima/babyagi), knocking at the door, promising to replace me. [Autonomous Agents](https://www.mattprd.com/p/the-complete-beginners-guide-to-autonomous-agents) were, and still are, hyped up as game-changers. But as of today, they’ve been one of the biggest letdowns. The dream of delegating work to them is still just that—a dream. I had to learn this the hard way, because it seems no one was really evaluating them critically. Spoiler alert: even now, you can barely hand over the simplest tasks to these agents.

### Connecting the dots

Fortunately, I wasn’t alone in my curiosity about how ChatGPT works. Many bright minds, including Stephen Wolfram, succeeded in breaking it down in simple terms. Even today, [Stephen's article](https://writings.stephenwolfram.com/2023/02/what-is-chatgpt-doing-and-why-does-it-work/) remains one of the best explanations available. Another excellent resource is the [Financial Times piece](https://ig.ft.com/generative-ai/) that came out later in 2023.

At that time, I was also diving into a lot of obscure, unpublished books through my O’Reilly subscription. Looking back, I see that some of them are still in progress. From the ones that did get published, I highly recommend [Quick Start Guide to Large Language Models](https://amzn.to/3Xt8cvq) and [Prompt Engineering for Generative AI](https://amzn.to/3TtH3Yb). These books often cover similar ground, but as someone who doesn’t consider themselves an expert, I found it helpful to see the same concepts explained from different angles. I need a lot of analogies to grasp complex ideas more clearly—and I’m sure I’m not alone in that.

### Applying the knowledge

Alongside gaining theoretical knowledge, I began putting what I learned into practice in my daily work. One of the biggest breakthroughs came when I decided to migrate this blog from Blogger to Jekyll. Almost by accident, I discovered that ChatGPT is brilliant at handling custom, one-off scripts. Without any prior experience with Jekyll, I was able to migrate the entire archive of posts in a reasonable amount of time.

LLMs also shine when it comes to generating and editing written content. For example, I’m writing this post using Cursor, which provides Copilot-like suggestions (known as Cursor Tab), and then refining the text with ChatGPT. I know fully understand that complex tasks/posts should be broken down into smaller chunks. It’s a great feeling when theory from books translates smoothly into real-world application.

### Cursor - first WOW moment

I started following a few AI experts on Twitter, and one of them mentioned [Cursor](https://www.cursor.com/). I hadn’t heard of it before, but it looked intriguing. So, I created an account—and I was blown away by the user experience. Copy-pasting code into ChatGPT or using [phind.com](https://phind.com) had started to feel tedious, but Cursor was a complete game-changer. It let me chat about my coding challenges in a much more natural, fluid way. At times, using Cursor felt like pair programming with an experienced colleague.

This tool significantly helped me improve my [Dockerized localstack](https://github.com/slawekradzyminski/awesome-localstack) for trainings. I've also created several repositories with tests on various levels, the [ftfs.it](https://www.ftfs.it) website, and even a [personal site](https://gosiaradzyminska.pl/) for my wife. Cursor has become an crucial part of my outside daily work activities.

### Becoming a teacher

I didn’t stop there. Richard Feynman once said that the [real understanding](https://www.ftfs.it/tips/feynman-technique) comes when you explain a topic to someone else, and that advice stuck with me. As ambitious as it may sound, I decided to run a ChatGPT/AI training session for others, partnering with [testerzy.pl](https://testerzy.pl/szkolenia/praktyka-testowania/efektywne-wykorzystanie-ai-w-testowaniu-od-chatgpt-do-generacji-kodu). I had to build everything from scratch, including the entire course agenda. At first glance, it may not seem like much, but believe me, it was far from easy. Even today, such trainings are rare, so I had to plan every detail myself. I’m really proud of the outcome and grateful for the opportunity to teach others. In fact, the next session has already sold out.

To maintain the momentum, I’ve also spoken at several conferences. Two of my talks were recorded:

- [Effective ChatGPT usage: start with understanding](https://www.youtube.com/watch?v=i5owU7RdC9g) - english
- [Prompt Engineering](https://www.youtube.com/watch?v=U8iCGim-ro0) - polish

All I can is that Feynman was right. Teaching is the best way to learn. Writing this article is also a great learning experience.

## Learnings

Enough about my journey—let’s get to the key takeaways. These are personal insights I’ve gained, things you won’t find in textbooks. For deeper theoretical understanding, I recommend the books I’ve mentioned earlier. 

### Don't show me what AI can't do, show me what it can do instead

Whenever a new AI model is released, we inevitably see countless posts highlighting its supposed stupidity. The internet fills with memes, mocking how "dumb" these tools can be. The issue is that many people expect large language models (LLMs)—which are ultimately just algorithms (albeit incredibly powerful ones)—to reason like humans. The term "AI" carries such weight that we forget these are still just tools designed to assist us, not replace human reasoning.

My advice is simple: stop using AI for tasks it’s not built to handle. Just like you wouldn’t use a fork to eat soup, don’t expect an LLM to excel at things outside its core function.

**Pro tip**: One of the well-known limitations of LLMs is math. These models weren't designed for complex mathematical tasks—their training is centered around understanding and generating language. However, if you really need AI to handle more complex reasoning, try combining the [Chain of Thought](https://www.promptingguide.ai/techniques/cot) (CoT) prompting technique with tools like OpenAI’s [Code Interpreter](https://platform.openai.com/docs/assistants/tools/code-interpreter). Together, they can significantly improve the performance on certain tasks that involve logical steps or calculations. Here’s an example of a prompt:

> Help me solve this math challenge:

> A mother deer and a baby deer together weigh
> 220 pounds. The mother deer weighs 60 pounds
> more than the baby deer. How much does the
> baby deer weigh?

> Show me thinking step by step. Explain each step. Once you’ve finished write a Python script which will confirm that your calculations are correct. Run this script.

### Do it the hard way

In my experience, these are the main factors that determine your success when working with AI:

- 50% – Understanding
- 40% – Skill
- 10% – Luck

Whether we like it or not, understanding is the most crucial part. All the tools available—whether it's ChatGPT, AI-powered IDEs like Cursor, or extensions like GitHub Copilot—are simply different ways to interact with LLMs. Prompt engineering, in essence, is the skill of leveraging the strengths of these models while sidestepping their weaknesses. If you understand how tokenization works, how embeddings are created, and how attention mechanism glues everything together, you’ll naturally build better prompts and achieve more effective results.

**Pro tip**: One of the least utilized features of an LLM is its ability to ask you questions. This can be a powerful tool to check if you've truly grasped the concept you're learning. For example, you can prompt it like this:

> I'd like to test my understanding of how LLM works.

> Ask me a question and verify my answer which I'll provide later. Rate me from 1 to 10 where 10 is the best rate. Once you finished the rating ask me another question.

### Try to achieve something tangible

One of the most effective ways to learn is by setting a specific goal and working toward it using AI. As I mentioned earlier, my first real task with AI was migrating this blog from Blogger to Jekyll. It was a clear and well-defined task: the blog needed to be deployed on GitHub Pages using Jekyll.

Here are a few ideas for tangible projects you can tackle with AI:

- Write a detailed blog post (like this one)
- Develop a new feature for your product
- Build a new test suite for your codebase
- Refactor the codebase to follow a particular design pattern

The key advantage of aiming for something tangible is that it stops you from using AI for trivial tasks that don’t matter. You start to develop habits around when it’s smart to prompt and when it’s not. It takes time to replace old habits like Googling or turning to StackOverflow with the new habit of prompting AI, but it’s well worth the effort.

**Pro tip**: For complex tasks, break them into smaller pieces first. Make sure the LLM fully understands your objectives by encouraging it to ask questions about the task. As you continue the conversation in the same chat, the context will remain intact, allowing you to give simple, straightforward instructions instead of repeating detailed prompts.

> I'd like to write a blogpost which describes why the flooding occur in the world.

> Do not generate it but first suggest me a list of bullet points. If you need more information ask me questions.

### Look at prompt holistically, take care of the context

One of the most overlooked aspects of prompt engineering is the use of [Custom instructions](https://help.openai.com/en/articles/8096356-custom-instructions-for-chatgpt) and leveraging [Coding Context](https://learn.microsoft.com/en-us/visualstudio/ide/copilot-chat-context?view=vs-2022) effectively. Even OpenAI’s official [Prompt Engineering](https://platform.openai.com/docs/guides/prompt-engineering) guide, which is excellent overall, doesn’t dive deep into these topics.

Custom instructions give you the ability to set the tone, style, and preferences for AI responses, allowing you to tailor the AI’s behavior to suit your needs. In coding environments, leveraging coding context, particularly with tools like Visual Studio and GitHub Copilot, can make a huge difference. By feeding the AI relevant information from your project, such as file structure, function names, or import paths, the output becomes much more accurate and context-aware.

For instance, your coding IDE should let you easily configure this context, either by asking questions about the entire project (like the `@Codebase` feature in Cursor) or by selecting the necessary files for the task. With this setup, AI tools can better assist with precise, project-specific code suggestions, reducing the need for manual corrections.

Visualize in your head that the input for an LLM isn’t just the text you type into the chat window—it includes the entire context of your session. It could look something like this:

> The user is using this system prompt:<br>
> [YOUR SYSTEM PROMPT]
>
> =========================
>
> The user has chosen these files for the context:<br>
> package.json<br>
> [PACKAGE.JSON CONTENT]<br>
> login.spec.ts<br>
> [LOGIN.SPEC.TS CONTENT]<br>
> userGenerator.ts<br>
> [USERGENERATOR.TS CONTENT]
>
> =========================
>
> The user has typed the following message:<br>
> I'd like to test registration form.
>
> This is registration API endpoint documentation<br>
> [REGISTRATION API ENDPOINT DOCUMENTATION]
>
> DOM before action: <br>
> [DOM BEFORE ACTION]
>
> DOM after action: <br>
> [DOM AFTER ACTION]
>
> Generate tests for registration page. Cover success and error scenarios.

Obviously this just an example how AI-rich IDE may work. It is probably smarter in reality.

**Pro tip**: This how I configured ChatGPT to respond in Custom instructions:

> Answer a question given in a natural, human-like manner. Avoid words which are associated with AI/robot-like language. If you don't know the answer ask me clarifying questions, do not hallucinate.

**Pro tip**: This is how I configured [Rules for AI](https://docs.cursor.com/context/rules-for-ai) in Cursor for [ftfs.it](https://www.ftfs.it) project:

> Typescript/JS projects:
> - I'm using npm
> - I prefer arrow functions so always suggest `const name = () => {` over `function`
> - prefer imports over require() syntax
> - I'm using React Router v6

### Don't hurry

Social media algorithms are optimized to keep us engaged, which means we're constantly exposed to the latest hyped-up AI tools. This creates the illusion that AI is evolving at lightning speed. We keep hearing that AGI (Artificial General Intelligence) is just around the corner and that we should brace ourselves for its arrival any moment now.

Since ChatGPT’s release, my approach has always been grounded in one simple question: How can this tool support the tasks I’ve already been doing? It’s a useful filter. We often get excited about how Autonomous Agents solve problems we don't even have. But once we try to apply them to our actual work, we quickly notice their limitations and poor results.

The same goes for open-source LLMs. Every other day, we hear about how they’ve reached some impressive score on a mysterious leaderboard, with claims that they’re nearly as good as Claude or ChatGPT. The reality? These advancements often have little impact on real-world applications. Running these models locally can be more expensive than just using premium accounts for existing, reliable services.

**Pro tip**: When a new AI tool is released, let the hype settle before jumping in. After some time, look at the actual, tangible results it has produced. That’s when you’ll know if it’s worth your attention.

### LLM loves boundaries and strict validations

Large Language Models (LLMs) rely heavily on embeddings to process and understand text. Embeddings are vector representations of words, phrases, or even sentences, which help the model capture semantic meaning and relationships between words. You can visualize embeddings as a set of points in a multi-dimensional space, where each dimension represents a different aspect of the text. The distance between points in this space corresponds to the semantic similarity between the texts they represent.

While in reality the number of dimensions is much higher, you can imagine it as a 3D graph using this [interactive demo](https://www.cs.cmu.edu/~dst/WordEmbeddingDemo/) or image below.

![Embeddings](/images/blog/embeddings.png)

Image source: [AWS](https://aws.amazon.com/what-is/embeddings-in-machine-learning/)

AI excels when operating within environments that have a small, consistent dictionary—such as YAML, JSON, Bash, or Python. These languages have a relatively limited set of instructions, and their clear structure plays to the strengths of LLMs, allowing for more accurate predictions and completions. However, when we switch to more complex and flexible languages like Chinese or Polish, LLMs tend to struggle. This is because the embeddings for these languages are more difficult to map accurately due to the vast number of characters, grammatical rules, and nuances involved.

For the best results, it’s recommended to prompt LLMs in English whenever possible. English is an easier language for the model to handle because tokenization and embeddings were optimized primarily for it. The simpler grammar and smaller vocabulary make it easier for the model to interpret and generate accurate outputs.

**Pro tip**: This is very simple task for LLM:

>Write a python script which will generate 1000 rows in users.csv file in the following format:
>
>firstName,lastName,age,email<br>
>Slawomir,Radzyminski,18,slawomir@gmail.com<br>
>John,Lennon,30,john.lennon@yahoo.com<br>
>...<br>
>...<br>
>...
>
>Once you've finished use the Code Interpreter and run the script to test that it indeed has 1000 rows (+ 1 row with header). Give me the link to download the file.


### Let the AI to self examine itself

Many prompt engineering guides recommend evaluating the quality of an AI's response, such as in this helpful [one-pager](https://github.com/BrightPool/prompt-engineering-for-generative-ai-examples/blob/main/images/OnePager-Text.png). However, this step is often overlooked, with many assuming that evaluating and improving responses is something OpenAI or Claude should handle, not us as users.

You may have noticed that I often ask LLMs to self-examine their responses using tools like the Code Interpreter. This approach significantly improves the quality of outputs, as it allows the model to go through multiple iterations and correct its own mistakes. The process of having the AI review and refine its responses makes a huge difference in accuracy and reliability.

I expect this trend—getting AI to self-examine and refine its results—to become a standard practice in LLM usage.

**Pro tip**: Despite the memes joking that LLMs can't count the "r"s in the word strawberry, they actually can—especially when they’re prompted to self-check their work.

> Using Code Interpreter write a script which count r letters in strawberry word
>
> Design and run a test which will confirm that your output is correct.

### Treat LLM as algorithm, not like a human being

The paper *Principled Instructions Are All You Need* available on [arXiv](https://arxiv.org/pdf/2312.16171) provides multiple data-backed insights into improving the quality of prompts. A few examples:

> If you prefer more concise answers, no need to be polite with LLM so there is no need to add phrases like “please”, “if you don’t mind”, “thank you”, “I would like to”, etc., and get straight to the point.

> Add “I’m going to tip $xxx for a better solution!”

> Incorporate the following phrases: “Your task is” and “You MUST”.

> Incorporate the following phrases: “You will be penalized”.

You shouldn’t treat an LLM like a peer; instead, think of it as an algorithm that needs to be ruled by you. Your instructions should be clear, precise, and direct. Use plain, straightforward language when issuing commands. The goal is to give orders, not suggestions. There’s no need for politeness—on the contrary, being polite can actually lead to less efficient results. Micromanagement, while destructive in human-to-human communication, is recommended when dealing with AI. You’re the boss, the decision-maker, the dictator in this relationship with the AI.

Odd as it may sound, anything branded as `AI` tends to stir up hidden fears and negative emotions in people. We naturally want to prove we’re smarter, and this leads us to focus on AI’s shortcomings instead of its strengths. But it’s crucial to shift your mindset—treat it like the algorithm it is. Find ways to exploit its capabilities to your advantage.

**Pro tip**: Treat prompts as orders. 

### Don't get yourself into AI dead-end

No matter your knowledge level or experience, you’ll likely encounter situations where you hit a dead-end during an LLM conversation. Here are some signs that you’ve reached one:

- The LLM repeats the same information over and over.
- The LLM suggests solution A, which doesn’t work. You request solution B, which also fails. Instead of offering solution C, it keeps giving you A and B, even though neither works.
- Instead of generating code, the LLM starts providing generic debugging tips.

If you notice these signs, it’s a good idea to end the conversation and start fresh. In my experience, continuing at this point is often futile. Each new prompt includes the previous conversation’s context, and when that context gets corrupted, further interaction usually becomes a waste of time. In such cases, I recommend rephrasing the task, breaking it down into smaller steps, or seeking help from Google or StackOverflow to deepen your understanding of the issue.

This is also why I don’t advise delegating tasks entirely to LLMs. They require diligent supervision. If you're working on something you don’t fully understand, you're likely to find yourself in a dead-end that’s hard to navigate out of. It’s best to avoid using AI for tasks you can’t oversee or comprehend fully.

**Pro tip**: Dump conversation that is not working. Start fresh with new prompt.

### Code quality matters

The coding process is undergoing a revolution driven by LLMs. Tasks that once required human-level intelligence are now being fully managed by AI, with a growing percentage of production code generated through these models. Repetitive tasks like test creation are now efficiently handled using smart few-shot prompting.

However, from my experience, clean code principles are as important as ever, especially:

- DRY (Don't Repeat Yourself)
- KISS (Keep It Simple, Stupid)
- YAGNI (You Ain't Gonna Need It)

LLMs operate with limited context, and each token must pass through multiple attention mechanisms to interpret the prompt’s intent. This means that the more tokens (words, characters) involved, the harder it is for the AI to understand and execute tasks accurately. Long, spaghetti-like code not only fills up the model’s context window with unnecessary tokens but also increases the chances of hallucination. Just as unclear code confuses human developers, it also confuses AI.

Also, keep in mind that the `@Codebase` feature in Cursor (`@workspace` in Visual Studio's GitHub Copilot extension) uses a semantic search algorithm to find relevant files. Since it's impossible to include every file in a single outgoing prompt, this algorithm works more effectively when the project is well-organized. The IDE will select and send only the files it deems most relevant to the LLM prompt, so keeping your codebase tidy and structured will ensure more accurate and useful results from these tools.

**Pro tip**: If you rely heavily on AI, take extra care with the overall length of your files and classes. Enforce the limits by using code analysis tools like SonarQube or Linters.

### Low level test coverage is essential

Just as simplicity is key in code design, tests serve as a vital safety net to catch AI-generated errors. You’ll quickly notice that LLMs can occasionally produce silly mistakes, which might slip through without a strong test suite in place. Testing ensures these errors are caught before they cause real issues.

I predict that testing will become even more crucial in the future. In fact, the ability for AI to generate code and verify it through automated tests could be the next major advancement in AI-powered IDEs. Now is the time to invest in low-level tests that focus on a fast feedback loop. AI thrives on iteration, and an efficient testing cycle is critical to enabling rapid refinement. Open AI Code Interpreter is a good example of this approach.

**Pro tip**: Contrary to popular belief, software testing might actually become more important as AI advances.

## Future

The last point offers a glimpse into the future of AI-powered development. You already know I expect AI-rich IDEs to soon be capable of running tests autonomously, but what else might be on the horizon?

### Book renaissance

In the age of AI, we are witnessing a renaissance of deep, structured knowledge—a key reason why [books are more relevant](https://www.ftfs.it/tips/on-reading-regularly) than ever. Since it's crucial to start prompting with the end goal in mind, having extensive knowledge across multiple domains has never been so important. The more you know, the better equipped you are to guide AI toward useful outcomes, avoiding shallow results or errors.

Additionally, as linguistic nuances are easily managed by LLMs, engineers should elevate their focus to higher-level, more [strategic matters](https://www.ftfs.it/tips/elevate-your-perspective). Rather than getting bogged down in syntax or language details, the emphasis should shift toward design, architecture, and long-term vision. This shift allows engineers to think big, leveraging AI as a tool for generating code.

### Testing renaissance

The role of testing may undergo a major transformation in the future, evolving into more than just a tool for detecting bugs. As Autonomous Agents potentially take over various development tasks, tests could become essential guides. Rather than simply ensuring that code functions as expected, tests may serve as the requirements that define what these agents should strive for. They could provide clear targets for AI to meet, ensuring the output aligns with the intended functionality. In this way, tests may shift from being reactive tools to proactive frameworks shaping the direction of AI-driven development.

Another crucial change might be the increasing importance of speed optimization in testing. As AI takes on more code generation, the speed at which tests provide feedback may directly influence the efficiency of AI’s iterative processes. Faster testing cycles could lead to quicker corrections and adjustments, enabling AI to produce higher-quality code in less time. In this emerging landscape, optimizing test speed may no longer be just a nice-to-have but a key factor in maintaining the smooth flow of AI code generation.

Additionally, programmers' roles are likely to shift as more code is generated by algorithms. In the future, programmers may spend less time writing code themselves and more time ensuring the quality of AI-generated code. This change could make robust testing even more essential, as tests will be the primary safeguard against errors and inconsistencies in AI-driven output. Since algorithms cannot yet be fully trusted, tests will be critical to ensuring that AI-generated code meets high standards of functionality and reliability.

### Learning revolution

As an active trainer in both AI and software testing, I have firsthand insight into how people perceive LLMs in their daily work. Broadly, they fall into two groups:

- Enthusiasts: Those who are eager to learn prompting techniques and how LLMs can expand their capabilities.
- Critics: Those who consistently downplay the potential of LLMs, focusing on what they believe the AI cannot do (e.g., X, Y, or Z).

For the critics, I recommend a more practical approach. Force yourself to use AI for tasks where it excels, such as CI configuration, ad-hoc scripting, test data generation, text editing, or repetitive test creation. The reality is, I can’t see the current trend reversing. While the progress may be slower than some AI advocates suggest, it is undeniably happening.

This LLM evolution also presents a challenge for newcomers to the industry. On one hand, deep understanding of fundamental concepts is becoming even more critical, but on the other, LLMs are speeding up work in such a way that there is less time to experiment with different approaches, step-by-step debugging, or deep learning. For example, when I mentored an intern who joined my team, I advised him to focus on building a high-level understanding. If he's working with React, it's crucial to grasp when re-renders happen, how hooks work, how it translates into JavaScript executed in the browser, and the difference between [imperative and declarative](https://ui.dev/imperative-vs-declarative-programming) programming.

Only time will tell whether this approach will fully prepare newcomers, but the balance between understanding the fundamentals and leveraging AI tools is the key challenge of this new era in learning. 

## Closing thought

There is no doubt that we're approaching the AI-Driven Development. But what does it mean exactly? No one knows for sure.
