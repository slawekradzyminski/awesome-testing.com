---
title: How to find & test CSS Selector using Chrome DevTools
layout: post
permalink: /2017/05/how-to-find-test-cssselector-using
categories:
  - Selenium
tags:
  - CSS selectors
  - selenium 
---

![](/images/blog/maxresdefault.jpg)

I was surprised after seeing a couple of questions regarding selector verification. This triggered me to create this
basic tutorial which hopefully would be useful for test automation newcomers.

As a prerequisite you need to download & install [Google Chrome](https://www.google.com/chrome/) browser (if not done
already).

## Chrome Developer Tools

Throughout this tutorial we would be using [Chrome DevTools](https://developer.chrome.com/devtools). In order to access
it you need to press the following keys in Chrome:  
a) Ctrl + Shift + I on Windows  
b) Cmd + Opt (Alt)+ I on Mac

You should see something like this (DevTools may also open at the bottom of the page)

![](/images/blog/awesometesting.png)

Assuming you are testing websites I strongly advise you to get familiar with every single option. We would be using only
two tabs:  
a) Elements - page source used to find proper selectors  
b) Console - browser console in which we would test our selectors

### CSS selector example A

Let's start with CSS selectors as they're usually shorter and easier to understand than XPath. Here are the steps to get
header CSS selector:

a) Rightclick on header (big A) and pick Inspect - this should highlight header element in Elements tab

![](/images/blog/inspect.png)

b) Rightclick on highlighted code and pick Copy -> Copy selector

![](/images/blog/selector.png)

c) Open Console tab

d) Type $$("") and paste copied selector between quotation marks. You should get something like this.

![](/images/blog/css.png)

Thanks to those nice Chrome DevTools features we were able to find selector and also test it. This is very helpful
especially when we have to deal with something more complicated.

### CSS selector example B
That was easy. Now let's assume we want to make sure number of displayed posts equals 5 on homepage. In order to achieve
that I need to find post title selector and make sure it occurs exactly 5 times. Here are steps:

a) Inspecting element in Chrome DevTools leads us here

![](/images/blog/posttitle.png)

b) I'm seeing that all titles are _h1_ and with class _post-title_. What's the selector then? It's _h1.post-title_

c) Verification in Console confirms that we have found proper selector.

![](/images/blog/posttitle2.png)

### How can I learn how to build CSS Selectors?
There is good and free tutorial available on w3schools site. It's extremely important for every aspiring test engineer
to get familiar with it. It's a must have... especially before job interview :)

[https://www.w3schools.com/cssref/css\_selectors.asp](https://www.w3schools.com/cssref/css_selectors.asp)

## Demo in Java

I have prepared working demo for my readers. You can find it on my
GitHub [Awesome Testing project.](https://github.com/slawekradzyminski/AwesomeTesting)I'm using FluentLenium and Page
Object Pattern framework. That's how the HomePage class would look like.

{% highlight java %}
@PageUrl("http://www.awesome-testing.com/")
public class HomePage extends FluentPage {

    @FindBy(css = "#Header1_headerimg")
    private FluentWebElement header;

    @FindBy(css = "h1.post-title")
    private FluentList<FluentWebElement> pageTitles;

    public void assertThatHeaderIsDisplayed() {
        assertThat(header).isDisplayed();
    }

    public void assertThatNumberOFTitlesEquals(int numberOfTitles) {
        assertThat(pageTitles).hasSize(numberOfTitles);
    }
}
{% endhighlight %}

And two simple tests. You should understand them instantly (at least that was my aim).

{% highlight java %}
public class BlogTest extends FluentTestNg {

    private static final int EXPECTED_NUMBER_OF_POSTS = 5;

    @Page
    private HomePage homePage;

    @Override
    public WebDriver newWebDriver() {
        return new ChromeDriver();
    }

    @Test
    public void shouldDisplayHeader() {
        homePage.go();
        homePage.assertThatHeaderIsDisplayed();
    }

    @Test
    public void shouldBeFivePosts() {
        homePage.go();
        homePage.assertThatNumberOFTitlesEquals(EXPECTED_NUMBER_OF_POSTS);
    }

}
{% endhighlight %}