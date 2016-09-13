---
layout: post
title: "Reset the Default Domain Policy or Default Domain Controller Policy back to it's original state"
published: true
author: kmhuglen
comments: true
date: 2011-04-29 12:04:07
tags:
    - Active Directory
    - Group Policy
categories:
    - it-pro
permalink: /844
---
**WARNING**: Following the procedure in this post will result in losing all custom changes to the default policies. – Make a backup / duplication with GPMC just in case.

The procedure below will restore the GPOs to almost its original state. Se more information about this at Microsofts KB833783 article

> 
>   Microsoft recommends you use GPMC to back up and restore all GPOs in your environment. The Dcgpofix tool is a disaster-recovery tool that will restore your environment to a functional state only. It is best not to use it as a replacement for a backup strategy using GPMC. It is best to use the Dcgpofix tool only when a GPO back up for the Default Domain Policy and Default Domain Controller Policy does not exist.
> 

**PS**: Backup of GPOs does not include Links, Security Filter and ACLs. Therefore it is a good idea to document these when doing backup &#8211; Just save the settings report to a html file from the Group Policy Management Console.

**Procedure for reseting the default policyes:**

1. Log on as a domain administrator to a domain controller (DC).
  
2. Open a command prompt
  
3. Reset the GPO(s)

  1. To reset the Domain GPO, type
dcgpofix /target:Domain

  2. To reset the Default DC GPO, type
dcgpofix /target:DC

  3. To reset both the Domain and Default Domain Controller GPOs, type
dcgpofix /target:both







  4. After you enter the appropriate command, enter Y to both prompts.
  5. Close the command prompt
