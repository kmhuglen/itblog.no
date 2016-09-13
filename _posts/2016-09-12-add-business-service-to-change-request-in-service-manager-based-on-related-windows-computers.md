---
layout: post
title: >
    Add Business Service to Change Request in Service Manager
    based on related Windows Computers
published: true
author: kmhuglen
comments: true
date: 2013-10-28 09:10:43
tags:
    - Orchestrator
    - PowerShell
    - Service Manager
    - SMlets
    - System Center
categories:
    - it-pro
permalink: /2382
image:
    feature: 102813_2030_AddBusiness3.png
---
IT Operations makes lot of changes to Windows Servers, and does not always know which Business Service that particular server is supporting.

In a Change Process, one would often want the business service owner to be able to review a change, or at least be notified of changes that are performed on computers related to his or her services. In Service Manager Information about Service Owners are associated to Business Service, so to a be able to automate that process one would have to require that Change Request has a Business Service related to it.

To ease the change process so that IT operations don&#8217;t have to know, or go through the Business Service to find out which Business Service the Windows Server is associated every time, one can automate the process by utilizing Orchestrator.

Her is an example of how I have implemented it.

**First Runbook: Initiate Change Request
  
** 

![][1]**
  
** This is the Runbook that is started by the Runbook Automation Activity in the Change Request Template, it uses the ActivityID from the Automation Runbook Activity as input. It then gets the Runbook Automation Activity Object and then the Related Change Request and finally starts a second Runbook with the Guid of the Change Request as input.

 **Secound Runbook: Relate Business Services based on related Windows Computers
  
** 

![][2]

This Runbook is started from the first, and takes the Change Request GUID as an input. It gets all related Windows Computers of the Change Request and start the third Runbook that uses the Principal Name of a Windows Computer as input and the DisplayName of a Business Service as output. It then find the Business Service Object and finally relate it with the About Configuration Item Relationship to the Change Request.

**Runbook: Get Parent Business Service
  
** 

![][3]

$SMServer = '{Service Manager Server}'

$selectedobjectobjectdisplayname = '{Windows Computer Principal Name}'

### Check if object is selected, if not exit 
if($selectedobjectobjectdisplayname -eq $null) {
	$Businessservice = "ObjectNotDefined"
	exit
}

### Import smlets module if needed 
if(!(Get-Module smlets)){Import-Module smlets -force}

$resulthash = @{}

### Get SCSM business services 
$bservices = get-scsmobject -ComputerName $SMServer -Class (get-scsmclass -computername $SMServer | where {$_.name -eq "system.service"})

### Get components of SCSM business services 
foreach($bservice in $bservices) { 
	$components = $null
	$componentsarray = @()
	$components = $bservice | get-scsmrelatedobject -Depth 1 -ComputerName $SMServer
	foreach($component in $components) { 
		$componentsarray += $component.name
	}
	$resulthash.add($bservice.displayname,$componentsarray)
}

### Search object guid 
$businessservices = $resulthash.GetEnumerator() | Where-Object {$_.Value -like $selectedobjectobjectdisplayname} | foreach{$_.key}

### Output
if($businessservices -eq $null) {$Businessservice = $False}

With these Runbooks and the above PowerShell script you can start adding review activates to the Change Request and utilize the related Business Service Users in Review Activities or just in E-Mails for notification.

Thanks to **Christian Booth** () for the idea and **Marcel** () for an almost finished powershell script. J

 [1]: http://itblog.cloudapp.net/wp-content/uploads/102813_2030_AddBusiness1.png
 [2]: http://itblog.cloudapp.net/wp-content/uploads/102813_2030_AddBusiness2.png
 [3]: http://itblog.cloudapp.net/wp-content/uploads/102813_2030_AddBusiness3.png