---
layout: post
title: Internet Explorer Compatibility View
published: true
author: Knut Magne Huglen
comments: true
date: 2010-11-24 08:11:22
tags:
    - Group Policy
    - Windows
categories:
    - it-pro
permalink: /649
---
I've been working on deploying Internet Explorer 8 recently, and came over some interesting information on how to simplify deployment regarding old web sites that can not run in Internet Explorer 8.0 Standard mode and where vendors either will not or are unable to fix the issue.

First the annoying part. MS has given us a set of group policy settings to help with the transformation to Internet Explorer 8. They are available to both user and machine under *\Windows Components\Internet Explorer\Compatibility View*. [Read more on Group Policy and Internet Explorer 8 here][1]. And the setting I hoped would solve my deployment issues was the *Use Policy List of Internet Explorer 7 Sites*, but I could get it to work properly. After some troubleshooting I concluded with the reason to be that you can only specify TLD and not sub-domains or URLs. [Read in more detail someone experiencing the same behavior on the TechNet forum.][2] I have not found any official documentation confirming it, but my own test and the one described on the TechNet forum was god enough for me.

Secondly I look to other solution and stubbled over [Advanced solutions: Some Web sites may not be displayed correctly or work correctly in Windows Internet Explorer 8][3] from Microsoft Support describing 5 methods for configuring a web site to be viewed in Internet Explorer 7 Compatibility View. So I started reading and after a few minutes I could not believe how easy it is to configure a web site, a specific folder or just a single page, regardless of if it is running on IIS6, IIS7 or Apache or other web server for that mater, to tell Internet Explorer 8 to view the page with the Internet Explorer 7 Compatibility View. See [Implementing the META Switch on Apache][4] from the MSDN Library for a detail description.

Then when I came home i came to think about this blog, and an annoying bug either in WordPress or Internet Explorer 9 Beta making the uploading of media to my blog, not viewed properly in Internet Explorer 9 without pressing the Compatibility View button. I gave it some troubleshooting and came over more [related information from the IE Blog on msdn.com][5] see especially the good overview on how to [Determining Document Mode diagram for IE9][6]

And now I RELLY can not see why more vendors do not use this information to make their web applications at least be viewed in the right Document Mode as the site or application require. It would solve the issue with old web sites not being updated but give them more time and help the IT Administrators to be able to upgrade to a better and more secure web browser.

[1]: http://technet.microsoft.com/en-us/library/cc985351.aspx
[2]: http://social.technet.microsoft.com/Forums/en/winserverGP/thread/c6da10bb-3f5f-46a8-a11b-f9264ef20ff0
[3]: http://support.microsoft.com/kb/968499
[4]: http://msdn.microsoft.com/en-us/library/cc817573.aspx
[5]: http://blogs.msdn.com/b/ie/archive/2010/06/16/ie-s-compatibility-features-for-site-developers.aspx
[6]: http://ieblog.members.winisp.net/misc/How%20IE9%20Determines%20Document%20Mode.png