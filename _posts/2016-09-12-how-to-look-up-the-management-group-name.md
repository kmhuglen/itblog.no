---
layout: post
title: How to Look Up the Management Group Name
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
Once you enter the management group name during set up you never see it again.  We really should be showing it on the title bar of the console, but until we get around to doing that here are a couple of ways you can look it up.

1) Use the ServiceManager or DWStagingAndConfig database and run the following query.  Keep in mind that the DW is a management group all by itself.

SELECT ManagementGroupName FROM \_\_MOMManagementGroupInfo\_\_

2) Look in the registry on a Service Manager or Data Warehouse management server.  Look for a key under this key:

HKEY\_LOCAL\_MachineSOFTWAREMicrosoftMicrosoft Operations Manager3.0Server Management Groups

Yes, it’s under the Operations Manager key.  Remember that this is a [common platform underlying multiple System Center products][1].

Blog post first appeared at blog.technet.com by Travis Wright

&nbsp;

 [1]: http://blogs.technet.com/servicemanager/archive/2009/01/14/the-system-center-platform-in-service-manager.aspx