---
layout: post
title: Best practice guidelines for working with Group Policies
published: true
author: kmhuglen
comments: true
date: 2011-04-29 12:04:08
tags:
    - Active Directory
    - Group Policy
    - Windows
categories:
    - it-pro
permalink: /834
---
Here are my toughts about best practice when working with Group Policy in a Windows Domain environment. I will updated this post as I think of more best practice tips.

  * 
      Don’t making changes to the Default Domain Policy and/or Default Domain Controller Policy &#8211; Create instead new custom GPOs and link them to the relevant domain/organizational unit. If you already have made changes and are unable to manualy restore them, see my other blog post on how to Reset the Default Domain Policy or Default Domain Controller Policy back to it’s original state 
    


  Computer object and user object should not be placed in the default location CN=Computers,DC=,DC= or CN=Users,DC=,DC= – Because group policies can only be linked on organizational unit containers (example: OU=CompanyUsers,DC=,DC=) but not on CN class containers (example: Builtin, Computers and Users), where security principals are put by default. See Microsoft’s KB324949 article about Redirecting the users and computers containers in Active Directory domains


  Create a Central Store for Group Policy Definition files (.admx/.adml) with the policy definition files from the latest Windows version in your environment – Add definition files for other group policy controlled software as you need. Office, IE etc.. See Microsoft Technet article on how to Create the Central Store


  Try to link GPOs at the nearest point of the resource, but don’t overdo it. If you have a complex OU structure consisting of many OUs consider linking the GPO at the parent level. – This is manly for troubleshooting ease.


  Configure policy settings with Computer Configuration instead of User Configuration where possible and where it make sense.


  Make a strategy and naming standard for group policy object. Example: Many small GPO per function or one big GPO per OS, location or user role. I personally like when you have one GPO per function.


  If there is many Domain Administrators consider implementing a strict change management for group policy editing by removing Domain Admin rights from IT administrators and have them use AGPM (available from MDOP) to edit and approve changes. AGMP also gives you history and rollback functionality
