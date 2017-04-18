---
layout: post
title: How to Monitor Orchestrator Runbook Events
published: true
author: kmhuglen
comments: true
date: 2014-01-23 03:01:26
tags:
    - Operations Manager
    - Orchestrator
    - PowerShell
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /4932
image:
    feature: 012314_1445_MonitoringO1.png
---
You can use Operations Manager to monitor a Orchestrator Servers Windows Services and there are also a [Management Pack on Technet Gallery that Discovers Runbooks and monitors it state][5], and this is a good start. But as you relay more and more on the automation that Orchestrator brings, any type of failure could be fatal for your workflows. You can of course use the Notification activities within your runbooks to send Event Log Messages, Plattform Events etc. and you should.

Alert on events, that you did not take into consideration when designing the Runbook is often written to the Event Window within Orchestrator Designer as a Warning or Error. Here is an example of how to take that information and make it available for trough the Windows Event Log.

Then you could use Operations Manager to monitor and then generate e-mail alerts or Service Manager tickets for you to take action on.

**Steps:**

  * Enable Orchestrator to send Platform Event as SNMP traps
  * Set up a SNMP Trap Monitor Runbook that writes the information to the Windows Event Log
  * Configure Runbooks to Write a Plattform Event if it fails.
  * (Update 24.01.2014) Monitoring Orchestrator runbook events from Operations Manager

Then: Monitor the Windows Event Log from Operations Manager. Create Incident using the Operations Manager Alert Connector in Service Manager.

### **Enable Orchestrator to send Platform Event as SNMP traps**

By using the command line utility oedc.exe you can configure the Platform Event to be sent as SNMP traps.

More information about oedc command line utility here: 

**Run the following commands:**

`CD "C:\Program Files (x86)\Microsoft System Center 2012 R2\Orchestrator\Management Server"
oedc /snmp /add /ip 127.0.0.1 /port 162 /version SNMP1 /community Public`

**NB: You have to restart the Orchestrator Runbook Service (orunbook) and Orchestrator Runbook Server Monitor (omonitor) after making changes With the oedc command**.

### **Set up a SNMP Trap Monitor Runbook that writes the traps to the Windows Event Log**

Using the built-in System Activity &#8220;Monitor SNMP Trap&#8221; and &#8220;Run .Net Script&#8221; (PowerShell) to write it to Windows Event Log

![][1]

**Monitor Orchestrator SNMP Traps:**



![][2]

**Write EventLog:**



**PowerShell script:**

<script src="https://gist.github.com/kmhuglen/0f65e6a1e73e811b7de2d5eea30b1494.js"></script>

**Configure Runbook to Write a Plattform Event if it fails**

Go trough all your runbooks or activities that you want error messages from, open the Property and select &#8220;Report if the Runbook fails to run&#8221;

**On a Runbook:**

[][3]

**On an Activity:**
  
[][4]

You can also configure a time in seconds, for how long the runbook could run before generating an event.

Thats it. Customize it to fit Your environment and you should never miss a failure again. 🙂

### **Update 24.01.2014: Monitoring Orchestrator runbook events from Operations Manager**

My colleague Tore Grøneng has made a blog post on how to Monitor Orchestrator Runbook Events from Operations Manager. Have a look at it.

 [1]: /assets/2014-01-23_012314_1445_MonitoringO1.png
 [2]: /assets/2014-01-23_012314_1445_MonitoringO3.png
 [3]: /assets/2014-01-23_012314_1505_MonitoringO1.png
 [4]: /assets/2014-01-23_image2.png
 [5]: http://gallery.technet.microsoft.com/Orchestrator-Runbook-90307b26