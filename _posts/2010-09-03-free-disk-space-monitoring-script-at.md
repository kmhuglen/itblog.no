---
layout: post
title: E-mail alert on Low free disk space
published: true
author: Knut Magne Huglen
comments: true
date: 2010-09-03 07:09:17
tags:
    - VBScript
    - PowerShell
categories:
    - it-pro
permalink: /358
---
This is a simple script for checking the amount of free space on logical disk volume, and send e-mail if it gets below a specified value. If you want to schedule it to run once a day every morning, place the file somewhere on the local drive and run the the following command:

`AT 05:00 <path>\FreeDiskSpace.vbs`

Change `<path>` to where you placed the file and change the time to whenever you want the script to check the drives.

Change the variable inside the file to match your environment. You will have to change at least the `strEmailAddressTO` and `strSMTPServerName`. And you would probably want to tune `CheckDiskVolume` to match your environment. Sample script below will send e-mail if C: drive gets below 5 GB and/or if D: drive gets below 10 GB. You can add as many `CheckDiskVolume` lines as you would like.

The script will requires that a remote SMTP relay server exist on your network. If you would like to use a SMTP server installed local on the server, remove the line containing `objEmail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = strSMTPServerName` from the SendEmail sub function.

PS: You will find the script made in PowerShell at the bottom of the post.

**File: FreeDiskSpace.vbs**

<script src="https://gist.github.com/kmhuglen/226f8df51c3c8dd832b3904c1c3408ad.js"></script>