---
title: Introducing FluentLenium 2 - Selenium waiting game
layout: post
permalink: /2016/04/introducing-fluentlenium-2-selenium
categories:
  - Selenium
tags:
  - selenium
  - fluentlenium
  - firefox
  - test automation
  - UI testing
  - chrome 
---

![](/images/blog/myfacewhilewaitingforittoload_97763284cc024193ded2f45d572c0e98.jpg)

[Introducing FluentLenium](https://awesome-testing.com/2016/01/introducing-fluentlenium-1.html) is so far my most popular
technical post and I will continue the series today with a very important subject - test waiting. For those who don't
know - [FluentLenium](https://github.com/FluentLenium/FluentLenium) is an actively developed Selenium extension that
simplifies writing GUI tests.

Before I delve deeper into FluentLenium powerful waiting methods let me explain why I decided to cover this topic more
deeply:

a) Good implementation of waiting makes your tests:

* stable
* maintainable
* readable
* faster

All dots listed here are extremely important factors to your testing project success/failure. I will come back to those
characteristics while discussing various waiting methods.

b) There aren't many reliable sources in this subject (as usual, I
recommend[Mastering Selenium WebDriver](http://www.amazon.com/Mastering-Selenium-WebDriver-Mark-Collin/dp/1784394351))
and, a lot of false/obsolete information. For
example,[this](http://stackoverflow.com/questions/12858972/how-can-i-ask-the-selenium-webdriver-to-wait-for-few-seconds-in-java?rq=1)
post with +11 recommends static 5 seconds waiting.

c) The topic isn't covered in Java books (because it's the framework-specific), and most of the Selenium courses treat
it falsely as an advanced topic

The waiting methods are ordered from the worst one to the best one:

**1\. Sleeping**

{% highlight java %}
Thread.sleep(3000);
{% endhighlight %}

The most obvious method which you should never, ever use. Probably most of us started our automation journeys with it.
Selenium can't find locator so we wait 2 seconds. Then we decide that 4 seconds is necessary. After that our tests
become slow so we trim the time to 3 seconds. Then we change machine or run tests on Grid and it's really, really bad.

See characteristics I have listed in point a) - we meet none of them by using Thread.sleep().

**2\. Implicit waits**

The implicitWait is configured globally (i.e. it's declared per driver), and it defines the time before throwing 'No
Such Element Exception'. The default is 0 seconds. The line below configures ImplicitWait for 10 seconds.

{% highlight java %}
driver.manage().timeouts.implicitWait(10,TimeUnit.SECONDS);
{% endhighlight %}

So far it looks good. Now imagine that you want to check if the loading element disappears on the page in 5 seconds time
margin. We will stay in clean Selenium and use explicitWait:

{% highlight java %}
WebDriverWait wait = new WebDriverWait(getDriver(), 5, 500);
wait.until(not(presenceOfElementLocated(By.id("disappearingelement"))));
{% endhighlight %}

Effect? Element disappears after one second, but the test still waits for something. After 5 seconds test fails with
Timeout Exception! Why? Unfortunately, implicitWait is always associated with the driver, and the sequence of events is
rather undesired:

1. 0s - First explicitWait poll was made and implicitWait was triggered for the element. The element was found so
   implicitWait ended
2. 0.5s - Second explicitWait poll was made and implicitWait was triggered for the element. The element was found so
   implicitWait ended
3. 1s - Third explicitWait poll was made and implicitWait was triggered for the element. However, since the element has
   disappeared implicitWait doesn't end (it's 10 seconds)
4. 5s - Test times out due to explicitWait 5 seconds threshold

Not really cool, huh? Don't even think of manipulating those timers. Trust me, you don't want to debug every Timeout
Exception.

There is more. Imagine you have a huge suite with ~500 tests. The sloppy programmer has committed something bad, and you
have an obvious mistake on the main page. Feedback should be as fast as possible, but with implicitWait, every test will
most likely have a 10-second delay before failure. Even with concurrent test execution, your run will be really slow...

**3\. Explicit Waits**

We are getting closer to correct wait usage. ExplicitWait (example above) isn't bad but supports only a limited number
of ExpectedConditions. You can find all of them
on [the guru99 blog](http://www.guru99.com/implicit-explicit-waits-selenium.html). If you use them in your project I
suggest treating them as deprecated code. Changes aren't necessary but recommended.

**4\. Fluent Waits**  
Not yet FluentLenium, but we are almost there. Hopefully, you use it already in your Selenium project. We have to define
two things before using them:

Wait for parameters

{% highlight java %}
Wait<WebDriver> wait = new FluentWait<WebDriver>(driver)
        .withTimeout(5, TimeUnit.SECONDS)
        .pollingEvery(500, TimeUnit.MILLISECONDS)
        .ignoring(NoSuchElementException.class)
        .withMessage("Oops, element didn't disappear!");
{% endhighlight %}

Guava Predicate or Function

{% highlight java %}
Predicate<WebDriver> loadingElementDisappeared = new Predicate<WebDriver>() {
    public boolean apply(WebDriver driver) {
        return driver.findElements(By.id("disappearingelement")).size() = 0;
    }
};
{% endhighlight %}

Now if we want to wait for our loading element to disappear (assuming implicitWait was removed) we have to write:

{% highlight java %}
wait.until(loadingElementDisappeared);
{% endhighlight %}

Go back to the good test characteristic I have mentioned in a). There is a big difference in almost every aspect, don't
you think?

**5\. FluentLenium await() methods**  

Finally! :)

After this long entry, you can probably easily understand why FluentLenium await() methods are very useful. They
basically wrap all good things from selenium waiting methods and make one-liners. In my
previous [FluentLenium post](https://awesome-testing.com/2016/01/introducing-fluentlenium-1.html), I had already used
them. This method verifies that the Facebook login was successful.

{% highlight java %}
    public void verifySuccessfulLogin() {
        await().until(WAITER_SELECTOR_AFTER_LOGIN).areDisplayed();
    }
{% endhighlight %}

I love especially await().until(locator).isClickable() method and click() right after it's possible. I will redirect you
now to [FluentLenium await() readme](https://github.com/FluentLenium/FluentLenium#wait-for-an-ajax-call) where you can
check more examples. No need to be redundant.

**Demo time**

I'll give you something to play with at the end. This test clearly shows how important waitings are for Selenium. I bet
it would be hard for you to make it pass faster :)

{% highlight java %}
   private Predicate<Fluent> ajaxCallCompleted = new Predicate<Fluent>() {
        @Override
        public boolean apply(Fluent fluent) {
            return (Boolean) ((JavascriptExecutor) getDriver()).executeScript("return (window.jQuery != null) && (jQuery.active === 0);");
        }
    }
    
    private static final String URL = "https://resttesttest.com/";
    private static final String SUCCESS_TEXT = "HTTP 200 OK";
    
    private static final String AJAX_BUTTON_CSS = "#submitajax";
    private static final String ALERT_RESULT_CSS = ".alert-success";
    
    @Test
    public void ajaxCallTest() {
        goTo(URL);
        await().until(AJAX_BUTTON_CSS).isClickable();
        findFirst(AJAX_BUTTON_CSS).click();
        await().atMost(5000L).untilPredicate(ajaxCallCompleted);
        assertThat(findFirst(ALERT_RESULT_CSS).getText()).isEqualTo(SUCCESS_TEXT);
    }
{% endhighlight %}

PS1

As you can see on top [Pracownia Mondragor](https://pracowniamandragor.wordpress.com/)made me a new logo. Details about
that on [Awesome Book Reviews blog](http://awesome-bookreviews.blogspot.com/2016/03/blog-update-awesome-logo.html).

PS2

I'm looking for reviewers who can make my blog posts better when it comes to English language details. Contact me if you
want to help. I offer online recognition and a good book :)
