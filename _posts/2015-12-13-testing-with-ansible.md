---
title: Testing with Ansible
layout: post
permalink: /2015/12/testing-with-ansible
categories:
  - TestOps
tags:
  - testing
  - orchestration
  - testops
  - test automation
  - testing tools
  - automation
  - ansible 
---

![](/images/blog/CONTINUOUS-DELIVERY-2.png)

IEEE Spectrum has recently posted an article
about [Yahoo resigning from the QA team](http://spectrum.ieee.org/view-from-the-valley/computing/software/yahoos-engineers-move-to-coding-without-a-net).
After that maneuver quality of the final product not only didn't degrade but actually improved. Of course, if we delve
deeper into the article we will realize that the products got better after continuous delivery introduction (image
credit to[www.cloudofit.com](http://www.cloudofit.com/)) and the QA team wasn't entirely to blame. However, that's a
clear signal to old school testers that programming/scripting skills are now necessary.

One of my favorite tools that support Continuous Delivery (or Deployment if we assume what deploy to production is
automatic) is [Ansible](http://www.ansible.com/how-ansible-works). This simple automation agent allows us to execute
commands on external hosts via plays, which can later be organized to playbooks (list of plays). This is how example
playbook looks like:

{% highlight yml %}

- hosts: droplets
  tasks:
    - name: Installs nginx web server
      apt: name=nginx force=yes update_cache=true

    - name: start nginx
      service: name=nginx state=started
{% endhighlight %}

What is this playbook doing?

a) it checks hosts file for `[droplets]` string and connects to IP addresses below. Hosts file example:

{% highlight yml %}
[droplets]
192.168.0.2
192.168.0.3
[webservers]
192.168.3.222
{% endhighlight %}

b) apt-get update is called (`update_cache=true`)  

c) `apt-get install nginx` is called with automatic confirmation (`name=nginx force=yes`)  

d) nginx service is started  
  
With very few lines we were able to install the necessary applications on two hosts. Imagine how much time you'll save if the number of machines would be bigger. Probably you have already realized how powerful Ansible can it be to testing, but let me give you a few more examples:  
  
* Environment setup (see example above)  
* Updating app configuration on all testing servers  

{% highlight yml %}
- hosts: test_machines
  tasks:
    - name: Update config
      template: src=config.xml.j2 dest={{ app_folder }}/config.xml
{% endhighlight %}

* Jenkins / Selenium Grid / Selenium nodes auto-configuration
* Smoke tests after prod deployment

{% highlight yml %}
- hosts: PROD_machines
  tasks:
    - name: Check service
      service: name=vsftpd state=started
{% endhighlight %}


* Running commands and checking the output 

{% highlight yml %}
- hosts: test_machines
  tasks:
    - name: Run X
      shell: usr/bin/somefancycommand
      register: cmd_result

    - name: assert results
      that: "not ready not in cmd_result.stderr"
{% endhighlight %}

Free knowledge:  

*   [http://tomoconnor.eu/blogish/getting-started-ansible](http://tomoconnor.eu/blogish/getting-started-ansible)
*   [https://serversforhackers.com/an-ansible-tutorial](https://serversforhackers.com/an-ansible-tutorial)
*   [http://ryaneschinger.com/blog/ansible-quick-start/](http://ryaneschinger.com/blog/ansible-quick-start/)
*   [http://docs.ansible.com/ansible/intro\_getting\_started.html](http://docs.ansible.com/ansible/intro_getting_started.html)
