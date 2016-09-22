---
layout: post
title: Windows and Office KMS Host Configuration
published: true
author: Knut Magne Huglen
comments: true
date: 2011-04-05 02:04:05
tags:
    - Office
    - Windows
    - Windows Server
    - VBScript
categories:
    - it-pro
permalink: /1124
---
Use a the newest available Windows Server version (Datacenter or Standard/Enterprise) server as your KMS Host. Older versions of Windows Server/Edition or client OS will limit the Windows Version/Edition that could be served by your KMS Host.

> The Windows Server acting as a KMS Host MUST be a Datacenter Edition if serving Datacenter Editions.

**Configure the KMS Host to serve Windows OS Licenses**

Open command prompt with Administrative privileges, and execute:

```
cd C:\Windows\system32
cscript c:\Windows\System32\slmgr.vbs /ipk xxxxx-xxxxx-xxxxx-xxxxx-xxxxx
```

Replace xxxxx-xxxxx-xxxxx-xxxxx-xxxxx with your Windows Server 2008 R2 KMS-C or B Product Key.

> KMS-C is the Datacenter edition and KMS-B is the Standard/Enterprise Edition. Use the KMS-C Product Key if you have Datacenter License. See the TechNet article [KMS Host Keys to Products Activated][1] for more dept into what key will serve what windows edition._

In Windows Firewall, click on Exceptions and allow the now listed Key Management Services.

**Test the KMS server configuration**

```
nslookup
set type=srv
_vlmcs._tcp.contoso.com
```

Should output:

```
_vlmcs._tcp.contoso.com         SRV service location:
          priority       = 0
          weight         = 0
          port           = 1688
          svr hostname   = kmshost.contoso.com
kmshost.contoso.com        internet address = 10.0.0.99
```

**Management Tool**

Download and install [Volume Activation Management Tool (VAMT)][2] for reporting/management. (optional)

**Configure the KMS Host to serve Office 2010 Licenses**

Download the [Microsoft Office 2010 KMS Host License Pack][3] from Microsoft and install it. It will ask you for the Office 2010 KMS key and then activate it against Microsoft Activation Servers.

Run the following command line to display licens information on the KMS Host:

`cscript c:\Windows\System32\slmgr.vbs /dli`

* [See TechNet for slmgr.vbs Options][4].

> **Slmgr.vbs** script is not intended to work across platforms. To manage remote clients, use the [Volume Activation Management Tool (VAMT)][2]

[1]: http://technet.microsoft.com/library/ff793422.aspx
[2]: http://www.microsoft.com/en-us/download/details.aspx?id=11936
[3]: http://www.microsoft.com/downloads/en/details.aspx?FamilyID=97b7b710-6831-4ce5-9ff5-fdc21fe8d965&displaylang=en
[4]: http://technet.microsoft.com/en-us/library/ff793433.aspx