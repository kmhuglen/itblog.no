---
layout: post
title: The System Center Management service stops responding after an instance of SQL Server goes offline
published: true
author: Knut Magne Huglen
comments: true
date: 2014-02-05 12:02:37
tags:
    - SQL
    - Operations Manager
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /5936
---
```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\System Center\2010\Common\DAL

DWORD value name: DALInitiateClearPool
DWORD data: 1 (Decimal)

DWORD value name: DALInitiateClearPoolSeconds
DWORD data: 60 (Decimal)
```

Microsoft Support: [The System Center Management service stops responding after an instance of SQL Server goes offline][1]

[1]: https://support.microsoft.com/en-us/kb/2913046