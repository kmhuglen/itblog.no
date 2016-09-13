---
layout: post
title: Scheduling WSUS Server Cleanup
published: true
author: kmhuglen
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

There is sadly no way of scheduling the clean up from the console &#8211; but can easily be achieved by running a powershell script from the Task Scheduler.

I recommend running the script at least once a month. For example after [Patch Tuesday][1].

**EDIT 17.08.2011:** When running the script trough the Task Scheduler, run as lokal administrator and remember to check of the Run with highest privileges.

[code]
  
[reflection.assembly]::LoadWithPartialName(&#8220;Microsoft.UpdateServices.Administration&#8221;)\`
  
| out-null
  
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer();
  
$cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope;
  
$cleanupScope.DeclineSupersededUpdates = $true
  
$cleanupScope.DeclineExpiredUpdates = $true
  
$cleanupScope.CleanupObsoleteUpdates = $true
  
$cleanupScope.CompressUpdates = $true
  
#$cleanupScope.CleanupObsoleteComputers = $true
  
$cleanupScope.CleanupUnneededContentFiles = $true
  
$cleanupManager = $wsus.GetCleanupManager();
  
$cleanupManager.PerformCleanup($cleanupScope);
  
[/code]

 [1]: http://en.wikipedia.org/wiki/Patch_Tuesday