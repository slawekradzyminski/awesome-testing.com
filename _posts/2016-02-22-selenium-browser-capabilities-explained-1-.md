---
title: Selenium - Browser Capabilities explained 1
layout: post
permalink: /2016/02/selenium-browser-capabilities-explained
categories:
  - Selenium
tags:
  - browser capabilities
  - selenium
  - firefox
  - test automation
  - UI testing
  - chrome 
---

![](/images/blog/is-this-selenium-ide.png)

In my first post about
Selenium ([FluentLenium](http://awesome-testing.blogspot.com/2016/01/introducing-fluentlenium-1.html) series will focus
on extension features only), I decided to tackle Chrome & Firefox capabilities which allow us to preconfigure browser
settings before tests. This seemed quite easy at the beginning, but I quickly realized that a huge amount of information
available via Google is outdated. Hopefully, this post will make things straight.

**Prerequisite** - you need to understand which method initializes WebDriver in your project in order to override it.

## Chrome

Only this [piece of the documentation](https://sites.google.com/a/chromium.org/chromedriver/capabilities)tells us how to
properly configure the browser before running tests. It's done
via [Chrome Options](https://github.com/SeleniumHQ/selenium/blob/master/java/client/src/org/openqa/selenium/chrome/ChromeOptions.java).
Due to legacy reasons, desiredCapabilities still has to be initialized, which makes the code somehow weird. Here it is (
with my formatting):

{% highlight java %}
private static final String PREFS = "prefs";

    @Override
    public WebDriver getDefaultDriver() {
        return new ChromeDriver(getChromeCapabilities());
    }

    private DesiredCapabilities getChromeCapabilities() {
        DesiredCapabilities capabilities = DesiredCapabilities.chrome();
        capabilities.setCapability(ChromeOptions.CAPABILITY, getChromeOptions());
        return capabilities;
    }

    private ChromeOptions getChromeOptions() {
        ChromeOptions options = new ChromeOptions();
        options.addArguments(getChromeSwitches());
        options.setExperimentalOption(PREFS, getChromePrefs());
        return options;
    }
{% endhighlight %}

As you can see above two methods preconfigure our Chrome (description
via [Javadoc](https://github.com/SeleniumHQ/selenium/blob/master/java/client/src/org/openqa/selenium/chrome/ChromeOptions.java)):

- _addArguments()_ which adds additional command-line arguments to be used when starting Chrome

- _addExperimentalSettings()_ which sets an experimental option. Useful for new ChromeDriver options not yet exposed
through the ChromeOptions API

We may also add extensions via _add extensions()_ method

This is when the easy part ends and Googling begins. For unknown reasons lists of available arguments (called very often
switches) and experimental settings aren't linked on the
official [chromedriver site](https://sites.google.com/a/chromium.org/chromedriver/getting-started). With some
determination I was able to obtain them:

- Arguments (switches) - [peter.sh](http://peter.sh/experiments/chromium-command-line-switches/)

- Experimental
options - [src.chromium.org](https://src.chromium.org/viewvc/chrome/trunk/src/chrome/common/pref_names.cc?view=markup)

My implementation with example values - feel free to do some code review :)

{% highlight java %}
public interface ChromeSwitchesInt {
    String START_FULLSCREEN = "start-fullscreen";
    String ALLOW_INSECURE_CONTENT = "allow-running-insecure-content";
    String INCOGNITO = "incognito";
    String IGNORE_CERTIFICATE_ERRORS = "--ignore-certificate-errors";
}
{% endhighlight %}

{% highlight java %}
    private static final String BROWSER_NOTIFICATIONS = "profile.managed_default_content_settings.notifications";
    private static final short DISABLED = 2;
 
    /**
     * Full list of available prefs - https://src.chromium.org/viewvc/chrome/trunk/src/chrome/common/pref_names.cc?view=markup
     *
     * @return prefs
     */
    private Map<String, Object> getChromePrefs() {
        Map<String, Object> chromePrefs = new HashMap<>();
        chromePrefs.put(BROWSER_NOTIFICATIONS, DISABLED);
        return chromePrefs;
    }

    /**
     * Full list of available switches - http://peter.sh/experiments/chromium-command-line-switches/
     *
     * @return switches List
     */
    private List<String> getChromeSwitches() {
        List<String> chromeSwitches = new ArrayList<>();
        chromeSwitches.add(ChromeSwitchesInt.INCOGNITO);
        chromeSwitches.add(ChromeSwitchesInt.ALLOW_INSECURE_CONTENT);
        chromeSwitches.add(ChromeSwitchesInt.IGNORE_CERTIFICATE_ERRORS);
        chromeSwitches.add(ChromeSwitchesInt.START_FULLSCREEN);
        return chromeSwitches;
    }
{% endhighlight %}

## Demo

Comment this line & Try running
my [FluentLenium](http://awesome-testing.blogspot.com/2016/01/introducing-fluentlenium-1.html) test (or just log in on
Facebook via Selenium).

{% highlight java %}
chromePrefs.put(BROWSER_NOTIFICATIONS, DISABLED);
{% endhighlight %}

You should see this popup/notification and test failure. An experimental option from above solves this problem.

![](/images/blog/Screenshot%2B2016-02-21%2B23.06.23.png)

## Part II - Firefox

Update 16.09.2017

Handling FirefoxDriver changed in 2017. For non-deprecated code take a look at my new post:

[Firefox Selenium Browser Capabilities explained](https://www.awesome-testing.com/2017/09/firefox-selenium-browser-capabilities.html)
