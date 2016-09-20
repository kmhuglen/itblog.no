---
layout: post
title: WSUS on non-domain computers
published: true
author: Knut Magne Huglen
comments: true
date: 2011-09-02 10:09:58
tags:
    - Registry
    - Windows
    - Windows Server
    - WSUS
categories:
    - it-pro
permalink: /912
---
Setting up WSUS and configuring your servers and clients trough Group Policy is a great way of controlling the patch level on your servers and clients. But there would sometime be reason to not join all clients or server to the domain, and then the policy will not configure the workgroup computers.

The windows update interface will not give you an option to configure the workgroup computer to contact your internal WSUS server. This would than have to be done by manually configuring the Windows Update service trough registry settings.

See **[Configure Automatic Updates using Registry Editor][1]** at Microsoft TechNet

Or a simple method is to export `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate` on a domain joined computer and import it on the workgroup computer.

**PS:** Remember to consider Client Side targeting when exporting.

 [1]: http://technet.microsoft.com/en-us/library/dd939844(WS.10).aspx