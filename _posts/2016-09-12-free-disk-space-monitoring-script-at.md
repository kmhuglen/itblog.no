---
layout: post
title: E-mail alert on Low free disk space
published: true
author: kmhuglen
comments: true
date: 2010-09-03 07:09:17
tags:
    - .vbs
    - PowerShell
categories:
    - it-pro
permalink: /358
---
This is a simple script for checking the amount of free space on logical disk volume, and send e-mail if it gets below a specified value. If you want to schedule it to run once a day every morning, place the file somewhere on the local drive and run the the following command:

[code]AT 05:00 FreeDiskSpace.vbs[/code]

Change   to where you placed the file and change the time to whenever you want the script to check the drives.

Change the variable inside the file to match your environment. You will have to change at least the strEmailAddressTO and strSMTPServerName. And you would probably want to tune CheckDiskVolume to match your environment. Sample script below will send e-mail if C: drive gets below 5 GB and/or if D: drive gets below 10 GB. You can add as many CheckDiskVolume lines as you would like.

The script will requires that a remote SMTP relay server exist on your network. If you would like to use a SMTP server installed local on the server, remove the line containing “objEmail.Configuration.Fields.Item(&#8220;http://schemas.microsoft.com/cdo/configuration/smtpserver&#8221;) = strSMTPServerName “ from the SendEmail sub function.

PS: You will find the script made in PowerShell at the bottom of the post.

**File: FreeDiskSpace.vbs**

[code]
  
Set WshNetwork = WScript.CreateObject(&#8220;WScript.Network&#8221;)
  
strComputerName = WshNetwork.ComputerName

Set objADSysInfo = CreateObject(&#8220;ADSystemInfo&#8221;)
  
strDNSDomainName = objADSysInfo.DomainDNSName

&#8216;###########################################################################

strEmailAddressFROM = strComputerName & &#8220;@&#8221; & strDNSDomainName
  
strEmailAddressTO = &#8220;example@domain.net&#8221;

strSMTPServerName = &#8220;smtp.example.net&#8221;
  
strSMTPServerPort = 25

&#8216;CheckDiskVolume DiskVolume, MinFreeDiskSpace
  
&#8216;Example: CheckDiskVolume &#8220;C:&#8221;, 40

CheckDiskVolume &#8220;C:&#8221;, 5
  
CheckDiskVolume &#8220;D:&#8221;, 10

&#8216;###########################################################################

Sub CheckDiskVolume(strDiskVolume, strMinFreeDiskSpace)

Set objWMIService = GetObject(&#8220;winmgmts:.rootcimv2&#8221;)
  
Set colItems = objWMIService.ExecQuery(&#8220;Select * from Win32_LogicalDisk&#8221;)

For Each objItem in colItems
  
If objItem.Name = strDiskVolume then
  
&#8216;wscript.echo objItem.Name
  
If (Int(objItem.FreeSpace /1073741824) < strMinFreeDiskSpace) then
  
&#8216;wscript.echo Int(objItem.FreeSpace /1073741824)

strEmailSubject = &#8220;Alert: &#8221; & strComputerName & &#8220;: Free space on &#8221; & objItem.VolumeName & &#8220;(&#8221; & objItem.Name & &#8220;) below &#8221; & strMinFreeDiskSpace & &#8221; GB&#8221;
  
strEmailBody = &#8220;Drive Letter: &#8221; & objItem.Name & vbCr & _
  
&#8220;Volume Name: &#8221; & objItem.VolumeName & vbCr & _
  
&#8220;Size: &#8221; & Int(objItem.Size /1073741824) & &#8221; GB&#8221; & vbCr & _
  
&#8220;Free space: &#8221; & Int(objItem.FreeSpace /1073741824) & &#8221; GB&#8221; & vbCr & _
  
&#8220;&#8221;
  
SendEmail strEmailAddressFROM, strEmailAddressTO, strEmailSubject, strEmailBody, strSMTPServerName, strSMTPServerPort
  
end if
  
End if
  
Next

End Sub

Sub SendEmail(strEmailAddressFROM, strEmailAddressTO, strEmailSubject, strEmailBody, strSMTPServerName, strSMTPServerPort)

Set objEmail = CreateObject(&#8220;CDO.Message&#8221;)

objEmail.From = strEmailAddressFROM
  
objEmail.To = strEmailAddressTO
  
objEmail.Subject = strEmailSubject
  
objEmail.Textbody = strEmailBody
  
objEmail.Configuration.Fields.Item(&#8220;http://schemas.microsoft.com/cdo/configuration/sendusing&#8221;) = 2
  
objEmail.Configuration.Fields.Item(&#8220;http://schemas.microsoft.com/cdo/configuration/smtpserver&#8221;) = strSMTPServerName
  
objEmail.Configuration.Fields.Item(&#8220;http://schemas.microsoft.com/cdo/configuration/smtpserverport&#8221;) = strSMTPServerPort
  
objEmail.Configuration.Fields.Update
  
objEmail.Send

End Sub
  
[/code]

The same script written in PowerShell. Change the $emailFrom, $emailTo, $smtpServer, $computername and $percentWarning. The value in $computername will be in the subject field of the e-mail alerts. This can also be remote executed. Will soon add the possibility to run the script against multiple servers.

[code]
  
$emailFrom = &#8220;example@domain.net&#8221;
  
$emailTo = &#8220;example@domain.net&#8221;
  
$smtpServer = &#8220;smtp.example.net&#8221;

$computername = &#8220;.&#8221;;
  
$percentWarning = 15;

$smtp = new-object Net.Mail.SmtpClient($smtpServer)

\# Get fixed drive info
  
$disks = Get-WmiObject -ComputerName $computername -Class Win32_LogicalDisk -Filter &#8220;DriveType = 3&#8221;;

foreach($disk in $disks) {
  
$deviceID = $disk.DeviceID;
  
$deviceName = $disk.VolumeName;
  
[float]$size = $disk.Size;
  
[float]$freespace = $disk.FreeSpace;

$percentFree = [Math]::Round(($freespace / $size) * 100, 2);
  
$sizeGB = [Math]::Round($size / 1073741824, 2);
  
$freeSpaceGB = [Math]::Round($freespace / 1073741824, 2);

$subject = &#8220;Alert:&#8221;, $computername, &#8220;Free disk space is below&#8221;, $percentWarning, &#8220;%&#8221;;
  
$Body = &#8220;Drive letter:&#8221;, $deviceID, &#8220;\`nVolume name:&#8221;, $deviceName, &#8220;\`nSize:&#8221;,$sizeGB,&#8221;GB\`nFreeSpace:&#8221;,$freeSpaceGB,&#8221;GB\`nPercent:&#8221;,$percentFree,&#8221;%&#8221;;

if ($percentFree -lt $percentWarning) { $smtp.Send($emailFrom, $emailTo, $subject, $body) }
  
}
  
[/code]