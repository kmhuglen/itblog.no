---
layout: post
title: Disable the Windows 8 Metro look
published: true
author: Knut Magne Huglen
comments: true
date: 2011-09-15 11:09:10
tags:
    - Windows
    - Registry
categories:
    - it-pro
permalink: /920
---

Open registry and go to: `[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]`

Change the value of **RPEnabled** from **1** to **0** (zero).

Instantly the regular Windows Start Menu starts working. (But the metro start menu slides in and out as you press the Windows button). Log out and in again and the metro look has disappeared completely.
