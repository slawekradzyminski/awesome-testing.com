---
title: Continuous Security with Find-Sec-Bugs
layout: post
permalink: /2018/11/continuous-security-with-find-sec-bugs
categories:
  - Security
tags:
  - security 
---

![](/images/blog/16162781.png)

One of the hardest software quality characteristic to cover in automated tests is security. In
my [Automated testing vs manual testing - security perspective](https://www.awesome-testing.com/2017/03/automated-testing-vs-manual-testing.html)
blog I have mentioned that it's almost impossible to rely solely on automation, especially in cases where human factor
is involved (phishing, social engineering or plain ignorance).

It doesn't change the fact that some aspects of security can, or even should be automated. The easiest starting point is
dependencies. For Java projects, you can use OWASP Dependency Checker (see
my [blog post](https://www.awesome-testing.com/2017/02/continuous-security-with-owasp.html)for more details) and for npm
projects consider using [audit](https://docs.npmjs.com/cli/audit).

Certain vulnerabilities can be tested daily in the regression test suite. You can see here how
to [Automate your XSS tests with Selenium](https://www.awesome-testing.com/2017/11/automate-your-xss-tests-with-selenium.html).
The same tool can be used to
test [Unvalidated redirects](https://www.owasp.org/index.php/Unvalidated_Redirects_and_Forwards_Cheat_Sheet). I'll show
how on my blog soon.

Today I'd like to present you a tool called [Find Security Bugs](https://find-sec-bugs.github.io/)which
detects [128 bug patterns](https://find-sec-bugs.github.io/bugs.htm)just by reading your Java code. The described tool
can be used also
as [IntelliJ plugin](https://plugins.jetbrains.com/plugin/3847-findbugs-idea), [Sonar extension](https://github.com/spotbugs/sonar-findbugs),
but in this post, I'll cover [Maven integration](https://github.com/spotbugs/spotbugs-maven-plugin).

## Setup

Introducing find-sec-bugs plugin into your Maven projects is very simple. Here is the example configuration which you
need to add into pom.xml file.

{% highlight xml %}
    <build>
        <plugins>
            <plugin>
                <groupId>com.github.spotbugs</groupId>
                <artifactId>spotbugs-maven-plugin</artifactId>
                <version>3.1.8</version>
                <configuration>
                    <effort>Max</effort>
                    <threshold>Low</threshold>
                    <failOnError>true</failOnError>
                    <includeFilterFile>src/test/resources/spotbugs-security-include.xml
                    </includeFilterFile>
                    <excludeFilterFile>src/test/resources/spotbugs-security-exclude.xml
                    </excludeFilterFile>
                    <plugins>
                        <plugin>
                            <groupId>com.h3xstream.findsecbugs</groupId>
                            <artifactId>findsecbugs-plugin</artifactId>
                            <version>LATEST</version> <!-- Auto-update to the latest stable -->
                            <executions>
                                <execution>
                                    <phase>package</phase>
                                    <goals>
                                        <goal>check</goal>
                                    </goals>
                                </execution>
                            </executions>
                        </plugin>
                    </plugins>
                </configuration>
            </plugin>
        </plugins>
    </build>
{% endhighlight %}

The configuration is quite long, so let's explain few things. First of all, find-sec-bugs extends Maven extension which
is available for quite some time - [SpotBugs Maven Plugin](https://spotbugs.github.io/spotbugs-maven-plugin/). It's a
tool that reads your code and looks for bugs (bad practices, too complicated logic, code smells, etc).

Configuration values are explained on
the[extension page](https://spotbugs.readthedocs.io/en/stable/ant.html?highlight=threshold). The most useful is the
_failOnError_ flag which allows you to add described tool into Continuous Integration (CI) pipeline. If the analysis
finds a security bug the build fails.

The Analysis can be narrowed down to scope which interests us. Here we focus only on security.

spotbugs-security-include.xml will look like this:

{% highlight xml %}
<FindBugsFilter>
    <Match>
        <Bug category="SECURITY"/>
    </Match>
</FindBugsFilter>
{% endhighlight %}

And spotbugs-security-exclude.xml will look like this:

{% highlight xml %}
<FindBugsFilter>
</FindBugsFilter>
{% endhighlight %}

Finally, there is findsecbugs-plugin which we trigger in the following way:

a) CI purposes 

`mvn package -DskipTests=true findbugs:check`

b) Verification purposes (human-readable report will be generated after triggering this command)

`mvn findbugs:gui`

As usual, I have added every piece of code into
my [Github project](https://github.com/slawekradzyminski/AwesomeTesting/commit/293b152920975af246699f5b74a2ad2e581f8a63).

## Demo

If you try to run mvn commands in my projects you won't be able to observe anything interesting. The final report would
be empty meaning there are no security vulnerabilities in analyzed code.

To observe find-sec-bugs in action let's download [OWASP WebGoat](https://github.com/WebGoat/WebGoat)project. It's made
insecure by design so we expect to find something this time.

Now do few things:

a) Run `mvn clean install -DskipTests=true` in whole WebGoat project

b) Go to `cd webgoat-lessons/insecure-deserialization`

c) Update pom.xml as mentioned in point 2.

d) Add spotbugs-security-include.xml and spotbugs-security-exlude.xml files to proper paths (they need to match pom.xml
configuration)

e) Run `mvn findbugs:gui`

You should see report like this. As you can see the presented tool was able to find a bug in tested module.

![](/images/blog/serialisation.png)

## Credits

The following blog post was inspired
by [Michał Kowalski TestWarez presentation](https://www.testwarez.pl/dyi-regular-security-audit-without-pentesters/).
Thanks :)
