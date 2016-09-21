---
layout: post
title: WMI Filter for Group Policy
published: true
author: Knut Magne Huglen
comments: true
date: 2011-05-05 04:05:07
tags:
    - Active Directory
    - Group Policy
    - Migration
    - Windows
categories:
    - it-pro
permalink: /862
---

Here are some of the WMI filter I have used when working with Group Policies.

Updated: 02.01.2012&#8211; Apply to Windows Server 2008 R2 (Member and Domain Controller) , Apply to Windows 7 & 2008 R2 and added importable MOF files for easier setup.

[Importable MOF WMI Filter (zip)][1]
    
  
Name | Query
:---|---:
Apply to Windows Servers (Member and Domain Controller)|`SELECT * FROM Win32_OperatingSystem WHERE ProductType <> "1"`
Apply to Windows Vista or previous and all servers (incl 2008R2)|`SELECT * FROM Win32_OperatingSystem WHERE Version < "6.1" OR ProductType <> "1"`
Apply to Windows Vista & 2008 or previous|`SELECT * FROM Win32_OperatingSystem WHERE Version < "6.1"`
Apply to Windows 7|`SELECT * FROM Win32_OperatingSystem WHERE Version like "6.1%" AND ProductType = "1"`
Apply to Windows Vista & 2008|`SELECT * FROM Win32_OperatingSystem WHERE Version like "6.0%"`
Apply to Windows XP & 2003|`SELECT * FROM Win32_OperatingSystem WHERE Version like "5.1%"`
Apply to Windows 7 or newer|`SELECT * FROM Win32_OperatingSystem WHERE Version > "6.1"`
Apply to Windows Server 2008 R2 (Member and Domain Controller)|`SELECT * FROM Win32_OperatingSystem WHERE Version like 6.1% AND ProductType <> "1"`
Apply to Windows 7 & 2008 R2|`SELECT * FROM Win32_OperatingSystem WHERE Version like "6.1%"`

Namespace = rootCIMv2

[1]: /assets/2011-05-05_Importable-MOF-WMI-Filter-v2