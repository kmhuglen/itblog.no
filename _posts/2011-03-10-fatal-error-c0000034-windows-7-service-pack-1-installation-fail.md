---
layout: post
title: 'Fatal error C0000034: Windows 7 Service Pack 1 installation fail'
published: true
author: Knut Magne Huglen
comments: true
date: 2011-03-10 08:03:57
tags:
    - BitLocker
    - Windows
categories:
    - it-pro
permalink: /751
---
**How to fix it**

1. Reboot your computer.
2. When your computer starts up again, choose the option *Launch Startup Repair*
3. When the Startup repair starts, click cancel.
4. After you click cancel, it may ask you about sending information to Microsoft, just click *Don´t Send*

You may get a dialog about authentication for this windows installation, this probably mean that the Local Administrator Account is disable. Then you will have to boot up in a WinPE environment (PXE with MDT, or similar) to get full access to the windows environment. Press F8 after WinPE has started up to open Command Prompt

* Click the link *View advanced options for recovery and support*

If you don´t get this choice, only the Startup Repair, this probably mean that the Local Administrator Account is disable. Then you will have to boot up in a WinPE environment (PXE with MDT, Windows 7 DVD repair disc, or similar) to get full access to the windows environment. Press F8 after WinPE has started up to open Command Prompt

1. In the new window click *Command Prompt* at the bottom.
2. In *Command Prompt* type `notepad: %windir%system32notepad.exe` and press enter
3. *Notepad* will open. In *Notepad* go to *File>Open*
4. Change the type of files *Notepad* views from *.txt* to *All Files*
5. Go to *C:\Windows\winsxs*, or whichever drive Windows is installed on. If your in WinPE the drive is probably D:
6. In that folder, find *pending.xml* and make a copy of it
7. Now open the original *pending.xml* (it will load really slow because the file is huge)
8. Press *CTRL+F* and search for the following exactly: `0000000000000000.cdf-ms`
9. Delete the following text (yours will be a little different):

```xml
<Checkpoint/>
<DeleteFile path=”SystemRootWinSxSFileMaps_0000000000000000.cdf-ms”/>
<MoveFile source=”SystemRootWinSxSTempPendingRenamese56db1db48d4cb0199440000b01de419._0000000000000000.cdf-ms” destination=”SystemRootWinSxSFileMaps_0000000000000000.cdf-ms”/>
```

Your PC might not have all 3 sections of code `<Checkpoint>`, `<DeleteFile>` and `<MoveFile>`. Just make sure you delete section `<Checkpoint>` and whatever other sections have `000000000000000.cdf-ms`. They will be right next to eachother.

10. Save the file, close notepad, close command prompt `exit`, restart your computer.

Once your computer starts up, do a normal start up. *It may stall for 5-10 minutes at the starting windows screen, but leave it going.* The Service Pack will install some more stuff and restart a few times and then everything should be working! For some people, it reverts everything and cancels the service pack installation. For other people, the service pack installation completes. Either result is fine. You may get an dialog saying the Service Pack did not complete and has reverted, but it has not 🙂

It may or may not screw up BitLocker if your running on Windows 7 Ultimate, if so you will have to enter your recovery key, decrypt the drive and re encrypt the drive again.