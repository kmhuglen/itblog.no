---
layout: post
title: Beautiful User Interface with PowerShell
published: true
author: kmhuglen
comments: true
date: 2015-02-12 02:02:57
tags:
    - PowerShell
categories:
    - it-pro
permalink: /5668
image:
    feature: SamlePowerShellGUI.png
---
![](/assets/2015-02-12_PSWPFExample.png)

This simple sample code can be used to create beautiful user interface in your PowerShell script.

<script src="https://gist.github.com/kmhuglen/9a8fffe7fde1f5a7f141e4b74d40bb81.js"></script>

Running SP scripts utilizing WPF forms on machines with only PowerShell version 2, one has to specify the -STA argument to start the PowerShell process as Single Threaded Apartment. This is the default in version 3 of PowerShell.

powershell.exe -Version 2 -STA -Noprofile -ExecutionPolicy Bypass ".\PSWPFExample.ps1"