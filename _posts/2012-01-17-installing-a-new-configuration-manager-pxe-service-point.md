---
layout: post
title: Installing a new Configuration Manager PXE service point
published: true
author: Knut Magne Huglen
comments: true
date: 2012-01-17 05:01:03
tags:
    - Configuration Manager
    - PowerShell
    - System Center
categories:
    - it-pro
permalink: /1061
---
This blog explains how to install and troubleshoot a new Configuration Manager PXE service point. And how to make all needed packages available for the task sequence on the new distributing point.

In short this is what I do. (I already have a server configured with ConfigMgr and a ConfigMgr distribution point at the new site)

  * Install the **Windows Deployment Service** role on the Server.
  * Setup a **ConfigMgr PXE service point** on the Server.
  * Deploy **both (x86/x64) boot images** to the new PXE service point
  * Deploy all **referenced packages in a task sequence** to the distribution point.

There is a lot of good blog post on this already.

[J.C. Hornbeck][1] has a blog post on **How To Properly Install And Set Up A New Instance Of WDS And A PXE Service Point** in his blog post [Troubleshooting the PXE Service Point and WDS in Configuration Manager 2007][2]

You can then use the **PowerShell** script from [Michael Niehaus][3] to add distribution point to all referenced packages in a task sequence. I personally use the **updated script** from [jscheffelmaer][4] that can be downloaded from his blog post **[Checking Task Sequence Package References for a DP][5].**

Place SCCM.psm1 in the module folder

* User: `%userprofile%\Documents\WindowsPowerShell\`
* Computer: `%systemroot%\SysWOW64\WindowsPowerShell\v1.0\Modules\myModule`

on the computer you are running the **CheckTSPrompt1.3.ps1** script from. You would need to start the powershell with **elevated rights** to alter the execution policy to allow running of unsigned script.

`Set-ExecutionPolicy RemoteSigned`
  
`copy .SCCM.psm1 $pshome\Modules\SCCM\SCCM.psm1`

_Se screenshots of the powershell script at [jscheffelmaer][4] blog post._

[CheckTSPrompt1.3.1.ps1][6] and [SCCM.psm1][7] (the same script as provided by [jscheffelmaer][4] just modified the size of gui)

**EDIT: 2012-03-20:** If there already is a distribution point with all the needed packages, you could with an easy wizard copy all packages distributed to that distribution point to another. Follow the instruction on TechNet for the use of the Configuration Manager Console built-in Copy Package Wizard on How to Copy Multiple Packages to One Distribution Point

 [1]: http://blogs.technet.com/13909/ProfileUrlRedirect.ashx
 [2]: http://blogs.technet.com/b/configurationmgr/archive/2011/01/05/troubleshooting-the-pxe-service-point-and-wds-in-configuration-manager-2007.aspx
 [3]: http://social.technet.microsoft.com/profile/michael%20niehaus/
 [4]: http://myitforum.com/cs2/login.aspx?ReturnUrl=%2fcs2%2fmembers%2fjscheffelmaer.aspx
 [5]: http://myitforum.com/cs2/blogs/jscheffelmaer/archive/2010/04/27/update-checking-task-sequence-package-references-for-a-dp.aSpx
 [6]: https://gist.github.com/kmhuglen/e32d480fd718376bce25b3a2a113be3b
 [7]: https://gist.github.com/kmhuglen/32d06effa630feaacfd8210b92f4ee1e