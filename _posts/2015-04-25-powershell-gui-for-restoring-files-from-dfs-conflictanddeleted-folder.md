---
layout: post
title: AutoCAD and Distributed file system | PowerShell GUI restoring deleted files
published: true
author: Knut Magne Huglen
comments: true
date: 2015-04-25 02:04:06
tags:
    - AutoCAD
    - DFS
    - PowerShell
    - Tools
    - Windows Server
categories:
    - it-pro
permalink: /5800
---
**Problem**

PeerLink has the ability to keep Lock on files while the file is replicated, if interested se also their solution for CAD File Collaboration

A client of mine uses Windows Server 2008 R2 file servers with Distributed files service (Dfs) for their AutoCAD Project. For several years, it worked without problems. After adding a new Windows Server 2012 R2 file server to the solution, some .dwg files went missing right after the project where saved.

[Autodesk DOES NOT support Distributed File System (Dfs)][1], so no help there. After searching the web, I found[ other facing the same problem][2]. However, no satisfied solution.

**Possible solutions** (not tested by me)

*a) Forcing all clients and servers to use the same version of SMB.*

* [Windows Server 2012 R2: Which version of the SMB protocol (SMB 1.0, SMB 2.0, SMB 2.1, SMB 3.0 or SMB 3.02) are you using?][3]

* Disabling SMB3 would also disable SMB2, as they both use the same stack, forcing everything to go back to the [Stone Age using only SMB1.][4]

* [How to enable and disable SMBv1, SMBv2, and SMBv3 in Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows 8, and Windows Server 2012][5]

*b) Downgrade to Windows Server 2008 R2.*

* While this probably would work, there is the issue that [Windows Server 2008 R2 Mainstream support ended January 13 2015][6].

**Workaround** (while further troubleshooting)

A simple PowerShell GUI script for easy file restore from the DfsrPrivate\ConflictAndDeleted folder.
  
<script src="https://gist.github.com/kmhuglen/b5e64c96db66b0aa50af.js"></script>

The script has two parameters, ComputerName and Filter. By default it use the computer name of the computer you start the script on, and *.dwg as filter.

First, it gets all the Replicated Folders on the server, then goes through the conflictanddeletedmanifest.xml of each replicated folder and display it all in a grid view.

Selecting one or several files and clicking OK, starts a copy-item (with –confirm) job on each selected item.

**Solution**

*UPDATED: June 2. 2016*
  
I talked to [Peer Software][7] about the problem as they had several products that should be able to fix the problem.

I briefly tested their [Trial version of PeerLock for Microsoft DFS][8] and it seem to fix the problem in my Lab environment. But as Peer Software would not recommend that product for our use (high latency and unstable VPN connection to other location), we did not go forward with that solution.

Peer Software had another product [PeerLink][9] that would fit our requirement.

PeerLink has the ability to keep Lock on files while the file is replicated, if interested see also their solution for [CAD File Collaboration][10]

**Curiosity**

* [Dfs vs DFS][11]

[1]: http://knowledge.autodesk.com/search-result/caas/sfdcarticles/sfdcarticles/Distributed-File-System-DFS-support.html
[2]: http://forums.autodesk.com/t5/autocad-2013-2014-2015-2016/windows-dfs-deleting-autocad-dwg/td-p/5173101
[3]: http://blogs.technet.com/b/josebda/archive/2013/10/02/windows-server-2012-r2-which-version-of-the-smb-protocol-smb-1-0-smb-2-0-smb-2-1-smb-3-0-or-smb-3-02-you-are-using.aspx
[4]: http://en.wikipedia.org/wiki/Server_Message_Block#History
[5]: https://support.microsoft.com/en-us/kb/2696547
[6]: https://support.microsoft.com/en-us/lifecycle/search?sort=PN&alpha=Windows%20Server%202008%20R2
[7]: http://www.peersoftware.com/
[8]: http://www.peersoftware.com/solutions/file-locking-for-ms-dfsr.html
[9]: http://www.peersoftware.com/products/file-collaboration/peerlink.html
[10]: http://www.peersoftware.com/solutions/cad-file-sharing-for-windows-and-netapp.html
[11]: http://windowsitpro.com/windows-client/dfs-vs-dfs