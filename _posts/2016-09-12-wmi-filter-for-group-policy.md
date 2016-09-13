---
layout: post
title: WMI Filter for Group Policy
published: true
author: kmhuglen
comments: true
date: 2011-05-05 04:05:07
tags:
    - Active Directory
    - Group Policy
    - Migration
    - Windows
    - WMI
categories:
    - it-pro
permalink: /862
---

  Here are some of the WMI filter I have used when working with Group Policies.


&nbsp;


  Updated: 02.01.2012&#8211; Apply to Windows Server 2008 R2 (Member and Domain Controller) , Apply to Windows 7 & 2008 R2 and added importable MOF files for easier setup.


&nbsp;


  
    
      Importable MOF WMI Filter (zip)
    
  



  
    
      
        Name
      
      
      
        Description
      
      
      
        Namespace
      
      
      
        Query
      
    
    
    
      
        Apply to Windows Servers (Member and Domain Controller)
      
      
      
        ProductType is not like 1 (Workstations)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE ProductType  &#8220;1&#8221;
      
    
    
    
      
        Apply to Windows Vista or previous and all servers (incl 2008R2)
      
      
      
        Version below 6.1 (Windows 7) or ProductType not 1 (Workstations)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version < &#8220;6.1&#8221; OR ProductType  &#8220;1&#8221;
      
    
    
    
      
        Apply to Windows Vista & 2008 or previous
      
      
      
        Version below 6.1 (Windows 7/2008R2))
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version < &#8220;6.1&#8221;
      
    
    
    
      
        Apply to Windows 7
      
      
      
        Version is like 6.1% (Windows 7) and ProductType is 1 (Workstations)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version like &#8220;6.1%&#8221; AND ProductType = &#8220;1&#8221;
      
    
    
    
      
        Apply to Windows Vista & 2008
      
      
      
        Version is like 6.0% (Windows Vista/2008)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version like &#8220;6.0%&#8221;
      
    
    
    
      
        Apply to Windows XP & 2003
      
      
      
        Version is like 5.1% (Windows XP/2003)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version like &#8220;5.1%&#8221;
      
    
    
    
      
        Apply to Windows 7 or newer
      
      
      
        Version above 6.1% (Windows 7) and ProductType is 1 (Workstations)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version > &#8220;6.1&#8221;
      
    
    
    
      
        Apply to Windows Server 2008 R2 (Member and Domain Controller)
      
      
      
        Version like 6.1% (Windows Server 2008 R2) and ProductType not like 1 (Workstations)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version like &#8220;6.1%&#8221; AND ProductType  &#8220;1&#8221;
      
    
    
    
      
        Apply to Windows 7 & 2008 R2
      
      
      
        Version like 6.1% (Windows 7/2008R2)
      
      
      
        rootCIMv2
      
      
      
        SELECT * FROM Win32_OperatingSystem WHERE Version like &#8220;6.1%&#8221;
      
    
  
