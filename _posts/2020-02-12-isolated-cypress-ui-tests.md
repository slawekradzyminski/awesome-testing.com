---
title: Isolated Cypress UI tests
layout: post
permalink: /2020/02/isolated-cypress-ui-tests
categories:
  - Cypress
tags:
  - cypress 
---

![](/images/blog/Screenshot%2B2020-02-08%2Bat%2B14.09.16.png)

In my previous post, I described the
whole [test automation strategy](https://www.awesome-testing.com/2020/01/practical-test-strategy-for-spring.html) for
Spring + React application. One of the items there was isolated Cypress UI tests.

In this post, I'd like to describe what isolation means and how to achieve it using Cypress. As usual, the theory will
be supported by a practical and working demo. All code on [my GitHub](https://github.com/slawekradzyminski) is 100% free
to use by anyone.

## Understanding isolation

So what are the characteristics of an isolated test?

First of all, it needs to work offline. All external traffic should be controlled inside a test. Of course, in
real-world we are connected to the network but all your isolated tests should pass in the following scenario:

* download dependencies (maven, npm, sbt...)
* run the app you test (if needed)
* disable network connection
* run tests

All tests should also be fully idempotent. They should work in any order. Each of them should set the desired
application state before running.

## Isolation in Cypress

Let's look again at the system under test and analyze what isolation means for us.

![](/images/blog/Screenshot%2B2020-01-18%2Bat%2B12.41.12.png)

We need to do two things:

- stubbing incoming backend requests

- asserting that outgoing frontend requests are correctly built

Cypress seems to be build-in having stubbing in mind. We only need two lines and static object to stub GET requests in
cypress:

{% highlight javascript %}
cy.server();
cy.route('/users/1', firstUser);
view raw
{% endhighlight %}

{% highlight javascript %}
export const firstUser = {
    "id": 1,
    "firstName": "Slawomir",
    "lastName": "Radzyminski",
    "userName": "slawenty",
    "salary": 666,
    "age": 66
};
{% endhighlight %}

cy.server() needs to be called only once. It enables custom cy.route() stubbing for test. As you can see stubbing GET
requests requires providing a response body only. Of course, you can also provide custom headers, delays, etc. Details
in the [command documentation](https://docs.cypress.io/api/commands/route.html#Options).

## Demo - testing data display on the front page

I assume you have successfully installed Cypress
and [run the first test](https://docs.cypress.io/guides/getting-started/writing-your-first-test.html#Add-a-test-file).
Cypress documentation guides you very well through the initial setup.

So let's get started with my application tests. I usually define the most useful get stubs in custom command and run
them before each test:

{% highlight javascript %}
    beforeEach(() => {
        cy.prepareBackend();
        cy.visit('/');
    });
{% endhighlight %}

To define your custom commands you need to implement them:

{% highlight javascript %}
Cypress.Commands.add("prepareBackend", () => {
    cy.server();
    cy.route('/users', usersJson);
    cy.route('/users/1', firstUser);
    cy.route('/users/2', secondUser);
});
{% endhighlight %}

And import in index.js file:

{% highlight javascript %}
import './commands'
{% endhighlight %}

Optionally, for better IDE support, you may want to define this command in index.d.ts TypeScript file.

{% highlight javascript %}
declare namespace Cypress {
    interface Chainable {
        prepareBackend(): Chainable
    }
}
{% endhighlight %}

Having all that in place we can verify that our front page displays data properly:

{% highlight javascript %}
    it('should have proper data displayed', () => {
        const numberOfUsers = usersJson.length;
        for (let i = 0; i < numberOfUsers; i++) {
            cy.get(`.MuiTableBody-root tr:nth-of-type(${i + 1})`).within(() => {
                cy.get('[name=firstname]').should('have.text', usersJson[i].firstName);
                cy.get('[name=lastname]').should('have.text', usersJson[i].lastName);
                cy.get('[name=username]').should('have.text', usersJson[i].userName);
                cy.get('[name=age]').should('have.text', usersJson[i].age.toString());
                cy.get('[name=salary]').should('have.text', usersJson[i].salary.toString());
            })
        }
    });
{% endhighlight %}

## Demo - asserting outgoing requests

When it comes to asserting that our frontend app builds and sends correct requests the flow isn't so simple.

At first, we need to make sure that our fake backend will respond in the desired way (usually HTTP 200). The request
should be tagged in .as() so we can access and verify it later.

{% highlight javascript %}
        cy.route({
            url: '/users/1',
            method: 'PUT',
            status: 200,
            response: {}
        }).as('updateUser');
{% endhighlight %}

So in a test, we would edit the existing user and override its data to the following:

{% highlight javascript %}
    const testData = {
        userName: 'sampleLogin',
        firstName: 'John',
        lastName: 'Doe',
        age: 19,
        salary: 99999
    };
{% endhighlight %}

We click on the first edit button, override data and save changes:

{% highlight javascript %}
cy.get('[name=edit] svg').first().click();
cy.get('[name=userName').clear().type(testData.userName);
cy.get('[name=firstName').clear().type(testData.firstName);
cy.get('[name=lastName').clear().type(testData.lastName);
cy.get('[name=age').clear().type(testData.age);
cy.get('[name=salary').clear().type(testData.salary);
cy.get('button.MuiButton-containedPrimary').click();
{% endhighlight %}

And now the clue. Here is how to assert outgoing request:

{% highlight javascript %}
        cy.wait('@updateUser').should((xhr) => {
            let body = xhr.request.body;
            expect(body.id).to.equal(firstUser.id);
            expect(body.userName).to.equal(testData.userName);
            expect(body.firstName).to.equal(testData.firstName);
            expect(body.lastName).to.equal(testData.lastName);
            expect(body.age).to.equal(testData.age.toString());
            expect(body.salary).to.equal(testData.salary.toString());
        });
{% endhighlight %}

## Fetch API and Cypress

There are two leading technologies which browser use to make
requests: [XHR](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest)
and [Fetch](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) API. XHR (often called AJAX) is older and more
popular, whereas Fetch is a modern approach that relies on [Promise/async](https://javascript.info/async) javascript
syntax.

Unfortunately, Cypress supports only XHR right now. Fetch support is in progress, but with no release date commitments.
There is a very interesting [GitHub issue](https://github.com/cypress-io/cypress/issues/95) where you can track work
progress and read about possible workarounds.

If your application relies on Fetch API I suggest you use the following workaround:

* set `win.fetch` for null before each test (disable it)
* replace `win.fetch` with [Fetch polyfill](https://github.com/github/fetch)

Your application would think that its making Fetch requests and you will be able to stub them.

Hack implementation is here:

{% highlight javascript %}
//  See: https://github.com/cypress-io/cypress/issues/95
enableFetchWorkaround();

function enableFetchWorkaround() {
    let polyfill;

    before(() => {
        cy.log('Load fetch XHR polyfill');
        cy.readFile('./cypress/support/polyfills/unfetch.umd.js').then((content) => {
            polyfill = content
        })
    });

    Cypress.on('window:before:load', (win) => {
        delete win.fetch;
        win.eval(polyfill);
        win.fetch = win.unfetch
    })
}
{% endhighlight %}

Now you only need to import this hack in index.js:

{% highlight javascript %}
import './hooks'
{% endhighlight %}

And copy/paste fetch polyfill:

{% highlight javascript %}
// https://unpkg.com/unfetch@4.1.0/dist/unfetch.umd.js

!function(e,n){"object"==typeof exports&&"undefined"!=typeof module?module.exports=n():"function"==typeof define&&define.amd?define(n):e.unfetch=n()}(this,function(){return function(e,n){return n=n||{},new Promise(function(t,o){var r=new XMLHttpRequest,s=[],u=[],i={},f=function(){return{ok:2==(r.status/100|0),statusText:r.statusText,status:r.status,url:r.responseURL,text:function(){return Promise.resolve(r.responseText)},json:function(){return Promise.resolve(JSON.parse(r.responseText))},blob:function(){return Promise.resolve(new Blob([r.response]))},clone:f,headers:{keys:function(){return s},entries:function(){return u},get:function(e){return i[e.toLowerCase()]},has:function(e){return e.toLowerCase()in i}}}};for(var a in r.open(n.method||"get",e,!0),r.onload=function(){r.getAllResponseHeaders().replace(/^(.*?):[^\S\n]*([\s\S]*?)$/gm,function(e,n,t){s.push(n=n.toLowerCase()),u.push([n,t]),i[n]=i[n]?i[n]+","+t:t}),t(f())},r.onerror=o,r.withCredentials="include"==n.credentials,n.headers)r.setRequestHeader(a,n.headers[a]);r.send(n.body||null)})}});
{% endhighlight %}

Working application with the following tests can be found here:

[https://github.com/slawekradzyminski/reactfrontend](https://github.com/slawekradzyminski/reactfrontend)

Let me know in comments if you like to see more Cypress posts here :)
