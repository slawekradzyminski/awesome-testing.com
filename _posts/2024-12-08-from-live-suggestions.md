---
title: "From Live Suggestions to Agents: Exploring AI-Powered IDEs"
layout: post
permalink: /2024/12/from-live-suggestions-to-agents-exploring-ai-powered-ides
categories:
  - AI
tags:
  - AI
---

![](/images/blog/aiide.jpg){:width="50%"}

Among the many AI tools that have been released in the last two years, the coding IDE is one of the most powerful. It's a tool that can help developers write code faster and more efficiently. In this post I'll explain what an AI-powered IDE is, and how to evaluate it. You may be surprised to learn that it's not just a chat-based tool, but a combination of several different technologies that work together to help you write code faster.

To keep this exploration engaging and interesting, I'll break down the underlying mechanics of these tools without overwhelming you with technical jargon. Instead, I’ll use straightforward explanations and analogies. If you're interested in the details I suggest to take a look into soon-to-be-released [AI Engineering book](https://www.amazon.com/AI-Engineering-Building-Applications-Foundation/dp/1098166302). I had the privilege to read an early version on [O'Reilly's website](https://learning.oreilly.com/library/view/ai-engineering/9781098166298/).

To work effectively with AI-powered IDEs, it's essential to first become familiar with:
- How Large Language Models (LLMs) work: Understanding their capabilities, limitations, and how they process information.
- Prompt Engineering Techniques: Crafting effective prompts to get the most out of AI-powered tools.

I've covered these topics in my [previous post](https://www.awesome-testing.com/2024/09/the-rise-of-ai-driven-development) where I share recommended resources and practical tips to help you get started.

AI-powered IDEs have become a significant presence in the software development landscape, highlighted extensively in the latest ThoughtWorks Technology Radar under categories such as:

- [LLM bans (Hold)](https://www.thoughtworks.com/radar/techniques/summary/llm-bans)
- [Replacing pair programming with AI (Hold)](https://www.thoughtworks.com/radar/techniques/summary/replacing-pair-programming-with-ai)
- [Complacency with AI-generated code (Hold)](https://www.thoughtworks.com/radar/techniques/summary/complacency-with-ai-generated-code)
- [RAG (Adopt)](https://www.thoughtworks.com/radar/techniques/summary/retrieval-augmented-generation-rag)
- [LLM-powered autonomous agents (Adopt)](https://www.thoughtworks.com/radar/techniques/summary/llm-powered-autonomous-agents)
- [Function Calling with LLMs (Trial)](https://www.thoughtworks.com/radar/techniques/summary/function-calling-with-llms)

If you’re not yet using these tools, consider discussing their potential with your managers. You might share resources like ThoughtWorks’ perspective on [LLM bans](https://www.thoughtworks.com/radar/techniques/summary/llm-bans) or even this article to emphasize their importance. As I’ve mentioned in my [previous post](https://www.awesome-testing.com/2024/09/the-rise-of-ai-driven-development), these tools are continuously improving, and early adoption can help you and your team stay ahead.

In this post, I’ll evaluate AI-powered IDEs based on the following criteria:

- “Live” code suggestions
- LLM Chat integration with the IDE
- RAG performance boost
- Agent performance boost

_Note: All screenshots were taken in Cursor IDE using my naive RAG implementation [personal-ai-assistant](https://github.com/slawekradzyminski/personal-ai-assistant)._

## “Live” code suggestions

The first significant release branded as an AI coding game-changer was Google Copilot's in-line code suggestions. While relatively simple, this feature was groundbreaking at the time. The idea was that, instead of manually writing code, AI could suggest code snippets for you. You could then choose to apply the suggestion (usually by pressing `Tab`) or continue typing as you preferred.

![](/images/blog/codesuggestion.png){:width="50%"}

At that time, the most advanced model powering these suggestions was GPT-3 Codex, which is now considered obsolete. The hype around Copilot was immense, but its actual performance often fell short of expectations. Users frequently had to insert artificial comments into their code to make the suggestions more accurate. Without detailed code context, Copilot struggled to provide meaningful suggestions, often producing outputs only marginally better than random guesses.

One of GitHub Copilot’s biggest selling point is its integration into the most popular IDEs (VSCode plugin, Intellij plugin, etc.). This makes it incredibly easy to get started. Convincing developers to switch to a new IDE (like Windsurf) is a challenging proposition. Developers are creatures of habit, and most are not early adopters, making adoption of new tools slower.

However, incorporating GitHub Copilot into existing IDEs still presents challenges. When using Copilot, some built-in suggestions from the IDE itself may become unavailable. Considering that Copilot’s suggestions are not always accurate, this can be frustrating for developers who have to switch between Copilot and the IDE’s native autocomplete features.

Copilot competitors attempt to resolve some of these issues by introducing innovations such as:

- **Indexing the codebase for more accurate suggestions**: Competitor tools often enable the IDE to generate a project prompt for LLM queries, ensuring suggestions are more aligned with the specific project context.

- **Using confidence thresholds for suggestions**: For instance, Cursor Tab (a GitHub Copilot competitor) likely incorporates a confidence score in its backend. Suggestions are only displayed when they surpass a certain threshold, ensuring that the ones you do see are generally reliable.

- **Providing suggestions across the entire file**: Instead of limiting suggestions to the mouse cursor's position, competitors offer context-aware recommendations for the whole file. This enhances productivity by speeding up repetitive tasks.

- **Designing new IDEs for seamless integration**: Building a dedicated IDE from scratch helps resolve many UX issues that arise when Copilot competes with an IDE’s built-in autocomplete functionality.

While using live suggestions it is important to have these things in mind:

- **Your code is exposed to the LLM**: Even if you don’t apply suggestions or use chat features, your code is still shared with a third party. Your IDE sends prompts to the LLM in real-time to generate suggestions. This means you cannot use tools like Copilot if you’re working on proprietary or sensitive code. It also means that at work you have to obtain approval from your manager before using these tools.

- **Fast Inference is Crucial for User Experience**: The LLM powering “live” coding assistants must respond quickly to ensure a smooth user experience. Ideally, it should be as fast as the native autocomplete feature in the IDE. To achieve this, tools like Copilot often use smaller, less computationally intensive models compared to those used in products like ChatGPT. For example, models designed for deep reasoning (such as OpenAI's `o1-family`) are too slow for this use case.

- **Smart Models Can Be Expensive**: If your IDE extensions rely on an API key and use advanced models (e.g., GPT-4), you could rack up significant costs. It’s essential to monitor usage and configure settings wisely to avoid unexpectedly high bills.

With this in mind, let’s explore and attempt to handcraft a prompt that an IDE coding assistant might use.

> The user is a developer working on Python project called `personal-ai-assistant`. It is a simple RAG implementation that uses LLM and user-provided resources to answer questions.
>
> ========
>
> The user is currently working on the `input_reader.py` file with the following implementation:

```python
import os
import re
import validators

from app.youtube_url_downloader import download_audio
from modals.audio_processor import process_audio
from modals.doc_processor import process_doc
from modals.epub_processor import process_epub
from modals.pdf_processor import process_pdf
from modals.txt_processor import process_txt
from modals.url_processor import process_url

def extract_text(path):
    suffix = os.path.splitext(path)[-1].lower()

    if validators.url(path):
        text = _process_url_input(path)
    else:
        process_map = {
            ".epub": process_epub,
            ".pdf": process_pdf,
            ".doc": process_doc,
            ".docx": process_doc,
            ".txt": process_txt,
            ".wav": process_audio,
            ".mp3": process_audio,
            ".m4a": process_audio

        }

        processor = process_map.get(suffix, _unsupported_file_type)
        text = processor(path)

    text = " ".join(text.split())
    return text

def _process_url_input(url: str) -> str:
    if _is_youtube_url(url):
        audio_path = download_audio(url)
        return process_audio(audio_path)
    return process_url(url)

def _is_youtube_url(url: str) -> bool:
    youtube_pattern = re.compile(
        r'^((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?$'
    )
    return bool(youtube_pattern.match(url))

def _unsupported_file_type(_):
    raise ValueError("Invalid document path!")
```

> ========
>
> The recently implemented function is in `audio_processor.py` file.

```python
def process_audio(path):
    print('Transcripting the audio file...')

    if not os.path.exists(path):
        raise FileNotFoundError(f"Audio file not found: {path}")

    file_size = os.path.getsize(path)
    whisper_api_size_limit = 25 * 1024 * 1024

    if file_size > whisper_api_size_limit:
        print('File is bigger than 25MB. Processing in chunks')
        transcript = process_large_audio(path)
    else:
        transcript = api_get_transcript(path)

    return transcript
```

> ========
> The user pressed `Enter` on line 27 and is currently typing on line 28.
>
> ========
> Suggest possible additional lines to be added on line 28. Rate each suggestions with probability score from 0 to 1.

## LLM Chat integration with the IDE

The optimization of "Live" suggestion models for speed often comes at the expense of quality. These models prioritize rapid responses, which makes them less capable of delivering the depth and precision offered by the newer generation of LLM chat models.

Before chat features became available in AI-powered IDEs, developers often relied on external tools to describe their challenges through prompts. They would then manually copy the responses into their code. While this approach worked, it was inefficient and disrupted the natural coding flow.

This limitation inspired the development of new AI-enhanced IDE tools, which integrate cutting-edge LLM chat models directly into the development environment. These tools eliminate the need to switch context, allowing developers to query the model, receive detailed answers, and integrate them seamlessly into their codebase—all within the IDE itself.

![](/images/blog/aiide.png){:width="100%"}

You can use the following criteria to evaluate the performance of the chat integration:

- **Ability to pick a model**: At the time of writing, many developers prefer using the `claude-3-5-sonnet` model for ad-hoc queries due to its balance of speed and utility. For more complex tasks, the `o1-family` models, equipped with built-in Chain-of-Thought prompting, often provide better results. The ability to select a model is crucial, especially during peak hours or downtimes when certain models may be unavailable or unreliable. It’s worth noting that most AI tool providers do not guarantee SLAs for their models, making this flexibility even more important.

- **Ability to use your API key**: Some tools allow users to integrate their own API keys. While this can improve reliability and uptime, it may also lead to increased costs. It’s vital to monitor usage closely to avoid unexpected expenses.

- **Ease of applying code suggestions**: Applying suggestions should be straightforward—ideally achievable with a single click. The IDE should intelligently determine where the suggestion should be applied and manage any necessary modifications or deletions. A user interface resembling a Git conflict resolution screen, with options to apply, discard, or modify each suggestion individually, provides an optimal experience.

- **Ease of creating new files**: Creating new files should be just as simple, requiring minimal effort from the developer. The IDE should automatically determine the appropriate location for the new file based on the context. This is especially critical for reducing errors in file management and ensuring a smooth user experience.

- **Ease of code error debugging**: The IDE should be capable of constructing prompts that describe encountered errors and querying the LLM for potential fixes. This integration streamlines error resolution, reducing manual effort for the developer.

![](/images/blog/errordebug.png){:width="100%"}

- **Ease of terminal error debugging**: Similar to code error debugging, the IDE should assist with terminal error resolution. The tool should construct and query prompts to resolve the issue causing a terminal command to fail. Note that the root cause here may be in code or in the terminal command itself.

![](/images/blog/terminalerrordebug.png){:width="100%"}

- **Ability to inspect raw prompt and LLM response**: A bit of wishful thinking here, but it would be great if the IDE allowed developers to inspect the raw prompt used to generate a response as well as the LLM response. This can be useful for debugging and understanding how IDE uses LLM under the hood.

- **Ability to use test suite as feedback loop for LLM responses**: GitHub Copilot started testing the possibility of using test suites as a feedback loop for LLM responses. It still has a long way to go, but it's a promising area. Usually AI works best when it can iteratively improve its responses based on feedback. In this case, test suites would provide such feedback.

## RAG performance boost

Retrieval-Augmented Generation (RAG) is a technique that enhances the capabilities of large language models (LLMs) by incorporating external knowledge into their response generation process. While LLMs are powerful, their knowledge is static, limited to the data they were trained on, and unable to handle recent or project-specific information. RAG addresses these limitations by dynamically retrieving relevant, up-to-date information from an external database, which is then combined with the user’s prompt before being fed into the model.

![](/images/blog/RAG.png){:width="100%"}

The image above illustrates how RAG works:

- **User Prompt**: The process begins with a user providing a prompt, such as a query or a specific task they need assistance with.

- **Similarity Search in Vector Database**: The prompt is analyzed, and a similarity search is conducted in a Vector Database, which contains encoded representations of up-to-date knowledge. This database enables the system to quickly identify and retrieve relevant pieces of information that are most similar to the user’s query.

- **Constructing the RAG-Enhanced Prompt**: The extracted knowledge from the vector database is combined with the original user prompt to create a RAG-enhanced prompt. This ensures that the LLM receives both the user’s request and the contextual knowledge needed to provide a more accurate and relevant response.

- **Response Generation by the LLM**: Finally, the RAG-enhanced prompt is sent to the LLM, which generates a response using both its internal knowledge and the external context provided by the RAG process.

*You can find the simplest RAG implementation in my [personal-ai-assistant](https://github.com/slawekradzyminski/personal-ai-assistant) project.*

The primary benefit of using RAG is its ability to provide LLMs with access to up-to-date information, leading to more accurate and contextually relevant responses. This is particularly crucial for developers who often need to work with the latest tools and technologies. For example, [React 19](https://react.dev/blog/2024/12/05/react-19) was released in December 2024, introducing new features and syntax that developers need to adopt. Traditional LLMs, trained before this release, lack knowledge of React 19. However, with RAG, an IDE can dynamically retrieve the latest information and provide accurate suggestions for the updated syntax or new features.

By the way, I recommend to inform the LLM about the specific version of a tool or library being used through a system prompt. This ensures greater accuracy in its responses.

Given the importance of RAG, you can evaluate the following criteria when choosing an IDE:

- **Ability to attach files from the project**: When using LLM chat, the currently opened file is often automatically included in the prompt. However, the IDE should provide an easy way to attach additional files from the project to extend the context of the query.

- **Ability to attach project context**: The IDE should support chatting with the entire project context (e.g., `@workspace` in GitHub Copilot’s VSCode plugin). In this mode, the IDE selects relevant files to include in the prompt automatically. The effectiveness of this feature depends heavily on code quality and project size.

- **Multi-modality support**: With advancements in LLMs, it’s now possible to use various input types, such as images, audio, and documents, in prompts. The IDE should allow users to attach files in these modalities, converting them into text before querying the LLM. For example, tools like [LangChain](https://python.langchain.com/docs/integrations/document_loaders/) offer document loaders that can easily integrate into an IDE to process non-textual inputs.

- **Ability to index tool documentation**: The IDE should support a built-in Vector Database to index documentation for commonly used tools like React, Python, or others. For instance, prompting with `@OpenAI` could retrieve relevant, pre-indexed documentation that matches the query, streamlining the development process.

- **Ability to parse URLs**: The IDE should allow users to attach URLs in the chat interface, automatically retrieving and parsing the content of those URLs to include in the prompt.

- **Transparency of what is used for RAG**: The IDE should make it clear what context is being used for RAG. This includes displaying the files, URLs, or other data sources that have been attached to the prompt. Transparency helps developers understand the model's responses and trust its output.

## Agent performance boost

In my [previous post about AI](https://www.awesome-testing.com/2024/09/the-rise-of-ai-driven-development) I mentioned that *autonomous* agents failed to fully deliver on their promises. However, *cooperative* agents working under close supervision of a human are a new promising and exciting area. 

In [SWE-agent paper](https://arxiv.org/pdf/2405.15793) we can find the following illustration and definition of an agent (please note that the author uses term *language model (LM)* instead of *large language model*):

![](/images/blog/sweagent.png){:width="100%"}

An agent refers to a system that leverages a language model (LM) to autonomously interact with a digital environment, such as a computer, to solve tasks. The agent operates by iteratively taking actions (e.g., running commands, editing files) and receiving feedback from the environment to adjust its behavior.

The interface between the LM agent and the computer is crucial. It provides the tools and commands the agent can use, along with the feedback format from the system. ACIs are specifically designed to enhance LM agents' efficiency by streamlining tasks such as searching, editing, and executing commands in digital environments.

Agents can perform complex tasks like creating and editing code files, navigating repositories, and executing programs.They utilize guardrails to minimize errors (e.g., syntax checking during code edits) and provide detailed feedback to enhance iterative improvements.

With that in mind, you can evaluate the following criteria when choosing an AI-powered IDE:

- **Ability to generate project boilerplate**: The IDE agent should have the capability to generate boilerplate code for a project based on a high-level description/prompt (e.g., a Java 21 backend API with Spring Boot and Gradle). The concept is inspired by tools like [Vercel v0](https://v0.dev/), which simplify project initialization with automated scaffolding.

- **Ability to modify/edit/delete multiple files at once**: Similar to single-file code suggestions, the agent should be able to apply changes across multiple files simultaneously. Transparency is critical—developers should be able to see which files are being modified. Ideally, the IDE should provide a Git-like diff view, allowing users to review, accept, or reject changes with ease.

![](/images/blog/composer.png){:width="100%"}

- **Ability to execute commands in terminal**: The agent should support executing terminal commands (e.g., `pytest`) and acting on the results. It should be capable of crafting appropriate commands based on instructions given in natural language, bridging the gap between human intent and precise terminal actions.

- **Ability to search for data on the Internet**: To provide more accurate and context-aware responses, the agent should be able to search the Internet for relevant information. This feature extends the capabilities of RAG by dynamically retrieving external knowledge, ensuring the agent remains effective even when faced with tasks outside its preloaded context.

## Players

In this post, I intentionally refrained from explicitly recommending any specific tools. The reason is simple: the best tool for the job depends on the unique needs of the project and the developer's personal preferences. That said, there are a few tools I believe are worth exploring:

- [Cursor](https://www.cursor.com/)
- [Zed](https://zed.dev/)
- [Windsurf](https://codeium.com/)
- [GitHub Copilot](https://github.com/features/copilot)

For a deeper dive, I highly recommend checking out the excellent Pragmatic Engineer [post about AI IDEs](https://blog.pragmaticengineer.com/ide-that-software-engineers-love/).

![](/images/blog/pragmatic.png){:width="60%"}

With the rapid pace of innovation in this field, we can expect even more tools and features to emerge. Major investments from big players signal a bright future for AI-powered IDEs, making it an exciting time to explore and adopt these technologies.

## Conclusion

AI-powered IDEs are reshaping how we approach software development, combining speed, efficiency, and contextual awareness to create smarter workflows. From live suggestions and RAG integration to chat-based support and agents, these tools are designed to enhance every stage of the development process. We are entering the era of AI-Driven Development.
