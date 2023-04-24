---
title: Understanding Cypress synchronous/asynchronous duality
layout: post
permalink: /2023/03/understanding-cypress
categories:
  - Cypress
tags:
  - cypress
  - test automation
  - UI testing 
---

![](/images/blog/cypress.png)

Cypress is a widely used end-to-end testing framework for web applications that offers an easy-to-use API and a powerful
command-line interface. It enables developers to write tests that mimic end-users' interactions with their applications.
Understanding how sync/async works is a crucial concept for developers using Cypress.

However, one of the common criticisms leveled against Cypress is its approach to handling asynchronous behavior in
JavaScript. To ensure that commands are executed synchronously, Cypress uses a technique
called "[command chaining](https://learn.cypress.io/cypress-fundamentals/command-chaining)." This can result in
Cypress "hacking" the JavaScript code running in the browser by overriding certain native browser APIs. It ensures that
the test runner waits for commands to complete before moving on to the next one.

Some testers argue that this approach can cause unexpected behavior in certain situations and interfere with the
application code. Nevertheless, Cypress has implemented this technique to address the problem of flaky tests caused by
race conditions and other timing issues. Cypress also provides tools to help developers understand what's happening
under the hood, such as the ability to log and debug the commands being executed.

## Synchronous vs asynchronous Javascript

JavaScript is a versatile programming language used for building web applications. In web development, asynchronous
programming is a common concept, as JavaScript code often has to interact with web APIs, databases, and other remote
services. Understanding how sync and async JavaScript works is essential for building efficient, scalable, and
error-free web applications.

### Synchronous Javascript

Synchronous JavaScript is straightforward to understand as it operates in a blocking or synchronous manner. This means
that when a piece of code executes, the next line of code will not execute until the current line has finished
executing. For example, consider the following code:

{% highlight javascript %}
console.log('start');
console.log('middle');
console.log('end');
{% endhighlight %}

This code will output:

{% highlight bash %}
start
middle
end
{% endhighlight %}

In synchronous JavaScript, each console.log statement executes in order, and the second statement will not start
executing until the first one has finished.

### Asynchronous Javascript

Asynchronous JavaScript is different from synchronous JavaScript because it operates in a non-blocking or asynchronous
manner. This means that when a piece of code executes, the next line of code can execute before the current line has
finished executing. For example, consider the following code:

{% highlight javascript %}
console.log('start');
setTimeout(() => {
console.log('middle');
}, 1000);
console.log('end');
{% endhighlight %}

This code will output:

{% highlight bash %}
start
end
middle
{% endhighlight %}

In asynchronous JavaScript, the setTimeout function executes asynchronously. It starts a timer for one second and then
returns immediately. Meanwhile, the console.log('end') statement executes before the timer has finished. When the timer
finishes after one second, the function passed to setTimeout executes, and the console.log('middle') statement is output
to the console.

Asynchronous JavaScript can be challenging to work with as it requires the use of callbacks, promises, or async/await.
Callbacks are a function that is passed as an argument to another function and is called when the other function has
finished executing. Promises are an object that represents a value that may not be available yet but will be resolved at
some point in the future. Async/await is a modern approach that makes asynchronous programming in JavaScript more
comfortable to work with by using a combination of promises and generators.

Callbacks are an older approach to asynchronous programming in JavaScript. They can be challenging to manage and can
lead to "callback hell," where nested callbacks become difficult to read and maintain. Promises were introduced in
ECMAScript 6 as a better way of dealing with asynchronous programming. They allow developers to chain asynchronous
operations together, making the code easier to read and understand.

Async/await is a new approach to asynchronous programming in JavaScript that was introduced in ECMAScript 2017. It is a
cleaner and more concise way of handling asynchronous operations, and it makes the code more readable and maintainable.
Async/await uses promises and generators to make asynchronous programming easier to work with, and it has quickly become
the preferred way of handling asynchronous operations in modern JavaScript.

## Understanding Cypress chain of command

Understanding how Cypress handles asynchronous operations is a crucial concept for developers to grasp. Misunderstanding
how Cypress deals with asynchronous tasks can create issues and confusion during the debugging process of tests.

Cypress test steps are inherently asynchronous, but the framework includes an engine that enforces the sequential
execution of commands. When a Cypress command is invoked, it is not executed immediately but is instead added to a queue
for later execution.

To illustrate how Cypress command chaining works using promises, consider the following test example:

{% highlight javascript %}
/// <reference types="cypress" />

describe('Awesome tests', () => {
    beforeEach(() => {
        cy.visit('https://awesome-testing.com/')
    })

    it('should find Cypress posts', () => {
        cy.get('.gsc-input input').type('Cypress')
        cy.get('.gsc-search-button input').click()
        cy.get('.post-title').should('have.length.above', 1)
    })

})
{% endhighlight %}

Effectively, this is the JavaScript code that is executed in the browser (the details may vary but it's a chain of
promises):

{% highlight javascript %}
/// <reference types="cypress" />

describe('Awesome tests', () => {

    it('should find Cypress posts', () => {
        cy.visit('https://awesome-testing.com/')
            .then(() => {
                cy.get('.gsc-input input')
            }).then(($input) => {
                cy.wrap($input).type('Cypress')
            }).then(() => {
                cy.get('.gsc-search-button input')
            }).then(($btn) => {
                cy.wrap($btn).click()
            }).then(() => {
                cy.get('.post-title').should('have.length.above', 1)
            })
    })

})
{% endhighlight %}

Note: there is [special logic](https://docs.cypress.io/api/commands/should#Differences) for handling .should() hence the
last line is simplified.

The second code snippet demonstrates how Cypress commands return a promise that can be used to chain together a sequence
of commands that are executed in order. This approach ensures that commands are executed synchronously and that the test
runner can wait for commands to complete before moving on to the next one.

### beforeEach

One thing which complicates the picture even more is [Mocha](https://mochajs.org) _beforeEach_ webhook. All the
commands, including Cypress chain of commands (_cy.something()_) are guaranteed to execute before tests. It effectively
means that Cypress builds a separate chain of command per _before_, _beforeEach_, _after_ and _afterEach_.

Described behaviour has very significant impact on [debugging](https://docs.cypress.io/guides/guides/debugging).
Consider the following example:

{% highlight javascript %}
/// <reference types="cypress" />

describe('Awesome tests', () => {
beforeEach(() => {
cy.visit('https://www.awesome-testing.com/')
cy.viewport(1920, 1080)
console.log('This will be logged before cy.visit')
})

    it('should find Cypress posts', () => {
        cy.get('.gsc-input input').type('Cypress')
        cy.get('.gsc-search-button input').then(($btn) => {
            console.log('This will be logged after typing Cypress')
        })
        cy.get('.post-title').should('have.length.above', 1)
        console.log('This will be logged after cy.visit')
    })

    afterEach(() => {
        cy.wait(2000)
        cy.log('This is Cypress logging hence it will log after waiting')
        console.log('This will log after test before waiting')
    })

})
{% endhighlight %}

The order of execution is as follows:

* synchronous commands in _beforeEach_
* Cypress commands (_cy.something()_) in _beforeEach_
* synchronous commands in _it_
* Cypress commands (_cy.something()_) in_it_
* synchronous commands in_afterEach_
* Cypress commands (_cy.something()_) in_afterEach_

As you can see for the most effective debugging we have to write code in
_[then()](https://docs.cypress.io/api/commands/then)_ section. However, _.then()_ is a Cypress command, not a Promise.
This means you cannot use things like async/await within your Cypress tests.

## Conclusion

Cypress offers a low entry level for developers to start testing their web applications, with its easy-to-use API and
user-friendly command-line interface. However, this simplicity comes at a cost. The framework is effectively sandboxed,
meaning that performing tasks outside of its defined parameters can be difficult. This can limit the ability of
developers to fully customize their testing environment and address more complex testing scenarios. Despite its
limitations, Cypress provides a solid foundation for web application testing and can be a valuable tool for developers
looking to quickly and effectively test their applications. However, it's important to consider the trade-offs when
deciding whether to use Cypress, and to understand its limitations before getting started.
