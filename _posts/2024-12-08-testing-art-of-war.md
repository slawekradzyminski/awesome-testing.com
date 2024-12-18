---
title: "Testing Art of War"
layout: post
permalink: /2024/12/testing-art-of-war
categories:
  - Testing thoughts
tags:
  - testing thoughts
---

![](/images/blog/slav.jpg){:width="100%"}

Last month, I had the incredible opportunity to speak at the TestWarez conference, a highlight event for software testing professionals. Sharing ideas with such a vibrant and knowledgeable community was both an honor and a pleasure. The energy, the passion, and the wealth of insights exchanged during the conference left me inspired.

In my talk, titled "Testing Art of War", I drew inspiration from the timeless wisdom of Sun Tzu’s Art of War. The parallels between strategic warfare and software testing might not seem obvious at first, but the more you think about it, the more it makes sense. Testing, much like strategy, is about adaptability, foresight, and precision.

During my session, I shared 10 recommendations based on these principles—each aimed at helping testers not only refine their craft but also think more strategically in their day-to-day work. In this post, I’d like to revisit those tips and explore them further, offering practical advice for how you can incorporate them into your testing practice.

Whether you’re a seasoned tester or just starting out, I hope you’ll find these insights as valuable as I do.

## #1 Shapelessness

In Sun Tzu’s Art of War, one of the key concepts is to remain "shapeless," adapting to the situation rather than following a rigid plan. This principle is just as relevant in software testing as it is in warfare.

Being shapeless means avoiding the trap of sticking to a fixed mindset or approach. Testing environments are rarely static—they evolve with new requirements, unexpected bugs, and changing user behaviors. As testers, our strength lies in our ability to adapt to these changes and respond to the unique demands of each situation.

In my presentation, I referenced a quote: "When you meet a swordsman, draw your sword. Do not recite poetry to one who is not a poet." This is a reminder to approach challenges with the right tools and mindset. If a particular testing strategy isn’t yielding results, don’t be afraid to pivot, experiment, and explore alternatives.

For instance, in a recent project, I encountered a situation where our existing automated tests weren’t covering edge cases effectively. Instead of forcing the same framework to handle those cases, I shifted to a lightweight exploratory testing approach, which allowed us to uncover critical gaps in less time.

To practice shapelessness in your own work:

- Avoid rigid adherence to one testing tool or methodology.
- Regularly review and adapt your testing strategies to align with project goals.
- Stay curious and flexible, ready to change course when needed.

By embracing shapelessness, we can become more versatile and effective testers, capable of meeting any challenge head-on.

## #2 Sharpen your skills

Testing, like any craft, demands continuous learning. In Art of War, Sun Tzu emphasizes preparation and refinement, which aligns perfectly with the idea of sharpening your skills. The tools and techniques we rely on today might not solve the challenges of tomorrow, so staying on top of trends and expanding your knowledge is crucial.

During my presentation, I encouraged the audience to never stop improving. Whether it’s mastering a new testing framework, diving into performance testing, or understanding the nuances of DevOps, every skill you add strengthens your ability to deliver quality software. Testing isn’t just about execution—it’s about building a deep understanding of the systems you’re working with.

Take a proactive approach to learning:

- Experiment with new tools: Tools like Cypress, Playwright, or K6 each bring unique strengths to different types of testing. Don’t hesitate to try them out and discover which works best for specific scenarios.
- Understand the system architecture: Knowing how the application is built helps you design better tests and identify potential vulnerabilities.
- Attend workshops and conferences: Engaging with peers and thought leaders, as I did at TestWarez, is an excellent way to gain fresh insights and inspiration.
- Learn beyond your role: Programming skills, infrastructure knowledge, or even UX principles can provide invaluable context for your testing efforts.

A memorable moment from my journey was when I decided to delve deeper into performance testing. At first, I struggled with interpreting the results, but over time, I built proficiency in identifying bottlenecks and providing actionable feedback to developers. That skill became a game-changer in my ability to influence the project’s success.

The key takeaway? Never let yourself become complacent. The more you invest in sharpening your skills, the more equipped you’ll be to handle challenges and deliver impactful results. As testers, growth is both our responsibility and our greatest opportunity.

## #3 Strategize

Strategy is the bridge between vision and action. In testing, it’s not just about executing tests or using specific tools but understanding the bigger picture and planning effectively to ensure success. As Helmuth von Moltke famously noted, 

> [Strategy] is more than a science: it is the application of knowledge to practical life, the development of thought capable of modifying the original guiding idea in the light of ever-changing situations; it is the art of acting under the pressure of the most difficult conditions

Strategizing in testing means thinking beyond the immediate task and aligning your efforts with the overall goals of the project. It’s about being proactive—anticipating challenges, planning for them, and adapting your approach as situations evolve. A good strategy provides structure and direction while remaining flexible enough to accommodate unforeseen changes.

Here are some practical ways to bring strategy into your testing process:

- Define Your Objectives: Start by understanding the project’s priorities. Are you focused on ensuring flawless functionality, optimizing performance, or improving the user experience? Knowing your objectives helps guide your efforts.
- Plan for Risks: Identify potential problem areas early on. For example, if you’re working on a payment gateway, consider testing for edge cases, like network disruptions or delayed responses.
- Prioritize Your Testing Efforts: Not all features are created equal. Focus on testing the parts of the application that are most critical to the business or user journey.
- Remain Flexible: A good strategy is not rigid. If you encounter unexpected challenges, don’t hesitate to adjust your approach. For example, if automated tests aren’t catching specific issues, consider augmenting them with exploratory testing.

One practical example from my experience involved integrating test automation into our CI/CD pipelines. Instead of running tests manually at the end of the sprint, we automated the critical workflows to provide continuous feedback. This approach not only saved time but also ensured that issues were caught earlier, aligning perfectly with the project’s need for rapid delivery.

Strategizing in testing allows you to focus your energy where it matters most. It ensures that every effort contributes meaningfully to the project’s success, helping you deliver quality results even under challenging conditions. Remember, the best strategies are those that evolve with the project, keeping you ahead of potential issues and aligned with your goals.

## #4 Critical thinking

Critical thinking is one of the most important skills for testers. It’s about questioning assumptions, evaluating situations deeply, and making informed decisions. As Adam Roman emphasizes, critical thinking enables us to move beyond surface-level requirements and ask: “What are we really trying to achieve?”

In my presentation, I referenced the OODA loop (Observe, Orient, Decide, Act), a concept that encourages quick and deliberate decision-making. In testing, this means observing your application’s behavior, orienting yourself to the project’s context, deciding on the most effective actions, and then executing them efficiently. This iterative process allows you to continuously refine your testing efforts and adapt to new information.

Here are ways to incorporate critical thinking into your testing:

- Challenge Requirements: Don’t accept requirements at face value. If you notice inconsistencies or unclear details, ask questions. For example, if a requirement specifies that a login form must be “user-friendly,” probe deeper: What does “user-friendly” mean in this context?
- Evaluate Testing Approaches: During my talk, I discussed spike testing. Instead of simply executing such tests because they’re standard practice, critically assess whether they’re necessary. Sometimes, investing in preventative measures (e.g., rate limiting or load balancing) can be more effective than extensive spike testing.
- Look for Root Causes: When an issue arises, think critically about its origin. Is it a coding error, a misaligned business rule, or an environmental issue? Understanding the root cause helps you provide actionable feedback.
- Adapt Quickly: The OODA loop teaches us to act on new information and reevaluate our approach continuously. For example, if a test unexpectedly fails, critically assess whether it’s due to an actual bug or an outdated test case.

An example I shared was from the UEFA Euro 2000 website. The massive influx of users searching for updates caused major performance issues. Similarly, the recent demand spikes during Taylor Swift concert ticket sales showcased how systems can fail under pressure. Instead of focusing only on testing for these extreme scenarios, critical thinking would push us to ask: How can the system be designed to handle unexpected spikes in traffic more gracefully?

Incorporating critical thinking into your testing process not only improves the quality of your work but also enhances your ability to solve problems effectively. It’s about being proactive, not reactive, and always seeking the why behind the what. This mindset ensures that your testing efforts are not just thorough but also meaningful, driving better outcomes for your team and your projects.

## #5 Act

Having a plan is essential, but it’s meaningless without execution. In testing—and in life—it’s easy to get stuck in endless planning, overanalyzing every detail, or hesitating to take the next step. However, success comes from action. As the slides put it succinctly: “Just do it.”

In my presentation, I highlighted how critical it is to activate the feedback loop. Planning, strategizing, and thinking critically are important, but their value lies in putting them into practice. You might have the best strategy, but it will remain theoretical unless you act.

Here are some actionable insights to help you move from planning to execution:

- Start Small: If the scope of work feels overwhelming, break it down. For instance, instead of automating an entire suite of tests at once, focus on a single high-priority workflow and expand from there.
- Prototype Quickly: Don’t wait for perfection to take the first step. Whether you’re testing a new feature or implementing a new tool, start with a basic implementation, gather feedback, and iterate.
- Learn by Doing: The best way to master new tools or approaches is through hands-on experience. For example, when learning Playwright or K6, create simple test cases and expand as you grow more confident.
- Address Fear of Failure: Many testers hesitate to act because they fear making mistakes. Remember, every action provides valuable feedback—even when things don’t go as planned. Mistakes often lead to insights you wouldn’t discover otherwise.

A personal example comes from when I decided to introduce exploratory testing sessions into my team’s routine. Initially, there were concerns about its unstructured nature. However, by acting on the idea and holding a pilot session, we quickly discovered critical bugs that hadn’t been identified through automation or traditional test cases. The session’s success convinced the team of its value and made it a recurring part of our process.

The essence of this recommendation is simple: don’t let the perfect be the enemy of the good. Take the first step, even if it’s imperfect. By acting, you create opportunities to learn, improve, and ultimately deliver better results. Testing isn’t just about finding bugs; it’s about delivering value—and value comes from action.

## #6 Prepare for the unexpected

In testing, as in war, no amount of planning can account for every possibility. Systems fail, requirements change, and unforeseen challenges arise. The ability to adapt to these situations is a critical skill, and it starts with preparation.

During my presentation, I emphasized the concept of "friction," inspired by the teachings of Clausewitz. Friction represents the unpredictable nature of real-world challenges—things that can’t be planned for but must be managed when they occur. Preparing for the unexpected doesn’t mean predicting every potential issue but ensuring you have the tools, processes, and mindset to handle surprises effectively.

Here’s how you can prepare for the unexpected in testing:

- Always Have a Plan B: While it’s impossible to predict every failure, you can anticipate likely scenarios. For example, if a third-party API goes down, your application should have fallback mechanisms. Similarly, your testing process should include contingency plans, like alternative data sources or backup environments.
- Build Observability: Observability tools, such as monitoring systems, logs, and traces, provide critical insights during unexpected incidents. By understanding how your application behaves in real-time, you can respond faster when something goes wrong.
- Practice Failure Scenarios: Run chaos engineering experiments or simulate outages to see how your system and team handle failure. These exercises expose weaknesses and help you improve your preparedness.
- Adopt an Agile Mindset: Be flexible. When the unexpected happens, adapt your priorities and testing strategy. For example, if new requirements emerge late in the development cycle, focus your efforts on the highest-risk areas.

One of the most vivid examples of unexpected challenges comes from major online events, such as ticket sales for concerts or international sports tournaments. Systems often experience traffic surges far beyond what was anticipated. Instead of solely testing for these extremes, organizations that are prepared for the unexpected invest in solutions like auto-scaling infrastructure or graceful degradation strategies.

The key takeaway is that preparation doesn’t mean having all the answers—it means being ready to respond effectively when the unexpected happens. By building resilience into your processes and fostering a mindset of adaptability, you can face challenges with confidence and turn potential disasters into opportunities to improve.

## #7 Engineering is social

Software testing isn’t just about tools, frameworks, or technical skills—it’s about people. As I mentioned during my presentation, one of the biggest mistakes I’ve made in my career was neglecting the social aspect of engineering. Effective testing relies on collaboration, communication, and building strong relationships within the team.

Testing is inherently a collaborative activity. It involves working closely with developers, product managers, designers, and sometimes even end-users to ensure the product meets expectations. Fostering a culture of openness and shared responsibility for quality is just as critical as writing a good test case.

Here’s how to embrace the social side of engineering in your testing practices:

- Communicate Effectively: Don’t silo yourself as "just the tester." Share insights, ask questions, and provide constructive feedback to other team members. For example, if a test reveals a critical issue, work with the developer to understand its root cause and resolve it efficiently.
- Build Relationships: Strong personal connections make collaboration smoother. A good rapport with developers, for instance, can help reduce tension when reporting bugs or suggesting changes.
- Encourage Knowledge Sharing: Testing isn’t just the QA team’s responsibility. Encourage everyone on the team to participate, whether through pair testing, workshops, or shared tools for exploratory testing.
- Celebrate Wins Together: Testing often highlights issues, which can sometimes feel negative. Make sure to balance this by celebrating successes, such as zero critical bugs in a sprint or an exceptionally smooth deployment.

A personal example comes from a challenging project where testing and development teams were at odds. Bugs were seen as "failures" rather than opportunities to improve. By organizing cross-functional meetings and fostering open communication, we shifted the culture to one where issues were addressed collaboratively. This not only improved product quality but also strengthened the team dynamic.

Engineering is a human-centered activity, and testing is no different. By focusing on the social aspects—communication, teamwork, and shared responsibility—you create an environment where quality thrives. After all, the best tools and strategies can only succeed when the people behind them are working together effectively.

## #8 Be interdisciplinary

Innovation often comes from combining knowledge from different fields. In testing, looking beyond your immediate area of expertise can unlock new approaches, techniques, and perspectives. As I mentioned during my presentation, “To learn the sword, study the guitar; to learn the fist, study commerce.” This wisdom from Musashi emphasizes that mastering one discipline often involves learning from others.

Testing isn’t just about understanding tools or coding—it’s about seeing the bigger picture. By exploring diverse fields, you can bring fresh insights into your testing practice, whether it’s from development, UX design, project management, or even psychology.

Here’s how to embrace an interdisciplinary mindset in your work:

- Learn from Development: Understanding coding practices can make you a more effective tester. For example, learning how APIs work helps you design better integration tests or debug issues more efficiently.
- Explore User Experience (UX): By studying UX principles, you can approach testing from the user’s perspective. This can help you identify issues that might impact usability or accessibility.
- Dive into Performance Optimization: Familiarize yourself with DevOps concepts like CI/CD, observability, and infrastructure automation. These skills help you integrate testing seamlessly into the development pipeline.
- Look Beyond IT: Fields like behavioral psychology can teach you how users interact with systems, while storytelling can improve the way you communicate bugs or insights to stakeholders.

An example from my own experience involved learning basic design principles. By understanding how UI components should look and behave, I was able to test visual elements more effectively and collaborate better with designers. Similarly, when I delved into performance testing, I gained a deeper appreciation for how small code changes could significantly impact system efficiency.

Being interdisciplinary isn’t about becoming an expert in everything—it’s about broadening your horizons and applying insights from different domains to improve your work. Testing thrives at the intersection of multiple disciplines, and the more perspectives you can bring to the table, the more innovative and impactful your solutions will be.

## #9 Drill

Practice is the cornerstone of mastery. Whether you’re honing your technical skills, refining your testing strategies, or improving collaboration within your team, consistent practice is what turns knowledge into expertise. As the slides state: “Keep practicing.”

In testing, drilling means not only applying your skills regularly but also seeking ways to improve them. This might involve exploring new tools, running simulations, or revisiting foundational concepts to strengthen your understanding. It’s about creating habits that continuously sharpen your abilities and prepare you for both routine and unexpected challenges.

Here’s how to incorporate drilling into your testing routine:

- Practice with Purpose: Focus on areas where you want to improve. For example, if you’re learning a new tool like Playwright, dedicate time to creating small test scripts and gradually work on more complex scenarios.
- Simulate Real-World Scenarios: Run mock tests or simulations to mimic real-world conditions, such as high traffic loads or edge-case user behaviors. This helps you identify gaps in your testing approach and build confidence in handling diverse situations.
- Collaborate During Practice: Pair testing sessions or group exploratory testing activities can help you learn from your peers and gain new perspectives.
- Review and Reflect: After each testing effort, evaluate what went well and what could be improved. Use this feedback to refine your process and approach.

A personal example comes from when my team started implementing exploratory testing sessions. Initially, we were unsure how to structure them. By holding regular drills, experimenting with different approaches, and discussing outcomes as a team, we developed a more effective process that became a staple in our workflow.

Drilling isn’t just about repetition; it’s about intentional, focused practice that pushes your limits and builds your confidence. The more you practice, the more prepared you’ll be to tackle challenges and deliver high-quality results, no matter what comes your way. In testing, as in any craft, mastery is earned through consistent effort.

## #10 Become a thinker

In testing, it’s easy to focus solely on execution—running tests, reporting bugs, and meeting deadlines. But to truly excel, you need to step back and think. Reflect on the bigger picture, challenge the status quo, and actively seek ways to innovate. As Sun Tzu famously said, “If you know the enemy and know yourself, you need not fear the result of a hundred battles.” Knowing yourself—your strengths, your weaknesses, and your unique perspective—is the foundation of becoming a thinker.

Being a thinker means moving beyond the checklist and engaging in deeper, more creative problem-solving. It’s about creating rather than merely following. It’s also about challenging your fears and assumptions, which often hold you back from doing your best work.

Here are ways to cultivate a thinker’s mindset in your testing:

- Reflect Regularly: Take time to review your work and processes. Ask yourself what’s working, what isn’t, and how you can improve.
- Seek Patterns: Instead of focusing solely on individual bugs, look for trends that indicate systemic issues. For example, repeated failures in specific modules might point to weaknesses in design or development practices.
- Think Beyond Testing: Consider how your work impacts the broader goals of the project. How does improving test coverage, for example, contribute to user satisfaction or business success?
- Overcome Fear of Failure: Being a thinker means taking risks—trying new approaches or experimenting with unfamiliar tools. Not every experiment will succeed, but every experience will teach you something valuable.
- A personal example that embodies this principle is when I decided to challenge a long-standing assumption in one of our projects: that only QA engineers could perform exploratory testing. By involving developers and product managers in exploratory sessions, we uncovered unique insights that enhanced our testing process and improved collaboration across the team.

Becoming a thinker doesn’t mean abandoning execution—it means enriching it with creativity, reflection, and insight. It’s about stepping into a leadership role in your work, not by title, but by the way you approach challenges and inspire others. As testers, our greatest strength lies in our ability to think critically and strategically, ensuring that every action we take is thoughtful, deliberate, and impactful.