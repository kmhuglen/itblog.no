---
layout: post
title: Rerun Runbook Activities with status In Progress
published: true
author: kmhuglen
comments: true
date: 2016-02-08 04:02:10
tags:
    - Orchestrator
    - PowerShell
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /5875
---
After an incident with the Orchestrator server, several runbook activities in Service Manager did not complete and ended up in status of In Progress but nothing happens.

To rerun all runbook activities that had this status, I wrote a small PowerShell script that found all runbook activities with status In Progress and where LastModified date where older than a day.

<script src="https://gist.github.com/kmhuglen/71ad3f307dfdd976d5a7.js"></script>