---
layout: post
title: >
    Add Business Service to Change Request in Service Manager
    based on related Windows Computers
published: true
author: Knut Magne Huglen
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
    feature: 2013-10-28_AddBusiness3.png
---
IT Operations makes lot of changes to Windows Servers, and does not always know which Business Service that particular server is supporting.

In a Change Process, one would often want the business service owner to be able to review a change, or at least be notified of changes that are performed on computers related to his or her services. In Service Manager Information about Service Owners are associated to Business Service, so to a be able to automate that process one would have to require that Change Request has a Business Service related to it.

To ease the change process so that IT operations don&#8217;t have to know, or go through the Business Service to find out which Business Service the Windows Server is associated every time, one can automate the process by utilizing Orchestrator.

Her is an example of how I have implemented it.

**First Runbook: Initiate Change Request**

![](/assets/2013-10-28_AddBusiness1.png)
  
This is the Runbook that is started by the Runbook Automation Activity in the Change Request Template, it uses the ActivityID from the Automation Runbook Activity as input. It then gets the Runbook Automation Activity Object and then the Related Change Request and finally starts a second Runbook with the Guid of the Change Request as input.

**Secound Runbook: Relate Business Services based on related Windows Computers** 

![](/assets/2013-10-28_AddBusiness2.png)

This Runbook is started from the first, and takes the Change Request GUID as an input. It gets all related Windows Computers of the Change Request and start the third Runbook that uses the Principal Name of a Windows Computer as input and the DisplayName of a Business Service as output. It then find the Business Service Object and finally relate it with the About Configuration Item Relationship to the Change Request.

**Runbook: Get Parent Business Service** 

![](/assets/2013-10-28_AddBusiness3.png)

<script src="https://gist.github.com/kmhuglen/0e137f2a60fb3d940bd25f0c4bd565ff.js"></script>

With these Runbooks and the above PowerShell script you can start adding review activates to the Change Request and utilize the related Business Service Users in Review Activities or just in E-Mails for notification.

Thanks to [**Christian Booth**](http://blogs.technet.com/b/servicemanager/archive/2013/09/18/scsm-console-extensions-impacted-business-services.aspx) for the idea and [**Marcel**](http://marcelzehner.ch/2013/10/05/from-ci-to-parent-business-service-beta-version/#more-2723) for an almost finished powershell script. :-)