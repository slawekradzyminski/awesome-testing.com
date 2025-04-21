---
title: "Cypress Parallel Execution"
layout: post
permalink: /2024/10/cypress-parallel-execution
categories:
  - Cypress
tags:
  - Cypress
description: >
  A practical guide to implementing parallel test execution in Cypress, comparing different approaches including Cypress Cloud, handcrafted spec splitting, and the cypress-split plugin.
redirect_from:
  - /cypress-parallel
---

![](/images/blog/cyvspw.png){:width="100%" loading="lazy"}

As shown in the graph above, Playwright has recently overtaken Cypress in popularity. One key reason for this shift is Playwright's support for [parallel test execution](https://playwright.dev/docs/test-parallel). This feature, which allows multiple tests to run simultaneously rather than one after another, plays a crucial role in reducing overall test duration and improving the feedback loop. Faster feedback enables quicker iteration, which is ideal for maintaining an efficient development process. It's also worth noting that Selenium, while not the most popular choice for modern web testing, fully supports parallel execution as well by various means (test runners and Selenium Grid).

In this article, we'll dive into how parallel execution works in Cypress. Please note that this article was written in October 2024, and the landscape may shift in the coming months. [npmtrends data](https://npmtrends.com/cypress-vs-playwright) may prompt Cypress to adjust their roadmap as the competition evolves.

## Cypress Cloud

The most straightforward option is Cypress Cloud, which extensively covers parallel execution in its [official documentation](https://docs.cypress.io/guides/cloud/smart-orchestration/parallelization). However, Cypress Cloud is a [paid service](https://www.cypress.io/pricing) costing $67/month for 50 licenses and 120,000 test executions. It's a feature-rich product that covers all CI/CD aspects necessary for comprehensive test reporting.

That said, there are two important considerations:

- Parallel execution in Cypress requires multiple runners (unlike Playwright, where parallelization is built into the framework). If you opt for cloud-based CI runners, additional costs will apply.

![](/images/blog/parallelization-diagram.png){:width="100%" loading="lazy"}

- By using Cypress Cloud, you consent to having your data transferred and stored on their servers, which can pose challenges for security-conscious organizations.

## Sorry Cypress / currents.dev

Before the release of Cypress 13, [Sorry Cypress](https://sorry-cypress.dev/) was a popular alternative. It offered cheaper test execution in the cloud and, perhaps more importantly, allowed organizations to host the dashboard on their own infrastructure at no cost. This gave companies full control over their test data and costs, while also encouraging test engineers to develop valuable DevOps, CI/CD, Docker, and cloud skills by managing the infrastructure themselves.

However, in November 2023, the owners of Cypress made the decision to block this service, sparking significant controversy within the community. The decision, and how it was implemented, led to widespread debate. You can read more about the issue on the well-known [currents.dev blog](https://currents.dev/posts/v13-blocking). This marked a major turning point for the Cypress community, with many users migrating to Playwright, either because they couldn't afford Cypress Cloud or due to concerns about data privacy.

Given the current landscape, it's unlikely that Sorry Cypress will return. The [currents.dev](https://currents.dev/blog) blog now actively advocates for Cypress users to transition to Playwright, leaving a sense of "burned ground" in the Cypress community.

## Handcrafted spec split

With an understanding of how parallel execution works in Cypress Cloud, you can create a custom solution to split tests across multiple jobs. In the example below, we use a custom GitLab CI template to run Cypress tests in two separate jobs. A simple shell script splits the tests into two groups (files starting with `a-n` and `o-z`) and runs them in parallel by passing a custom list of specs to the [Cypress CLI](https://docs.cypress.io/guides/guides/command-line). You can adjust this setup further by splitting tests into more jobs, depending on the number of runners available in your CI environment.

{% highlight yaml %}
# Define a reusable template
.frontend-ui-tests-template:
  image: cypress/base:20.18.0
  stage: test
  script:
    - cd frontend
    - npm install
    - npm run start & ./node_modules/.bin/wait-on http://localhost:8099
    - FILES=$(ls cypress/e2e/${TEST_PATTERN}*.cy.ts | tr '\n' ',')
    - FILES=${FILES%,}
    - ./node_modules/.bin/cypress run --browser chrome --headed --spec "$FILES"
  artifacts:
    when: on_failure
    paths:
      - frontend/cypress/screenshots/*
    expire_in: 4 hours

# Specific jobs using the template
frontend UI tests part 1:
  extends: .frontend-ui-tests-template
  variables:
    TEST_PATTERN: "[a-n]"

frontend UI tests part 2:
  extends: .frontend-ui-tests-template
  variables:
    TEST_PATTERN: "[o-z]"
{% endhighlight %}

The only downside of this approach is the lack of a consolidated test report. If a single report is necessary, consider using the [junit reporter](https://www.browserstack.com/docs/test-management/upload-reports-cli/frameworks/cypress) along with [junit-report-merger](https://www.npmjs.com/package/junit-report-merger) to generate a summary report.

The main advantage of this method is that it allows you to run tests in parallel without incurring additional costs. It's unlikely that Cypress will remove the `--spec` flag from the CLI, as doing so would block single-test executions via the command line. The only tricky part is managing the reporting, but if you're focused on [isolated tests](https://www.awesome-testing.com/2020/02/isolated-cypress-ui-tests) with mocked backends, this shouldn't be a significant issue. In my workflow, where I write such tests, the results are fairly binary: if the tests pass, I merge the PR; if they fail, I investigate and fix the code or tests.

## cypress-split

In yet another chapter of the ongoing Cypress drama, the main figure is Gleb Bahmutov, a former core team member who spent four years working on the Cypress Test Runner. Now focusing on his [Cypress courses](https://cypress.tips/courses) , Gleb has been openly critical of how the library is currently managed. His stance is best captured in his [blog post](https://glebbahmutov.com/blog/cypress-parallel-free/), where he expresses his frustration with the situation:

> You deserve your Cypress tests to run very quickly FOR FREE.

Fortunately for us, Gleb has created a [cypress-split](https://www.npmjs.com/package/cypress-split) plugin, which allows you to split tests into smaller chunks and run them in parallel. The plugin offers similar functionality to the handcrafted spec-splitting example mentioned earlier but is more sophisticated and user-friendly. Here's how you can configure it in a GitLab CI pipeline:

{% highlight yaml %}
frontend cypress tests:
  image: cypress/base:20.18.0
  stage: test
  parallel: 3
  script:
    - cd frontend
    - npm install
    - npm run start & ./node_modules/.bin/wait-on http://localhost:8099
    - npx cypress run --browser chrome --headed --env split=true
  artifacts:
    when: on_failure
    paths:
      - frontend/cypress/screenshots/*
    expire_in: 4 hours
{% endhighlight %}

The number of code modification is minimal. You just need to install it via `npm i -D cypress-split` and modify `cypress.config.ts` to enable the plugin:

{% highlight typescript %}
const { defineConfig } = require('cypress')
const cypressSplit = require('cypress-split')

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {
      cypressSplit(on, config)
      return config
    },
  },
})
{% endhighlight %}

There are two potential downsides to this approach:

- Cypress owners may block this plugin in future releases, as they've done with other plugins before. If that happens, you'll have to revert to a custom spec-splitting solution. 

- similar to handcrafted spec split, you need to have a way to merge the test results into a single report.

Considering `cypress-split` is developed by ex-Cypress core team member, I recommend you to ignore other plugins (like [cypress-parallel](https://www.npmjs.com/package/cypress-parallel)) and stick with it. I recently migrated my Cypress tests to use cypress-split, and it has been working flawlessly so far. As of October 2024, this is my recommended approach!




