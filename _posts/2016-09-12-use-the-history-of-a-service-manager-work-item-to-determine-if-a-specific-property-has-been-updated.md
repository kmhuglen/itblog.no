---
layout: post
title: >
    Use the history of a Service Manager work-item to determine
    if a specific property has been updated.
published: true
author: kmhuglen
comments: true
date: 2013-10-28 04:10:12
tags:
    - Orchestrator
    - PowerShell
    - Service Manager
    - SMlets
    - System Center
categories:
    - it-pro
permalink: /2262
image:
    feature: Runbook_MonitorUpdatedChangeRequests.png
---
There is no god way to determine if a specific property has changed on a work-item, with the use of the Service Manager Integration Pack. By using PowerShell and SMlets you can go trough the history of the object to see which property was last changed.

In this example I use Orchestrator and PowerShell to determine if the Schedule start date or Schedule end date has been updated on a Change Request and then invoke another runbook.

**Runbook**



**Workflow**

  * First I use the **Monitor Object** activity in the **Service Manager 2012 Integration Pack** to get **Change Requests that has been updated** in Service Manager
  * Next I use a **Run .Net Script** activity to run a **PowerShell** script utilizing **SMlets**() to go through the **history of the work-item** to see if the last change was on a property with the name “Sched*”, and publish **True or False to ObjectChanged**.

import-module smlets 

$ObjectChanged = $false

$object = Get-SCSMObject -Id '[SC Object Guid from “Monitor Updated Change Request”]'
$history = Get-SCSMObjectHistory -object $object

$countofchanges = $history.history.count -1
$changes = $history.History[$countofchanges]

foreach ($change in $changes.changes)
{
	if ($change.Name -like "Sched*")
	{
		$ObjectChanged = $true
	}
}

  * Then I use the **ascending Link** to only include objects if the **ObjectChanged was True**