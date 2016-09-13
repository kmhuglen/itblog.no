---
layout: post
title: >
    Preserve the user profile when joining computers to a
    domain.
published: true
author: kmhuglen
comments: true
date: 2011-09-22 05:09:11
tags:
    - User Profile
    - Windows
categories:
    - it-pro
permalink: /942
---
If you’re in the situation where you need to join a workgroup computer to a domain or move a domain joined computer into another domain, the user profile on the computer will most likely be replaced by a new domain joined user profile or at least a new domain joined user account with another SID.

Setting up a new personalized user profile can often be very time-consuming. There are a lot of tools available for this operation. Windows Easy Transfer is included in Windows 7 and gives you the ability to back up your profile and move it to a new computer (or the same). But an easier way is to just attach the old user profile folder to the new user profile account.

  * Log into the computer with the local machine administrator account

_You can’t use the local machine administrator account if that’s the profile you’ll want to move. Then create a new local account with administrator privileges, and use that account._ _Local Administrator accounts are often disabled and without a password, fix that first._

  * Join the computer to the new domain and reboot
  * After successfully logging in as your new user, immediately log out, reboot and log back in as the local machine administrator.
  * Go to **C:Documents and Settings** (Windows XP) or **C:Users** (Windows Vista/7) and you’ll see two profile folders with similar names. One will probably have **.DOMAIN or** **.DOMAIN.000** appended to the end. This is the new profile, check the dates and size of the folder to be sure which is the newest created.
  * Open properties of the old profile folder and give the new user **ownership** of all files and folder and replace all child object permissions with inherited permissions from this object. Then give the user **Full control** of all files and folder and replace all child object permissions with inherited permissions from this object.
  * Go Start > Run and type **REGEDIT** followed by OK.
  * Locate **HKEY\_LOCAL\_MACHINE > SOFTWARE > Microsoft > Windows NT > CurrentVersion > ProfileList** > _weird numbers_ (GUID) and the key is called **ProfileImagePath**
  * Find the one that has the same folder name as the newly created profile.
  * Change the value of **ProfileImagePath** to the same as the old profile folder
  * Reboot
  * Logon with the new user account, now everything should be there.