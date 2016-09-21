---
layout: post
title: User Inputs from SCSM Portal to Description field using Orchestrator
published: true
author: Knut Magne Huglen
comments: true
date: 2013-12-16 05:12:20
tags:
    - Orchestrator
    - PowerShell
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /4462
image:
    feature: 121613_1123_UserInputsf4.png
---
There are several blog posts already about how to get the User Input from a Service Request or Incident Request formatted and put into the description field.

But I wanted to use Orchestrator so I could make changes without having to recompile the solution every time. I used some of the script published by [Kurt Van Hoecke at Authoring Friday][1] in my orchestrator version.

Another blog: Solution to clean User Input from Service Manager Portal and commit it to the Action Log @ Coretech Blog

**Orchestrator Monitor Runbooks** 

![][2]

![][3]

![][4]

Orchestrator is set up with a generic Service Manager monitor for new Incident Request and Service Request , and using the Link Include Filter, I send all new incident and service request with source Portal to the Runbook.

**UserInput to Description Runbook**

![][5]

1. I take the ID of the Work Item as an input in the Initialize Data activity.
2. Link filter WorkItemID starts with IR or SR.
3. In the Get Incident/Service Request activity I have a filter ID equals WorkItemID from Initialize Data.
4. The UserInput from the Get Get Incident/Service Request activity are used in the script in Get IR/SR UserInput.
5. And finaly I update the IR/SR description field.

Here I use the Execute PS Secript activity from the [Orchestrator Integration Pack for PowerShell Script Execution 1.2][6] for my Get IR/SR UserInput activities, but the default Run .Net Script Activity would also work just fine.

<script src="https://gist.github.com/kmhuglen/fb66e63389f1d81694e3e5c771db211b.js"></script>

[1]: http://www.authoringfriday.com/2013/12/08/scsm-portal-user-input-to-description-of-the-work-item/
[2]: /assets/2013-12-16_UserInputsf1.png
[3]: /assets/2013-12-16_UserInputsf2.png
[4]: /assets/2013-12-16_UserInputsf3.png
[5]: /assets/2013-12-16_UserInputsf4.png
[6]: http://gallery.technet.microsoft.com/Orchestrator-Integration-438f9ece