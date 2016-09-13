---
layout: post
title: SharePoint Special Characters Replacer
published: true
author: kmhuglen
comments: true
date: 2009-10-28 02:10:00
tags:
    - VBScript
    - SharePoint
categories:
    - it-pro
permalink: /598
---
WSH script to traverse files and folders in a folder structure and Replace Special Characters not allowed by Sharepoint, including multiple periods. Can be used to quickly go through a large number of files and folders, and prepare it for migration to a SharePoint document library.

**Syntax: cscript.exe SPSCReplacer.vbs  [>filename.log]**

  *  is the root folder to traverse
  * [>filename.log] pipes the output to a file.

where  is requierd and [] is optional

[code title=&#8221;SPSCReplacer.vbs&#8221;]&#8221; Traverse files and folder in a folder structure and Replace Special Characters
  
&#8221; not allowed by SharePoint, including multiple periods
  
&#8221;
  
&#8221; Filename: SPSCReplacer.vbs (SharePoint Special Characters Replacer)
  
&#8221; Created by kmhuglen (at) gmail.com
  
&#8221; Version 0.2

Set fso = CreateObject(&#8220;Scripting.FileSystemObject&#8221;)
  
Set re = New RegExp

strPattern = &#8220;[~#%&~{}]&#8221; &#8216;Special characters not allowed in a Sharepoint filename&#8217;
  
strPattern2 = &#8220;.{2,}&#8221; &#8216;Multiple periods&#8217;

re.IgnoreCase = True
  
re.Global = True

If WScript.Arguments.Unnamed.Count = 1 Then
  
If fso.FolderExists(WScript.Arguments.Unnamed(0)) Then
  
Recurse fso.GetFolder(WScript.Arguments.Unnamed(0)), strPattern, &#8220;_&#8221;
  
Recurse fso.GetFolder(WScript.Arguments.Unnamed(0)), strPattern2, &#8220;.&#8221;
  
Else
  
WScript.Echo &#8220;Folder does not exist&#8221;
  
End If
  
Else
  
WScript.Echo &#8220;Syntax: cscript.exe SPSCReplacer.vbs [>SPSCReplacer.log]&#8221;
  
End If

Sub Recurse(f,p,v)
  
re.pattern = p
  
For Each sf In f.SubFolders
  
Recurse sf,p,v
  
If (sf.Name = re.Replace(sf.Name, v)) then
  
Else
  
WScript.Echo sf.path, &#8221; -> &#8220;, re.Replace(sf.Name, v)
  
sf.Name = re.Replace(sf.Name, v)
  
End if
  
Next
  
For Each sf In f.Files
  
If (sf.Name = re.Replace(sf.Name, v)) then
  
Else
  
WScript.Echo sf.path, &#8221; -> &#8220;, re.Replace(sf.Name, v)
  
sf.Name = re.Replace(sf.Name, v)
  
End if
  
Next[/code]