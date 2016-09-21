---
layout: post
title: Time Synchronization in a Windows Domain
published: true
author: Knut Magne Huglen
comments: true
date: 2011-03-28 12:03:32
tags:
    - Time
    - Windows
    - Windows Server
    - Windows Domain
categories:
    - it-pro
permalink: /783
---
In a Windows domain, correct time is essential for services using Kerberos and your should therefore consider configure the the time service to synchronize against an external time source. 

![1]

All Windows clients synchronize against a domain controller. All domain controllers synchronize against the domain’s PDC Operation Master. You should therefore only configure the domain controller hosting the PDC Operation Master role to synchronize against an external time source.

> In a virtual environment where the domain controller hosting the PDC role is a virtual machine and the virtual machine host server synchronize against the PDC - time can really get out of sync.

Locate the domains PDC Operation Master role by running this command 

`netdom /query fsmo`

Ensure that UDP port 123 (in- and outbound) is open in your firewall, then execute the following commands to configure the Windows Time Service to synchronize against the NTP.org’s time server pool. 

```
net stop w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org,1.pool.ntp.org,2.pool.ntp.org"
w32tm /config /reliable:yes
net start w32time 
```

If your in the situation that your servers are faulty configured, and you need to reset them to synchronize against the domain again, run the following commands:

**Windows 2003/2008/2012:**

```
w32tm /config /syncfromflags:DOMHIER /Update
w32tm /resync /nowait /rediscover 
```

**Windows 2000:** 

```
w32tm /config /syncfromflags:DOMHIER
sc stop w32time
sc start w32time
```

External time source:
  
  * [USNO NTP Network Time Servers][2]
  * [NIST Internet Time Service (ITS)][3]
  * [pool.NTP.org][4]

[1]: /assets/2011-03-28_windows-time-service_1.png
[2]: http://tycho.usno.navy.mil/ntp.html
[3]: http://tf.nist.gov/tf-cgi/servers.cgi
[4]: http://www.pool.ntp.org/