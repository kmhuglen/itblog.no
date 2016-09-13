---
layout: post
title: Pin (Unpin) to Start Menu / Taskbar
published: true
author: kmhuglen
comments: true
date: 2012-07-02 11:07:45
tags:
    - VBScript
    - Group Policy
    - Registry
    - Windows
    - Office
categories:
    - it-pro
permalink: /1168
---
The script will check the registry value HKEY\_CURRENT\_USERSoftwareCompanyPinToStartMenu, If the Value of PinToStartMenu is 1 the script will quit. If the value is something else or string is missing the script will pin Outlook 2010, Word 2010, Excel 2010 and Powerpoint 2010 to the Start Menu. It will also unpin Windows Media Player from the Taskbar.

By first checking the if the registry value exist, users will only get the application pinned or unpinned the first time they log in, any modification they make to the start menu or taskbar will not be overwritten.

Either launch the script from your existing logonscript, or you could create a group policy object and launch the script from User ConfigurationPoliciesWindows SettingsScriptsLogon.

[code]

On Error Resume Next
  
const HKEY\_CURRENT\_USER = &H80000001
  
strKeyPath = &#8220;SoftwareCompany&#8221;
  
strValueName = &#8220;PinToStartMenu&#8221;

&#8216;Read registry string
  
Set oReg=GetObject(&#8220;winmgmts:{impersonationLevel=impersonate}!.rootdefault:StdRegProv&#8221;)
  
oReg.GetStringValue HKEY\_CURRENT\_USER,strKeyPath,strValueName,strValue

IF strValue = 1 Then
  
&#8216; IF Registry Value is 1 then quit script
  
wscript.quit

Else
  
&#8216; IF Registry Value is missing or other than 1, (un)pin application.

&#8216; Declare
  
Const CSIDL\_COMMON\_PROGRAMS = &H17
  
Const CSIDL_PROGRAMS = &H2

&#8216; Create Object and set path to All Users Program Folder
  
Set objShell = CreateObject(&#8220;Shell.Application&#8221;)
  
Set objAllUsersProgramsFolder = objShell.NameSpace(CSIDL\_COMMON\_PROGRAMS)
  
strAllUsersProgramsPath = objAllUsersProgramsFolder.Self.Path

&#8216; Pin Outlook 2010 to Start Menu
  
Set objFolder = objShell.Namespace(strAllUsersProgramsPath & &#8220;Microsoft Office&#8221;)
  
Set objFolderItem = objFolder.ParseName(&#8220;Microsoft Outlook 2010.lnk&#8221;)
  
Set colVerbs = objFolderItem.Verbs
  
For Each objVerb in colVerbs
  
If Replace(objVerb.name, &#8220;&&#8221;, &#8220;&#8221;) = &#8220;Pin to Start Menu&#8221; Then objVerb.DoIt
  
Next

&#8216; Pin Word 2010 to Start Menu
  
Set objFolder = objShell.Namespace(strAllUsersProgramsPath & &#8220;Microsoft Office&#8221;)
  
Set objFolderItem = objFolder.ParseName(&#8220;Microsoft Word 2010.lnk&#8221;)
  
Set colVerbs = objFolderItem.Verbs
  
For Each objVerb in colVerbs
  
If Replace(objVerb.name, &#8220;&&#8221;, &#8220;&#8221;) = &#8220;Pin to Start Menu&#8221; Then objVerb.DoIt
  
Next

&#8216; Pin Excel 2010 to Start Menu
  
Set objFolder = objShell.Namespace(strAllUsersProgramsPath & &#8220;Microsoft Office&#8221;)
  
Set objFolderItem = objFolder.ParseName(&#8220;Microsoft Excel 2010.lnk&#8221;)
  
Set colVerbs = objFolderItem.Verbs
  
For Each objVerb in colVerbs
  
If Replace(objVerb.name, &#8220;&&#8221;, &#8220;&#8221;) = &#8220;Pin to Start Menu&#8221; Then objVerb.DoIt
  
Next

&#8216; Pin PowerPoint 2010 to Start Menu
  
Set objFolder = objShell.Namespace(strAllUsersProgramsPath & &#8220;Microsoft Office&#8221;)
  
Set objFolderItem = objFolder.ParseName(&#8220;Microsoft PowerPoint 2010.lnk&#8221;)
  
Set colVerbs = objFolderItem.Verbs
  
For Each objVerb in colVerbs
  
If Replace(objVerb.name, &#8220;&&#8221;, &#8220;&#8221;) = &#8220;Pin to Start Menu&#8221; Then objVerb.DoIt
  
Next

&#8216; Unpin Windows Media Player from Taskbar
  
Set objFolder = objShell.Namespace(strAllUsersProgramsPath)
  
Set objFolderItem = objFolder.ParseName(&#8220;Windows Media Player.lnk&#8221;)
  
Set colVerbs = objFolderItem.Verbs
  
For Each objVerb in colVerbs
  
If Replace(objVerb.name, &#8220;&&#8221;, &#8220;&#8221;) = &#8220;Unpin from Taskbar&#8221; Then objVerb.DoIt
  
Next

&#8216; Write Registry Value to indicate that the script has run for the current user.
  
oReg.SetStringValue HKEY\_CURRENT\_USER,strKeyPath,strValueName,&#8221;1&#8243;

End IF

[/code]

You can read more about Pin Items to the Start Menu or Windows 7 Taskbar via Script over at the The Deployment Guys blog on TechNet