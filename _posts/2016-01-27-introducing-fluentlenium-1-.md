---
title: Introducing FluentLenium 1
layout: post
permalink: /2016/01/introducing-fluentlenium-1
categories:
  - Selenium
tags:
  - selenium
  - fluentlenium
  - test automation
  - UI testing 
---

![](/images/blog/developer.png)

I had started a new initiative recently - Facebook group [Technology Books](https://www.facebook.com/groups/booksIT/).
Feel free to join if you look for reading recommendations or want to share your thoughts. Because of that, I had to
accept hundreds of joining requests from many people. (Un)fortunately, repetitive tasks quickly bore me, so I figured
out it's the perfect opportunity to not only automate it but also to feature it on this blog. Here is my journey, which
now becomes our journey.

We are going to use Java and [FluentLenium](https://github.com/FluentLenium/FluentLenium) framework which nicely extends
the famous [Selenium WebDriver](http://www.seleniumhq.org/projects/webdriver/). This project is being actively developed
right now and you should really try it. Naming conventions used in FluentLenium are really intuitive, and writing tests
becomes really easy and
rewarding. [Documentation](https://github.com/FluentLenium/FluentLenium/blob/master/README.markdown) is quite nice too.

At first, we need to clearly define what we want to achieve. The scenario looks like that:

_As a logged in [Technology Books](https://www.facebook.com/groups/booksIT/) admin I want to accept all existing joining
requests._

So let's get started. At first, we need to add Maven dependency for our project. I'm going to use TestNG because of it'
s [powerful annotations](http://www.softwaretestinghelp.com/testng-annotations-in-selenium/):

{% highlight xml %}
<dependency>
    <groupId>org.fluentlenium</groupId>
    <artifactId>fluentlenium-testng</artifactId>
    <version>1.0.0</version>
    <scope>test</scope>
</dependency>
{% endhighlight %}

Having [Page Object Pattern](http://martinfowler.com/bliki/PageObject.html) in mind we need to code the following
things:

- Make FacebookLogOutPage class  
- Create logic for the non-version-tracked user.properties file (which will contain Facebook login and password)
- Write authentication method with @BeforeMethod annotation
- Make FacebookApproveGroupRequestPage class
- Write accept request methods with @Test annotation

**Coding begins here!**

**1**. If you are familiar with Selenium WebDriver you'll be surprised to realize that FleuntLenium allows CSS Selectors
only. I prefer them over XPath anyway, because they
are [faster and more readable](http://elementalselenium.com/tips/32-xpath-vs-css). If you like identifying elements via
id just add **#** sign, and via class add **.** sign. Using developer tools console makes element identification very
easy. See the example screenshot below.

![](/images/blog/Screenshot%2B2016-01-17%2B09.03.34.png)

So FacebookLoggedOutPage.class may look like this:

{% highlight java %}
package org.fluentlenium.sample.pages;

import org.fluentlenium.core.FluentPage;

  public class FacebookLoggedOutPage extends FluentPage {

  @Override
  public String getUrl() {
    return "https://www.facebook.com";
  }

  private static final String WAITER_SELECTOR_AFTER_LOGIN = ".mentionsTextarea";
  private static final String LOGIN_FIELD = "#email";
  private static final String PASS_FIELD = "#pass";
  private static final String SIGN_IN_BUTTON = "#loginbutton";

  public void login(String email, String password) {
    fill(LOGIN_FIELD).with(email);
    fill(PASS_FIELD).with(password);
    find(SIGN_IN_BUTTON).first().click();
  }

  public void verifySuccessfulLogin() {
    await().until(WAITER_SELECTOR_AFTER_LOGIN).areDisplayed();
  }

}
{% endhighlight %}

**2**. Now we need a way to store our user credentials locally. To achieve that we need users.properties file.
Obviously, I didn't share my credentials here

{% highlight properties %}
email=www.awesome-testing.blogspot.com
password=wwww.awesome-bookreviews.blogspot.com
{% endhighlight %}

And LoadProperties method which loads them to our code:

{% highlight java %}
package org.fluentlenium.sample.support;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

  public class LoadProperties {

  public static final String PATH_TO_PROPERTIES = "/Users/s.radzyminski/IdeaProjects/slawek/FluentLenium/fluentlenium-testng/src/test/java/org/fluentlenium/sample/resources/user.properties";

  public static Properties user = loadProperties(PATH_TO_PROPERTIES);

  private static Properties loadProperties(String filePath) {
    Properties properties = new Properties();
    try {
        FileInputStream f = new FileInputStream(filePath);
        properties.load(f);
    } catch (IOException e) {
        e.printStackTrace();
    }
    return properties;
  }

}
{% endhighlight %}

**3**. We are ready for the authentication method which will log in our admin to Facebook. Note how intuitive the syntax
is and how easy the code looks

{% highlight java %}

   private FacebookLoggedOutPage fbLogOutPage;
   
   @BeforeMethod
    public void authenticate() {
        fbLogOutPage = createPage(FacebookLoggedOutPage.class);
        fbLogOutPage.go();
        fbLogOutPage.login(EMAIL, PASSWORD);
        fbLogOutPage.verifySuccessfulLogin();
    }
{% endhighlight %}

**4**. Ok, we are already logged in so we need to go for GroupApprovePage now...

{% highlight java %}
package org.fluentlenium.sample.pages;

import org.fluentlenium.core.FluentPage;

  public class GroupApprovePage extends FluentPage {

  private static final String APPROVE_ALL_BUTTON = "[rel=async-post]";
  private static final String CONFIRM_APPROVAL_BUTTON = ".layerConfirm";

  @Override
  public String getUrl() {
    return "https://www.facebook.com/groups/booksIT/requests/?notif_t=group_r2j";
  }

  @Override
  public void isAt() {
    await().until(APPROVE_ALL_BUTTON).isPresent();
  }

  public void approveAll() {
    find(APPROVE_ALL_BUTTON).first().click();
  }

  public void confirm() {
    await().until(CONFIRM_APPROVAL_BUTTON).isPresent();
    findFirst(CONFIRM_APPROVAL_BUTTON).click();
  }

}
{% endhighlight %}

**5**. ...And Accept all requestors. Here is how it looks like finally:

{% highlight java %}
package org.fluentlenium.sample.tests;

import org.fluentlenium.adapter.FluentTestNg;
import org.fluentlenium.sample.pages.FacebookLoggedOutPage;
import org.fluentlenium.sample.pages.GroupApprovePage;
import org.fluentlenium.sample.support.LoadProperties;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

public class FacebookTests extends FluentTestNg {

    private FacebookLoggedOutPage fbLogOutPage;
    private GroupApprovePage groupApprovePage;

    private static final String EMAIL = LoadProperties.user.getProperty("email");
    private static final String PASSWORD = LoadProperties.user.getProperty("password");

    @BeforeMethod
    public void authenticate() {
        fbLogOutPage = createPage(FacebookLoggedOutPage.class);
        fbLogOutPage.go();
        fbLogOutPage.login(EMAIL, PASSWORD);
        fbLogOutPage.verifySuccessfulLogin();
    }

    @Test
    public void acceptAllPokemons() {
        groupApprovePage = createPage(GroupApprovePage.class);
        groupApprovePage.go();
        groupApprovePage.isAt();
        groupApprovePage.approveAll();
        groupApprovePage.confirm();
    }

}
{% endhighlight %}

Please take a closer look at how strong FluentLenium is when it comes to dynamic waiting. This is one of the most
important elements when it comes to testing automation projects. There is a lot of bad information about how we should
avoid timeout exceptions on public forums and blogs (even on the stack). Please get familiar with Chapter 4
of [Mastering Selenium WebDriver](http://www.amazon.com/Mastering-Selenium-WebDriver-Mark-Collin/dp/1784394351) if you
have problems with them. Googling may lead you to adopt bad practices.

Code from steps 1-5 is available on my [GitHub](https://github.com/slawekradzyminski/awesome-testing.blogspot.com).

Bonus content:

a) I'm really happy after being featured as a new face of polish testing
by [testerzy.pl](http://www.testerzy.pl/baza-wiedzy/ludzie-i-trendy-w-polskim-testowaniu-2016). Huge motivation boost to
keep up blogging work.

b) You may have noticed (1) in the title. I'll continue FluentLenium / test automation series in the future. I'll
discuss why this test isn't exactly perfect. Or maybe do you know already? Please let me know in the comment section.

c) Main image credit:[www.testautomationfx.com](http://www.testautomationfx.com/)
