---
layout: post
title: "Update Service Manager CMDB with Warranty Information about computers from Dell's AssetService Web Service using Orchestrator"
published: true
author: kmhuglen
comments: true
date: 2013-06-22 09:06:39
tags:
    - Orchestrator
    - PowerShell
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /1188
image:
    feature: Runbook_Dell_AssetService.png
---

  Here is an example of how to use the AssetTAG collected from Dell computers by Configuration Manager to get Start and End date for the Warranty using Dell&#8217;s own Web Service and updating the Service Manager CMDB with the information.



  By setting up a connector in Service Manager to Configuration Manager, the CMDB of Service Manager gets populated with computers including their Serial Number.



  The Warranty Information is not one of the attributes that Configuration Manager can collect, as this information is not available on the computer it control.



  Dell has an Web Service that gives you the Start and End date of the Warranty if you provide a Asset TAG to it. (It can also provide other information regarding the computer) http://xserv.dell.com/services/AssetService.asmx


Utilizing Orchestrator to get the warranty dates and then update the computer object in Service Manager is a simple process. But first you would have to extend the Service Manager computer class with a WarrantyStartDate and a WarrantyEndDate.


  When the Class is extended I used a Orchestrator runbook as below to get the AssetTag (SerialNumber) and giving it to the Dell AssetService Web Service and then updating the computer object.



  