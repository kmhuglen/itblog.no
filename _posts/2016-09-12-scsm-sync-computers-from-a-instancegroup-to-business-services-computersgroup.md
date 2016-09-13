---
layout: post
title: "SCSM: Sync Computers from a InstanceGroup to Business Service's ComputersGroup"
published: true
author: kmhuglen
comments: true
date: 2014-10-30 01:10:21
tags:
    - PowerShell
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /5644
---
I could not find an intuitive way of adding a Dynamic Group of Computers (InstanceGroup) into the ServiceMap on a Business Service. Instead I added a regular ComputersGroup to the ServiceMap of the Business Service and utilized PowerShell to update the ComputersGroup with Objects from the InstanceGroup. This can of course be scheduled to run by Windows Scheduler, Orchestrator or SMA every hour, day or whatever. 

Param(
[Parameter(Mandatory=$true)] 
[string]$ComputerInstanceGroupDisplayName
,
[Parameter(Mandatory=$true)] 
[string]$BusinessServiceDisplayName
,
[Parameter(Mandatory=$true)] 
[string]$BusinessServiceComputerGroupDisplayName
)

$BusinessServiceClass = Get-SCSMClass -Name Microsoft.SystemCenter.BusinessService
$BusinessService = Get-SCSMObject -Class $BusinessServiceClass -Filter "DisplayName -eq $BusinessServiceDisplayName"
$BusinessServiceComputerGroup = Get-SCSMRelatedObject $BusinessService | Where {$_.DisplayName -eq $BusinessServiceComputerGroupDisplayName}
$BusinessServiceComputerGroupComputers = Get-SCSMRelatedObject $BusinessServiceComputerGroup

$InstanceGroupClass = Get-SCSMClass -Name InstanceGroup | Where {$_.DisplayName -eq $ComputerInstanceGroupDisplayName}
$InstanceGroup = Get-SCSMObject -Class $InstanceGroupClass
$InstanceGroupComputers = Get-SCSMRelatedObject $InstanceGroup

$Computers = Compare-Object -ReferenceObject $BusinessServiceComputerGroupComputers -DifferenceObject $InstanceGroupComputers -PassThru
IF ($Computers)
{
    $REL_ConfigItemContainsConfigItem = Get-SCSMRelationshipClass -Name System.ConfigItemContainsConfigItem
    Foreach ($Computer in $computers)
    {
        New-SCSMRelationshipObject -Relationship $REL_ConfigItemContainsConfigItem -Source $BusinessServiceComputerGroup -Target $Computer -Bulk
    }
}
