---
layout: post
title: Lookup the Management Group name
published: true
author: kmhuglen
comments: true
date: 2010-01-25 12:01:33
tags:
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /3732
---
Once you enter the *Management Group* name during setup you never see it again. We really should be showing it on the title bar of the console, but until we get around to doing that here are a couple of ways you can look it up.

* Use the ServiceManager or DWStagingAndConfig database and run the following query. Keep in mind that the DW is a management group all by itself. `SELECT ManagementGroupName FROM __MOMManagementGroupInfo__`

* Look in the registry on a Service Manager or Data Warehouse management server. Look for a key under this key `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\Server Management Groups` Yes, it’s under the Operations Manager key.

Service Manager and Operations Manager share a common platform.

Blog post first appeared at [blog.technet.com][1] by Travis Wright

[1]: https://blogs.technet.microsoft.com/servicemanager/2010/01/25/how-to-look-up-the-management-group-name/
