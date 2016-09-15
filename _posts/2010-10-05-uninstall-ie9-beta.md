---
layout: post
title: Uninstall Internet Explorer 9 Beta
published: true
author: Knut Magne Huglen
comments: true
date: 2010-10-05 01:10:27
tags:
    - Windows
categories:
    - it-pro
permalink: /416
---
If you for some reason should not want Internet Explorer 9 beta installed anymore, and can not uninstall Internet Explorer 9 Beta through Installed Updates in Programs and Feature in the Control Panel you can use the following command line:

```
FORFILES /P %WINDIR%\servicingPackages /M Microsoft-Windows-InternetExplorer-\*9.\*.mum /c "cmd /c echo Uninstalling package @fname && start /w pkgmgr /up:@fname /norestart"
```

Must be run be run with elevated local administrator rights.