---
layout: post
title: Get Last User Logon Timestamp from Active Directory
published: true
author: Knut Magne Huglen
comments: true
date: 2011-04-15 12:04:36
tags:
    - VBScript
    - Active Directory
categories:
    - it-pro
permalink: /818
---
VBScript program to determine when each user in the domain last logged on. Domain must be at Windows Server 2003 Functional Level.

The *lastLogonTimeStamp* attribute is Integer8, a 64-bit number representing the date as the number of 100 nanosecond intervals since 12:00 am January 1, 1601. This value is converted to a date. The last logon date is in UTC (Coordinated Univeral Time). It must be adjusted by the Time Zone bias in the machine registry to convert to local time.

Save this script as file with whatever filename you like. It will produce an output file withe the same name as the scriptfile name adding .csv at the end. You can then open the file with Execl and use the collected data as you like.

<script src="https://gist.github.com/kmhuglen/717d7f1bac11b54d94d77140ba81f354.js"></script>