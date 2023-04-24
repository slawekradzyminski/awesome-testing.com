---
title: Five minutes performance report with Google Lighthouse
layout: post
permalink: /2018/03/five-minutes-performance-report-with
categories:
  - Performance testing
tags:
  - performance testing 
---

With little disappointment I realised today that I haven’t done a single post about performance testing (in almost 3
years of blogging!). Today I’d like to change that by introducing you with simple, yet powerful, performance tool
called [Lighthouse](https://github.com/GoogleChrome/lighthouse). According to developers:

> Lighthouse analyzes web apps and web pages, collecting modern performance metrics and insights on developer best
> practices.

In case you are short on time choose Lighthouse. You only need… 5 minutes to make Desktop & Mobile report. Lighthouse
opens Chrome browser and gathers all useful metrics
from [Chrome Dev Tools](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/).

## Setup

Installation couldn’t be easier. First you need npm (get it from [here](https://nodejs.org/en/download/)) and then type:

`npm install -g lighthouse`

## Generating report

Now we need only two commands in order to get reports.

a) Desktop

`lighthouse https://www.awesome-testing.com --disable-device-emulation --disable-cpu-throttling
--disable-network-throttling --view`

You can view generated reports here:

[Link to Lighthouse Desktop report](https://htmlpreview.github.io/?https://github.com/slawekradzyminski/AwesomeTesting/blob/b453b50f7f2a1d2826d632edf7fc74a5fdce35f6/src/test/java/com/awesome/testing/performance/lighthouse/Desktop-report.html)

b) Mobile

`lighthouse https://www.awesome-testing.com --disable-network-throttling --view`

You may want to get rid of `--disable-network-throttling option` in order to simulate 3G connection.

You can view generated reports here:

[Link to Mobile report](http://htmlpreview.github.io/?https://github.com/slawekradzyminski/AwesomeTesting/blob/f1c66b7f569ef09b70c11ee9e0400b6947f77203/src/test/java/com/awesome/testing/performance/lighthouse/Mobile-report.html)

As you can see performance of my blog is really good :)

![](/images/blog/wOjmmz3BCDKC1856YSLjtk3JH-OedzNnVT20-Eq0fZpWmVZ4rWtcopwAOLu1Ig0jZSA6fR2eWy1h9lsD_A8zSFuDdPTfyy2xQqJrL70nhiHbbdgTga7Tzt0j1sCrPZdQnFyhH7dx)

## Useful options

a) Passing headers (can be used to get logged in pages)

`lighthouse \--extra-headers "{\\"Cookie\\":\\"monster=blue\\"}"`

b) Passing chrome flags

Every single one of [Chromium Command Line Switches](https://peter.sh/experiments/chromium-command-line-switches/) can
be used

`lighthouse \--chrome-flags=’--start-maximized’`

## Continuous Integration usage

As with almost everything related to automated tests we would like to add them into Continuous Integration. Lighthouse
allows it!
See [official guide](https://github.com/GoogleChrome/lighthouse/blob/master/docs/readme.md#using-programmatically) for
details.

Quick win, isn't it?
