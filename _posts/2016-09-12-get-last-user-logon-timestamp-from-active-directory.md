---
layout: post
title: Get Last User Logon Timestamp from Active Directory
published: true
author: kmhuglen
comments: true
date: 2011-04-15 12:04:36
tags:
    - .vbs
    - Active Directory
categories:
    - it-pro
permalink: /818
---
VBScript program to determine when each user in the domain last logged on. Domain must be at Windows Server 2003 Functional Level.

The lastLogonTimeStamp attribute is Integer8, a 64-bit number representing the date as the number of 100 nanosecond intervals since 12:00 am January 1, 1601. This value is converted to a date. The last logon date is in UTC (Coordinated Univeral Time). It must be adjusted by the Time Zone bias in the machine registry to convert to local time.

Save this script as file with whatever filename you like. It will produce an output file withe the same name as the scriptfile name adding .csv at the end. You can then open the file with Execl and use the collected data as you like.

[code]
  
Option Explicit

Dim objRootDSE, adoConnection, adoCommand, strQuery
  
Dim adoRecordset, strDNSDomain, objShell, lngBiasKey
  
Dim lngBias, k, strDN, dtmDate, objDate
  
Dim strBase, strFilter, strAttributes, lngHigh, lngLow
  
Dim objFileSystem, objOutputFile, strOutputFile

strOutputFile = &#8220;./&#8221; & Split(WScript.ScriptName, &#8220;.&#8221;)(0) & &#8220;.csv&#8221;
  
Set objFileSystem = CreateObject(&#8220;Scripting.fileSystemObject&#8221;)
  
Set objOutputFile = objFileSystem.CreateTextFile(strOutputFile, TRUE)

&#8216; Obtain local Time Zone bias from machine registry.
  
&#8216; This bias changes with Daylight Savings Time.
  
Set objShell = CreateObject(&#8220;Wscript.Shell&#8221;)
  
lngBiasKey = objShell.RegRead(&#8220;HKLMSystemCurrentControlSetControl&#8221; _
  
& &#8220;TimeZoneInformationActiveTimeBias&#8221;)
  
If (UCase(TypeName(lngBiasKey)) = &#8220;LONG&#8221;) Then
  
lngBias = lngBiasKey
  
ElseIf (UCase(TypeName(lngBiasKey)) = &#8220;VARIANT()&#8221;) Then
  
lngBias = 0
  
For k = 0 To UBound(lngBiasKey)
  
lngBias = lngBias + (lngBiasKey(k) * 256^k)
  
Next
  
End If
  
Set objShell = Nothing

&#8216; Determine DNS domain from RootDSE object.
  
Set objRootDSE = GetObject(&#8220;LDAP://RootDSE&#8221;)
  
strDNSDomain = objRootDSE.Get(&#8220;defaultNamingContext&#8221;)
  
Set objRootDSE = Nothing

&#8216; Use ADO to search Active Directory.
  
Set adoCommand = CreateObject(&#8220;ADODB.Command&#8221;)
  
Set adoConnection = CreateObject(&#8220;ADODB.Connection&#8221;)
  
adoConnection.Provider = &#8220;ADsDSOObject&#8221;
  
adoConnection.Open &#8220;Active Directory Provider&#8221;
  
adoCommand.ActiveConnection = adoConnection

&#8216; Search entire domain.
  
strBase = &#8220;&#8221;

&#8216; Filter on all user objects.
  
strFilter = &#8220;(&(objectCategory=person)(objectClass=user))&#8221;

&#8216; Comma delimited list of attribute values to retrieve.
  
strAttributes = &#8220;distinguishedName,lastLogonTimeStamp&#8221;

&#8216; Construct the LDAP syntax query.
  
strQuery = strBase & &#8220;;&#8221; & strFilter & &#8220;;&#8221; & strAttributes & &#8220;;subtree&#8221;

&#8216; Run the query.
  
adoCommand.CommandText = strQuery
  
adoCommand.Properties(&#8220;Page Size&#8221;) = 100
  
adoCommand.Properties(&#8220;Timeout&#8221;) = 60
  
adoCommand.Properties(&#8220;Cache Results&#8221;) = False
  
Set adoRecordset = adoCommand.Execute

objOutputFile.WriteLine(&#8220;DN&#8221; & &#8220;;&#8221; & &#8220;Date&#8221;)
  
&#8216; Enumerate resulting recordset.
  
Do Until adoRecordset.EOF
  
&#8216; Retrieve attribute values for the user.
  
strDN = adoRecordset.Fields(&#8220;distinguishedName&#8221;).Value
  
&#8216; Convert Integer8 value to date/time in current time zone.
  
On Error Resume Next
  
Set objDate = adoRecordset.Fields(&#8220;lastLogonTimeStamp&#8221;).Value
  
If (Err.Number  0) Then
  
On Error GoTo 0
  
dtmDate = #1/1/1601#
  
Else
  
On Error GoTo 0
  
lngHigh = objDate.HighPart
  
lngLow = objDate.LowPart
  
If (lngLow < 0) Then
  
lngHigh = lngHigh + 1
  
End If
  
If (lngHigh = 0) And (lngLow = 0) Then
  
dtmDate = #1/1/1601#
  
Else
  
dtmDate = #1/1/1601# + (((lngHigh * (2 ^ 32)) _
  
+ lngLow)/600000000 &#8211; lngBias)/1440
  
End If
  
End If
  
&#8216; Display values for the user.
  
If (dtmDate = #1/1/1601#) Then
  
objOutputFile.WriteLine(strDN & &#8220;;Never&#8221;)
  
Else
  
objOutputFile.WriteLine(strDN & &#8220;;&#8221; & dtmDate)
  
End If
  
adoRecordset.MoveNext
  
Loop

&#8216; Clean up.
  
objOutputFile.Close
  
Set objFileSystem = Nothing
  
adoRecordset.Close
  
adoConnection.Close

WScript.Quit(0)
  
[/code]