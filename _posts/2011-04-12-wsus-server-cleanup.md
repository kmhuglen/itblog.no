---
layout: post
title: Scheduling WSUS Server Cleanup
published: true
author: Knut Magne Huglen
comments: true
date: 2011-04-12 08:04:51
tags:
    - PowerShell
    - WSUS
categories:
    - it-pro
permalink: /805
image:
    feature: wsus_snapshot00.jpg
---
If your running an WSUS server, and especially if your syncing definition updates, disk space can/will become a problem.

By performing the Server Cleanup Wizard under Options in the Update Service Console you can clean up your server by removing expired, obsolete and superseded updates. You can also compress the updates, remove obsolete computers and so on.

There is sadly no way of scheduling the clean up from the console - but can easily be achieved by running a powershell script from the Task Scheduler.

I recommend running the script at least once a month. For example after [Patch Tuesday][1].

**EDIT 17.08.2011:** When running the script trough the Task Scheduler, run as lokal administrator and remember to check of the Run with highest privileges.

<script src="https://gist.github.com/kmhuglen/676af11e5ffb3d559c6ad0f1cb2674f5.js"></script>

 [1]: http://en.wikipedia.org/wiki/Patch_Tuesday