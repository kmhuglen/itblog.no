---
layout: post
title: >
    Send-MailMessage command with conditional Cc and Bcc
    arguments
published: true
author: Knut Magne Huglen
comments: true
date: 2015-08-07 02:08:42
tags:
    - PowerShell
categories:
    - it-pro
permalink: /5861
---
This is an example of how you could write a PowerShell script sending mail message using the Send-MailMessage command with conditional Cc and Bcc arguments.

Sometime my script will define Cc and Bcc mail addresses based on a condition earlier in the script. Instead of creating a long IF statement checking the variables and then running a different set of argument on the command, I use the example below to have the Cc and Bcc argument added to the Send-MailMessage arguments set only if they exist.

<script src="https://gist.github.com/kmhuglen/858c4fdc92088fea8046.js"></script>