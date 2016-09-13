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
[][1]

This simple sample code can be used to create beautiful user interface in your PowerShell script.

[PSWPFExample.ps1][2]

Running SP scripts utilizing WPF forms on machines with only PowerShell version 2, one has to specify the -STA argument to start the PowerShell process as Single Threaded Apartment. This is the default in version 3 of PowerShell.

powershell.exe -Version 2 -STA -Noprofile -ExecutionPolicy Bypass ".\PSWPFExample.ps1"


 [1]: https://itblog.no/wp-content/uploads/PSWPFExample.png
 [2]: https://itblog.no/wp-content/uploads/PSWPFExample.ps1_.txt