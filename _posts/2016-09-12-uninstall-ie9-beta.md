---
layout: post
title: Uninstall Internet Explorer 9 Beta
published: true
author: kmhuglen
comments: true
date: 2010-10-05 01:10:27
tags:
    - Internet Explorer
    - Windows
categories:
    - it-pro
permalink: /416
---
If you for some reason should not want Internet Explorer 9 beta installed anymore, and can&#8217;t uninstall Internet Explorer 9 Beta through Installed Updates in Programs and Feature in the Control Panel you can use the following command line:

[code]FORFILES /P %WINDIR%servicingPackages /M Microsoft-Windows-InternetExplorer-\*9.\*.mum /c &#8220;cmd /c echo Uninstalling package @fname && start /w pkgmgr /up:@fname /norestart&#8221;[/code]

Must be run be run with elevated local administrator rights.