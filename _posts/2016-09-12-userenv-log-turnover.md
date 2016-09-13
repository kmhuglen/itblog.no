---
layout: post
title: UserEnv Log Turnover
published: true
author: kmhuglen
comments: true
date: 2009-11-03 10:11:00
tags:
    - Windows
categories:
    - it-pro
permalink: /599
---
This script can be used to configure Windows to start logging debug information and turnover the log file when required. The 

**Install.bat** will configure Windows, install a .vbs script and set up a task schedule to run the .vbs script on startup.

**Why**:

If you just enable the **UserEnvDebugLevel** it will start logging to **userenv.log**, but the file will rename itself to userenv.bak on startup if its size exceeds 300kb. Use the scripts below to make a task schedule to rename the **userenv.bak** to the format of **date-time_userenv.log** as windows starts up.

**How-to**:

  1. Open Notepad and copy contain of Install.bat and save it somewhere on your computer.
  2. Open a new Notepad and copy the contain of UserEnvLogTurnover.vbs and save it in the same folder as install.bat
  3. Run Install.bat.

**Compability:**

  * Windows XP

[code title=&#8221;install.bat&#8221;]mkdir &#8220;%programfiles%UserEnvLogTurnover&#8221;
  
copy .UserEnvLogTurnover.vbs &#8220;%programfiles%UserEnvLogTurnoverUserEnvLogTurnover.vbs&#8221;
  
REG ADD &#8220;HKLMSOFTWAREMicrosoftWindows NTCurrentVersionWinlogon&#8221; /v UserEnvDebugLevel /t REG_DWORD /d 196610 /f
  
schtasks /delete /tn &#8220;UserEnvLogTurnover&#8221; /F
  
schtasks /create /tn &#8220;UserEnvLogTurnover&#8221; /tr &#8220;%systemroot%system32wscript.exe &#8220;%programfiles%UserEnvLogTurnoverUserEnvLogTurnover.vbs&#8221;&#8221; /sc onstart /ru System[/code]
  
[code title=&#8221;UserEnvLogTurnover.vbs&#8221;]pathtofile = &#8220;c:windowsdebugusermodeuserenv.bak&#8221;
  
pathtonewfile = &#8220;c:windowsdebugusermode&#8221; & FormatYYYYMMDD(date) & &#8220;-&#8221; & FormatHHMMSS(time) & &#8220;_&#8221; & &#8220;userenv.log&#8221;
  
&#8216;msgbox pathtofile & &#8221; -> &#8221; & pathtonewfile
  
Set objFSO = CreateObject(&#8220;Scripting.FileSystemObject&#8221;)
  
IF objFSO.FileExists (pathtofile) then
  
Set file = objFSO.GetFile(pathtofile)
  
file.move pathtonewfile
  
End if

Function FormatYYYYMMDD(timeStamp)
  
Dim dateYear : dateYear = DatePart(&#8220;yyyy&#8221;, timeStamp)
  
Dim dateMonth : dateMonth = DatePart(&#8220;m&#8221;, timeStamp)
  
Dim dateDay : dateDay = DatePart(&#8220;d&#8221;, timeStamp)

IF dateMonth < 10 Then dateMonth = &#8220;0&#8221; & dateMonth
  
IF dateDay < 10 Then dateDay = &#8220;0&#8221; & dateDay

FormatYYYYMMDD = dateYear & dateMonth & dateDay
  
End Function

Function FormatHHMMSS(timestamp)
  
Dim timeSecond : timeSecond = DatePart(&#8220;s&#8221;, timeStamp)
  
Dim timeMinute : timeMinute = DatePart(&#8220;n&#8221;, timeStamp)
  
Dim timeHour : timeHour = DatePart(&#8220;h&#8221;, timeStamp)

IF timeHour < 10 Then dateHour = &#8220;0&#8221; & dateString
  
IF timeMinute < 10 Then dateMinute = &#8220;0&#8221; & dateMinute
  
IF timeSecond < 10 Then dateSecond = &#8220;0&#8221; & dateSecond

FormatHHMMSS = timeHour & timeMinute & timeSecond
  
End Function[/code]