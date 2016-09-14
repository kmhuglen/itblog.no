---
layout: post
title: Silently deploy TeamViewer 10 Host
published: true
author: Knut Magne Huglen
comments: true
date: 2015-04-08 09:04:56
tags:
    - TeamViewer
    - Active Directory 
categories:
    - it-pro
permalink: /5774
---
1. Logon on to [TeamViewer.com][1] and create a custom module.
2. Download the TeamViewer_Host-**idcXXXXXXX**.msi (or just rename the one you already have, remember to add **-idc** before your 7 character ConfigurationID).
3. Install the TeamViewer Host on a computer; configure it the way you want, and export the **TeamViewer_Settings.reg**.
4. Run the *TrustConfigID.ps1* script on a computer With the Active Directory PowerShell Module installed and with administrative rights to your domain. (Replace the XXXXXXX With Your ConfigurationID)

`.\TrustConfigID.ps1 -Add XXXXXXX -Name TeamViewer -Path "CN=System,DC=yourdomain,DC=com"`

5. Put both the **TeamViewer_Host-idcXXXXXXX.msi** and **TeamViewer_Settings.reg** in the same folder/share.
6. Run the following commands to silently install, remove desktop shortcut and hide the dialog at logon:

`REG ADD HKCU\Software\TeamViewer /v HostInfoDialog /t REG_DWORD /d 0`

`REG ADD HKU\.DEFAULT\Software\TeamViewer /v HostInfoDialog /t REG_DWORD /d 0`

`start /wait MSIEXEC.EXE /i "TeamViewer_Host-idcmbwnmzt.msi" /qn`

`del "%Public%\Desktop\TeamViewer*.lnk"`

[1]: https://login.teamviewer.com/nav/menu/designanddeploy