---
layout: post
title: Installing Orchestrator Integration Packs for Service Manager 2010 and 2012 in the right order.
published: true
author: Knut Magne Huglen
comments: true
date: 2012-03-30 01:03:30
tags:
    - Orchestrator
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /1097
---
When installing both *Service Manager 2010 Integration Pack* and *System Center Integration Pack for System Center 2012 Service Manager (RC)* on System Center 2012 Orchestrator Release Candidate, then you could get a connection error if they are not installed in the proper order.

> Connection failed:
> 
> Unable to connect to the server specified. Verify connection settings are valid and retry.

The solution for **System Center 2012 Orchestrator RC** edition is to first install the IP for SCSM2012 then the IP for SCSM2010.

If you already have installed the IP for SM2010 then uninstall it thought Programs and Features on the Runbook server, and deploy it again thought the Deployment Manager.

Download: [System Center 2012 – Orchestrator 2012 Component Add-ons and Extensions][1] from Microsoft Download Center

**EDIT 2012-06-21:**

I tried the same procedure on a fresh installed **System Center 2012 Orchestrator RTM** version with IP for *System Center Integration Pack for System Center 2012 Service Manager* and *System Center Integration Pack for System Center Service Manager 2010* and got the same error. To resolve it I tried reinstalling, in different order, without luck.

Finally I found the solution:

  * Deploy both IPs to the Runbook Server
  * Logon to the Runbook server and open a CMD with elevated rights (Run as Administrator)
  * Run the **msiexec.exe repair** function against the Service Manager 2010 IP MSI.

```
CD "C:\Program Files (x86)\Common Files\Microsoft System Center 2012\Orchestrator\Management Server\Components\Objects"
  
msiexec /faumsv Microsoft.SystemCenter.Orchestrator.Integration.SCSM2010.msi
```

 [1]: http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=28725