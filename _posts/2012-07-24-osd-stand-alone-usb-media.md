---
layout: post
title: 'OSD - Stand-alone USB Media'
published: true
author: Knut Magne Huglen
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

> Error creating media. Error message is: The parameter is incorrect.. Please refer to CreateTSMedia.log to get details.

To workaround this error I removed all mapped network drives and assigned a drive letter to the hidden partition on the local computer. See more detail of this at [itechiez.com][1]

Now the wizard completed and all seems fine, but when the OS WIM should be applied, the computer just rebooted. After some troubleshooting I found an error in SMSTS.log that the file was damaged or unreadable.

To correct that I started the Configuration Manager with the Run as Administrator option, see more detail about this at [Paul Goodson`s blog][2]

The installation proceeded without errors.

**Summary**

* Install the Configuration Manager Console on your local Windows 7 computer. 
    * Install Admin Console from SCCM 2007 SP2 Media
    * Install KB977384
    * Update Admin Console from SCCM 2007 R3 Media
* Assign a Drive letter to hidden local partitions
* Remove mapped network drives.

1. Open Configuration Manager Console with Local Elevated Administrator Rights
2. Right click the Task Sequence and select Create Task Sequence Media
3. Select Stand-alone media
4. Select the USB drive
5. Assign a password
6. Add the Distribution Point that contains all packages (BGOSERV1SCCM_ODG)
7. Next Next Next.

More details information and troubleshooting tips, can be found in a [blog post][3] by [J.C. Hornbeck][4] on his [TechNet blog][5].

[1]: http://www.itechiez.com/sccm-2007/creating-osd-usb-deployment-media-in-system-center-configuration-manager-2007-fails-with-the-parameter-is-incorrect/
[2]: http://www.sccmadvice.com/the-hash-value-is-not-correct-when-trying-to-create-task-sequence-media/
[3]: http://blogs.technet.com/b/configurationmgr/archive/2011/05/05/how-to-create-offline-or-standalone-usb-media-for-os-deployment-in-configmgr-2007.aspx
[4]: http://blogs.technet.com/13909/ProfileUrlRedirect.ashx
[5]: http://blogs.technet.com/b/configurationmgr/archive/2011/05/05/how-to-create-offline-or-standalone-usb-media-for-os-deployment-in-configmgr-2007.aspx