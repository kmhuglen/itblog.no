---
layout: post
title: Dual boot Windows 7 and Windows 8
published: true
author: kmhuglen
comments: true
date: 2011-09-15 11:09:27
tags:
    - dualboot
    - Tools
    - VHD
    - vhdx
    - Windows
categories:
    - it-pro
permalink: /918
---
Interested in trying out Windows 8?

There&#8217;s many way of installing Windows 8 without destroying your existing Windows installation.

Here is a list of some of the approche and:

  * [Make a VHD, apply WIM file (located inside the ISO) and boot VHD native. &#8211; hyper.nu][1]
  * [Make a VHD, burn a DVD/USB stick and dual boot. &#8211; www.hanselman.com][2]
  * [Create a new partition and install Windows 8 there. &#8211; lifehacker.com][3]

I used the guide from [Interested in trying out Windows 8?

There&#8217;s many way of installing Windows 8 without destroying your existing Windows installation.

Here is a list of some of the approche and:

  * [Make a VHD, apply WIM file (located inside the ISO) and boot VHD native. &#8211; hyper.nu][1]
  * [Make a VHD, burn a DVD/USB stick and dual boot. &#8211; www.hanselman.com][2]
  * [Create a new partition and install Windows 8 there. &#8211; lifehacker.com][3]

I used the guide from][2] and was up and running in no time.

**EDIT 27.04.2012**:

  * A tool that can be of interest is the Disk2VHD from sysinternals, this tool will convert a physical disk into a VHD.
  * Also have look at BCDEdit for altering the boot menu. A good blog about this at Windows SevenForums

 [1]: http://www.hyper-v.nu/archives/hvredevoort/2011/09/how-to-boot-from-vhd-with-windows-8-developer-preview/#utm_source=feed&utm_medium=feed&utm_campaign=feed
 [2]: http://www.hanselman.com/blog/GuideToInstallingAndBootingWindows8DeveloperPreviewOffAVHDVirtualHardDisk.aspx
 [3]: http://lifehacker.com/5840387/how-to-dual+boot-windows-7-and-windows-8-side-by-side