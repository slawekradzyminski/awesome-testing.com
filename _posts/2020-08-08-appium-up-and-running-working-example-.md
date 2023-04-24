---
title: Appium up and running (working example)
layout: post
permalink: /2020/08/appium-up-and-running-working-example
categories:
  - Mobile testing
tags:
  - mobile testing 
---

![](/images/blog/images-2.png)

**1\. Introduction**

A few weeks ago I introduced you to
multiple [Android testing tools](https://www.awesome-testing.com/2020/04/android-testing-tools.html). One of them (
Appium) was listed on top of the pyramid as the most powerful one. You can do almost everything with Appium, which makes
it the perfect choice for automating your E2E test regression.

In this article, I'd like to introduce you to the Appium setup and show a few examples which were just shared on
my [GitHub project](https://github.com/slawekradzyminski/appium-example).

**2\. Basic setup**

Mobile tests are difficult mostly because of complicated setup. Assuming you would use Java I recommend those tutorials:

- [Appium Installation guide for Windows](https://www.swtestacademy.com/appium-tutorial/) - swtestacademy
- [Appium Installation guide for Mac](https://www.swtestacademy.com/how-to-install-appium-on-mac/) - swtestacademy
- [Appium iOS test setup](https://medium.com/2359media/tutorial-automated-testing-on-ios-with-appium-test-ng-and-java-on-mac-bc115d0ec881) -
Medium
- [Appium Android test setup](https://medium.com/2359media/tutorial-automated-testing-on-android-and-ios-with-appium-testng-and-java-on-mac-210119edf323) -
Medium

After completing tutorials you should have all of those installed and working:

- Android Studio 
- XCode
- Android Emulator* iPhone Simulator
- Appium server

**3\. Applications**

So here is another hurdle. What do we test? I prepared my code examples for the following applications:

- [iOS](https://github.com/King-of-Spades/AppCenter-Samples/tree/master/Appium/iOS) (tested with iOS 13.5)
- [Android](https://github.com/King-of-Spades/AppCenter-Samples/tree/master/Appium/Android) (testing with API level 28)

**4\. Example project**

Having all of that up&running you can start the fun part: testing. You need to do the following steps:

- Download my [GitHub project](https://github.com/slawekradzyminski/appium-example) (requires Java 11)
- Run Appium server, Android Emulator, and iPhone Simulator
- Change paths to applications
in [config.properties](https://github.com/slawekradzyminski/appium-example/blob/master/src/main/resources/config.properties)
- For iOS tests you need to change spring.active.profiles value to iphone
- Run tests

**5\. Android tests overview**

For Android I have covered:

- Basic clicking via multiple activities
- Text input via classic API and [adb](https://developer.android.com/studio/command-line/adb)
- Screenshot taking example

{% highlight java %}
public class AndroidSwiftNotesApp extends ExampleFluentTest {

    private static final String SAMPLE_TITLE = "SampleTitle";
    private static final String SAMPLE_BODY = "SampleBody";

    @Page
    private SwiftNoteHomePage noteApp;

    @Test
    public void shouldCorrectlyAddNote() {
        noteApp
                .verifyIfIsLoaded()
                .verifyNoteCount(0)
                .clickAddNote()
                .addNote(SAMPLE_TITLE, SAMPLE_BODY)
                .verifyIfIsLoaded()
                .verifyNoteCount(1)
                .clickAddNote()
                .addNoteUsingAdb(SAMPLE_TITLE, SAMPLE_BODY, appiumDriver)
                .verifyIfIsLoaded()
                .verifyNoteCount(2);
    }

    @Test
    public void searchTest() {
        noteApp.search("FluentLenium");
    }

    @Test
    public void screenshotTest() throws IOException {
        File file  = ((TakesScreenshot)appiumDriver).getScreenshotAs(OutputType.FILE);
        FileUtils.copyFile(file, new File("Screenshot.jpg"));
    }

}
{% endhighlight %}

**6\. iOS tests overview**

For iOS I have covered:

- Basic clicking via multiple screens
- Text input via classic API
- Screenshot taking example

{% highlight java %}
public class IosUITestDemo extends ExampleFluentTest {

    @Page
    private HomePage homePage;

    @Test
    public void shouldCorrectlySwitchView() {
        homePage.clickAboutLink().verifyIfIsLoaded();
    }

    @Test
    public void shouldCorrectlyAddNote() {
        String noteName = "Sample Note";
        String noteDescription = "SampleNoteDescription";

        homePage
                .clickAddButton()
                .addName(noteName, noteDescription)
                .clickAboutLink()
                .verifyIfIsLoaded();
    }

    @Test
    public void screenshotTest() throws IOException {
        File file  = ((TakesScreenshot)appiumDriver).getScreenshotAs(OutputType.FILE);
        FileUtils.copyFile(file, new File("Screenshot.jpg"));
    }
}
{% endhighlight %}

Enjoy and have fun :)
