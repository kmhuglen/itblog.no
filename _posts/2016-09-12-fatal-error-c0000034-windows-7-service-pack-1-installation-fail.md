---
layout: post
title: 'Fatal error C0000034: Windows 7 Service Pack 1 installation fail'
published: true
author: kmhuglen
comments: true
date: 2011-03-10 08:03:57
tags:
    - BitLocker
    - Windows
categories:
    - it-pro
permalink: /751
---
HOW TO FIX IT

* Reboot your computer.

* When your computer starts up again, choose the option &#8220;Launch Startup Repair&#8221;

* When the Startup repair starts, click cancel.

* After you click cancel, it may ask you about sending information to Microsoft, just click &#8220;Don&#8217;t Send&#8221;

You may get a dialog about authentication for this windows installation, this probably mean that the Local Administrator Account is disable. Then you will have to boot up in a WinPE environment (PXE with MDT, or similar) to get full access to the windows environment. Press F8 after WinPE has started up to open Command Prompt

* Click the link &#8220;View advanced options for recovery and support&#8221;

If you don&#8217;t get this choice, only the Startup Repair, this probably mean that the Local Administrator Account is disable. Then you will have to boot up in a WinPE environment (PXE with MDT, Windows 7 DVD repair disc, or similar) to get full access to the windows environment. Press F8 after WinPE has started up to open Command Prompt

* In the new window click Command Prompt at the bottom.

* In Command Prompt open notepad: %windir%system32notepad.exe

* Notepad will open. In notepad go to File&#8211;>Open.

* Change the type of files notepad views from .txt to All Files

* Go to C:Windowswinsxs (or whichever drive Windows is installed on) (If your in WinPE the drive is probably D:)

* In that folder, find pending.xml and make a copy of it

* Now open the original pending.xml (it will load really slow because the file is huge)

* Press CTRL+F and search for the following exactly: 0000000000000000.cdf-ms

* Delete the following text (yours will be a little different):


  

  


Your PC might not have all 3 sections of code (, , ). Just make sure you delete section &#8220;Checkpoint&#8221; and whatever other sections have &#8220;000000000000000.cdf-ms&#8221;. They will be right next to eachother.

* Save the file, close notepad, close command prompt (command: exit), restart your computer.

Once your computer starts up, do a normal start up (it may stall for 5-10 minutes at the &#8220;starting windows&#8221; screen, but leave it going) and the Service Pack will install some more stuff and restart a few times and then everything should be working! For some people, it reverts everything and cancels the service pack installation. For other people, the service pack installation completes. Either result is fine. You may get an dialog saying the Service Pack did not complete and has reverted, but it has not 🙂

It may or may not screw up BitLocker if your running on Windows 7 Ultimate, if so you will have to enter your recovery key, decrypt the drive and re encrypt the drive again.