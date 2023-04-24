---
title: Continuous Security with OWASP Dependency Check
layout: post
permalink: /2017/02/continuous-security-with-owasp
categories:
  - Security
tags:
  - security 
---

[![Dependency Check logo](https://3.bp.blogspot.com/-_QCu2SgaOKI/WIzMr-ktv4I/AAAAAAAAClU/QFKEe7uMhBw0TCW_vaWTKWX5AsCUy4tTQCLcB/s400/pobrane%2B%25281%2529.png)](https://3.bp.blogspot.com/-_QCu2SgaOKI/WIzMr-ktv4I/AAAAAAAAClU/QFKEe7uMhBw0TCW_vaWTKWX5AsCUy4tTQCLcB/s1600/pobrane%2B%25281%2529.png)

## OWASP Dependency Check as a Continuous Security tool

In my [Continuous Testing post](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html) I introduced
you with an idea of Continuous Security. Those are automatic and repeatable tests which look for vulnerabilities in your
application. They should be run as often as possible (ideally after each commit). In case of failure build pipeline
should be stopped and person who introduced breaking changes should investigate what went wrong.

OWASP Dependency Check is one of the most popular continuous security tool. It takes your dependencies as an input,
compares them with local vulnerabilities database and produces vulnerability report as a output. Integration is pretty
easy and potential benefits significant - you may be surprised how often even most popular open source libraries have
security flaws.

## OWASP Top 10 A9 - Using components with known vulnerabilities

Why bother?

According to [OWASP Top 10](https://www.owasp.org/images/f/f8/OWASP_Top_10_-_2013.pdf) using components with known
vulnerabilities is widespread. Almost every application has those issues because most development teams don't pay much
attention to project dependencies. Libraries are often added to speed up development and never updated. This obviously
creates risks. Even famous Spring wasn't an exception
allowing [remote code execution](https://pivotal.io/security/cve-2016-4977) in it's Security OAuth.

Full range of weaknesses is possible (XSS, injections, broken access control, etc) and this subject shouldn't be
ignored.

## OWASP Dependency Check Maven plugin

Let's get down to business. I'll show you how to integrate OWASP Dependency Check using
my [AwesomeTesting GitHub project](https://github.com/slawekradzyminski/AwesomeTesting)where I store and maintain every
line of code ever written on this blog.

All you need to do is to add Dependency Check to your pom and run one command. For a start it's better to not integrate
it into Continuous Delivery pipeline. That's why I'm keeping it in separate _security_ profile.

{% highlight xml %}
        <profile>
            <id>security</id>
            <build>
                <plugins>
                    <plugin>
                        <groupId>org.owasp</groupId>
                        <artifactId>dependency-check-maven</artifactId>
                        <version>1.4.5</version>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>check</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </profile>
{% endhighlight %}

In order to start scanning run:

`mvn -P security dependency-check:check`

This is how console output should look like (first run would be significantly longer, because whole database
of [National Vulnerability Database](https://web.nvd.nist.gov/) has to be downloaded).

{% highlight txt %}
s.radzyminski@ ~/I/s/AwesomeTestingBlog> mvn -P security dependency-check:check
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Building AwesomeTesting 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- dependency-check-maven:1.4.5:check (default-cli) @ AwesomeTesting ---
[INFO] Checking for updates
[INFO] Download Started for NVD CVE - Modified
[INFO] Download Complete for NVD CVE - Modified  (2775 ms)
[INFO] Processing Started for NVD CVE - Modified
[INFO] Processing Complete for NVD CVE - Modified  (1712 ms)
[INFO] Begin database maintenance.
[INFO] End database maintenance.
[INFO] Check for updates complete (24674 ms)
[INFO] Analysis Started
[INFO] Finished Archive Analyzer (0 seconds)
[INFO] Finished File Name Analyzer (0 seconds)
[INFO] Finished Jar Analyzer (0 seconds)
[INFO] Finished Central Analyzer (2 seconds)
[ERROR] ----------------------------------------------------
[ERROR] .NET Assembly Analyzer could not be initialized and at least one 'exe' or 'dll' was scanned. The 'mono' executable could not be found on the path; either disable the Assembly Analyzer or configure the path mono. On some systems mono-runtime and mono-devel need to be installed.
[ERROR] ----------------------------------------------------
[INFO] Finished Dependency Merging Analyzer (0 seconds)
[INFO] Finished Version Filter Analyzer (0 seconds)
[INFO] Finished Hint Analyzer (0 seconds)
[INFO] Created CPE Index (1 seconds)
[INFO] Finished CPE Analyzer (2 seconds)
[INFO] Finished False Positive Analyzer (0 seconds)
[INFO] Finished Cpe Suppression Analyzer (0 seconds)
[INFO] Finished NVD CVE Analyzer (0 seconds)
[INFO] Finished Vulnerability Suppression Analyzer (0 seconds)
[INFO] Finished Dependency Bundling Analyzer (0 seconds)
[INFO] Analysis Complete (8 seconds)
[WARNING]

One or more dependencies were identified with known vulnerabilities in AwesomeTesting:

commons-collections-3.1.jar (commons-collections:commons-collections:3.1, cpe:/a:apache:commons_collections:3.1) : CVE-2015-6420
netty-3.5.7.Final.jar (cpe:/a:netty_project:netty:3.5.7, io.netty:netty:3.5.7.Final) : CVE-2014-3488
groovy-2.4.6.jar (cpe:/a:apache:groovy:2.4.6, org.codehaus.groovy:groovy:2.4.6) : CVE-2016-6497
selenium-opera-driver-3.0.1.jar (cpe:/a:opera:opera:3.0.1, org.seleniumhq.selenium:selenium-opera-driver:3.0.1) : CVE-2016-7152, CVE-2015-8960, CVE-2010-5227, CVE-2009-2068, CVE-2009-0915, CVE-2008-5679, CVE-2008-4795, CVE-2008-4794, CVE-2008-4696, CVE-2008-4695, CVE-2008-4293, CVE-2008-3172, CVE-2008-3079, CVE-2008-1764, CVE-2008-1761, CVE-2003-1561


See the dependency-check report for more details.


[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 36.077 s
[INFO] Finished at: 2017-02-02T18:10:24+01:00
[INFO] Final Memory: 31M/1337M
[INFO] ------------------------------------------------------------------------
{% endhighlight %}

As you can see few libraries I use in a project have known vulnerabilities. In addition, OWASP Dependency Check creates
nicely formatted .html report which you can see in full
details [here](http://htmlpreview.github.io/?https://github.com/slawekradzyminski/AwesomeTesting/blob/master/dependency-check-report.html).

Every single vulnerability is nicely explained with full description and links which contain detailed info. Affected
versions are also included. As a tester you would probably be interested in testing it - try upgrading
commons-collections to 3.2.2 and you would observe that vulnerability is no longer reported.

![](/images/blog/commons.jpg)

## Ignoring False Positives

Unfortunately as almost every test automation tool Dependency Check isn't free from false positives. After reading
detailed report you may conclude that your application doesn't use vulnerable code and suppress reporting for given
library. Here are two simple steps to ignore commons-collections 3.1 from reporting.

a) You need to create ignore file (it's created automatically by clicking suppress
on [.html report](http://htmlpreview.github.io/?https://github.com/slawekradzyminski/AwesomeTesting/blob/master/dependency-check-report.html))

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<suppressions xmlns="https://www.owasp.org/index.php/OWASP_Dependency_Check_Suppression"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="https://www.owasp.org/index.php/OWASP_Dependency_Check_Suppression ">
    <suppress>
        <notes><![CDATA[
   file name: commons-collections-3.1.jar
   ]]></notes>
        <gav regex="true">^commons-collections:commons-collections:.*$</gav>
        <cve>CVE-2015-6420</cve>
    </suppress>
</suppressions>
{% endhighlight %}

b) Provide a path in pom.xml

{% highlight xml %}
                    <plugin>
                        <groupId>org.owasp</groupId>
                        <artifactId>dependency-check-maven</artifactId>
                        <version>1.4.5</version>
                        <configuration>
                            <suppressionFile>src/test/resources/ignore.xml</suppressionFile>
                        </configuration>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>check</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
{% endhighlight %}

## OWASP Dependency Check in Continuous Integration

After full vulnerable dependencies investigation and ignoring false positives you can integrate OWASP Dependency Check
into Continuous Delivery pipeline. Let's say you want to be notified if new vulnerability had been discovered. Just add
_mvn dependency-check:check_as a build step and set failBuildOnCVSS value. Build would now fail if something new pops
out.

{% highlight xml %}
                    <plugin>
                        <groupId>org.owasp</groupId>
                        <artifactId>dependency-check-maven</artifactId>
                        <version>1.4.5</version>
                        <configuration>
                            <failBuildOnCVSS>1</failBuildOnCVSS>
                            <suppressionFile>src/test/resources/ignore.xml</suppressionFile>
                        </configuration>
                        <executions>
                            <execution>
                                <goals>
                                    <goal>check</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
{% endhighlight %}

[Visual .html](http://htmlpreview.github.io/?https://github.com/slawekradzyminski/AwesomeTesting/blob/master/dependency-check-report.html)
reporting can be nicely integrated into your CI tool. Here is example screenshot from TeamCity.

![](/images/blog/dependencycheck.jpg.png)

## Conclusions

OWASP Dependency Check is a quick win tool. With ever growing security concerns and free powerful hacking tools testers
would be pushed more and more into pentesting. You can start doing it today with my easy to adopt guide.

[Follow my project on GitHub](https://github.com/slawekradzyminski/AwesomeTesting) to be notified of new stuff before
all the others.

## Further Reading

[TestOps #3 - Continuous Testing](http://www.awesome-testing.com/2016/10/testops-3-continuous-testing.html)  
[OWASP Top 10](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project)  
[OWASP Continuous Security Testing](https://www.owasp.org/images/e/e1/OWASP-Continuous_Security_Testing.pdf)  
[OWASP Dependency Check](https://www.owasp.org/index.php/OWASP_Dependency_Check)  
[National Vulnerability Database - NIST](https://nvd.nist.gov/)
