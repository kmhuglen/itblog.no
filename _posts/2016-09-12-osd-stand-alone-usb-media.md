---
layout: post
title: 'OSD - Stand-alone USB Media'
published: true
author: kmhuglen
comments: true
date: 2012-07-24 11:07:38
tags:
    - Configuration Manager
    - System Center
    - Windows
categories:
    - it-pro
permalink: /1178
---
Had to create a standalone USB media for a customer today, they where running SCCM 2007 SP2 R3. Started with running the Create Task Sequence Media wizard, but soon got into trouble.

I got an error &#8220;_Error creating media. Error message is: The parameter is incorrect.. Please refer to CreateTSMedia.log to get details.&#8221;_

To workaround this error I removed all mapped network drives and assigned a drive letter to the hidden partition on the local computer. See more detail of this at itechiez.com

Now the wizard completed and all seems fine, but when the OS WIM should be applied, the computer just rebooted. After some troubleshooting I found an error in SMSTS.log that the file was damaged or unreadable.

To correct that I started the Configuration Manager with the Run as Administrator option, see more detail about this at _Paul Goodson&#8217;s blog_

The installation proceeded without errors.

Summary

  * Install the Configuration Manager Console on your local Windows 7 computer. 
      * Install Admin Console from SCCM 2007 SP2 Media
      * Install KB977384
      * Update Admin Console from SCCM 2007 R3 Media
  * Assign a Drive letter to hidden local partitions
  * Remove mapped network drives.


  
    Open Configuration Manager Console with Local Elevated Administrator Rights
  
  
    Right click the Task Sequence and select Create Task Sequence Media
  
  
    Select Stand-alone media
  
  
    Select the USB drive
  
  
    Assign a password
  
  
    Add the Distribution Point that contains all packages (BGOSERV1SCCM_ODG)
  
  
    Next Next Next.
  


More details information and troubleshooting tips, can be found in a blog post by [J.C. Hornbeck][1] on his TechNet blog.

 [1]: http://blogs.technet.com/13909/ProfileUrlRedirect.ashx