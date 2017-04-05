---
layout: post
title: Migrating Print Service from Windows Server 2003/2008 (x86)
    to 2008 R2 (x64)
published: true
author: Knut Magne Huglen
comments: true
date: 2012-04-25 03:04:25
tags:
    - VBScript
    - PowerShell
    - Windows Server
categories:
    - it-pro
permalink: /1103
---
You will be coming in the scenario where you will have to do a cross platform migrating of your print servers. Windows Server 2008 R2 is an x64 operation system and a regular backup and restore is not gone cut it anymore. Great blog posts about this on TechNet:

  * [Cross-Architecture print server migrations: Speeding up the migration process][1]
  * [Best practices on deploying a Microsoft Windows Server 2008/Windows Server 2008 R2 Print Server][2]
  * [Migrating Print Queues quickly using PRINTBRM, configuration files, and the Generic/Text Only Driver][3]
  * [Two Minute Drill: PRINTBRM and the Configuration File][4]

Almost everything in this post is gathered from those blog posts. I recommend reading the original blog post as mine is simplified for my own use.

**Requirements**

  * A Vista/2008 or higher computer with the Print Management Snap-in installed. 
      * Make a temporary folder for the output data, share it and open CMD from that folder.
  * A source server running Windows Server 2003/2008 (x86)
  * A target server running Windows Server 2008 R2 (se Preparing the new Print Server below)

### Exporting and importing print queues

Run the following command against the source server:

`C:\Windows\System32\spool\tools\PrintBrm.exe -B -S SOURCESERVER -F NOBIN_SOURCESERVER.PrinterExport -NOBIN`

This will create an export of all queues on the SOURCESERVER without the drivers (binaries).

Then download the `CreateBRMConfigXML.vbs` script and save it to the temporary folder/share accessable from the SOURCESERVER.

<script src="https://gist.github.com/kmhuglen/648fd2b4bacd8a6861420fe65afe84ee.js"></script>

Logon to the SOURCESERVER and open CMD, run the following command from the source server:

`Cscript.exe //NOLOGO TEMPSHARE\CreateBRMConfigXML.vbs > TEMPSHARE\SOURCESERVER_DriverMapping.XML`

The `SOURCESERVER_DriverMapping.XML` will now have a mapping table for all queues and their driver, where the driver is replaced with a Generic / Text Only driver.

You can now import the `NOBIN_SOURCESERVER.PrinterExport` using the `SOURCESERVER_DriverMapping.XML` as a configuration file, and all queues would be imported with the generic driver.

Or you could open the `SOURCESERVER_DriverMapping.XML` in Excel 2010, select open as XML table, and alter the mapping table to use OEM universal drivers or OEM specific print drivers.

Remember to install both the x86 **AND** x64 driver on the target system prior to importing the queues. Driver names must match **EXACTLY** with the installed driver.

To import the exported queues using the `DriverMapping.XML` file run the following command:

`C:\Windows\System32\spool\tools\Printbrm.exe –R –S TARGETSERVER -F NOBIN\SOURCESERVER.PrinterExport –C SOURCESERVER\_DriverMapping.XML –O FORCE -NOBIN`

> PS: You will get an error running the above command on a newly installed print server. Create a printer queue and share it to make the **print$** share available on the new  print server.

If you get error on some of the printer queue, then there may be a problem with the print processor. The easy solution would be to change the print prosessor on the source server before backing up the print queue.

Use the `SetPrinter.EXE` tool located in the Windows Server 2003 Resource Kit or use PowerShell

List all Printers and the corresponding Print Processor:

`Get-WmiObject Win32_Printer | ft name,printprocessor`

Set all Printer to WinPrint

`Missing PowerShell Commando`

Another solution is to change the print processor in the printerExport file.

Unpack the printerExport file and open the {guid}.xml file corresponding to the failed queue, change the printprocessor="OLDVALUE" to printprocessor="NEWVALUE". NEWVALUE would be the corresponding print processor for the installed driver on the target server.

Unpack the printerExport file:

`C:\Windows\System32\spool\tools\Printbrm.exe -D NOBIN\_SOURCESERVER\_PRINTEXPORT\_UNPACK -R -F NOBIN\_SOURCESERVER.PrinterExport`

Compress the altered folder into printerExport again:

`C:\Windows\System32\spool\tools\Printbrm.exe -D NOBIN\_SOURCESERVER\_PRINTEXPORT\_UNPACK -B -F NOBIN\_SOURCESERVER_MODIFIED.PrinterExport`

### Preparing the new Print Server:

#### Disable the Terminal Server (Remote Desktop) Print Redirection

Click on Start, Control Panel, Administrative Tools, Terminal Services, Terminal Services Configuration (Run as Administrator), right click on the RDP-Tcp, click on Properties, Client Settings tab, under the *Disable the following*, check the box for Windows Printer. Click on Ok, Log off, Log back in, Click on Start, Control Panel, Printers, delete all the print queues there. Click on Server Properties, Click on the Drivers tab, Select all the driver (shift key), Click on Remove…  Stop and restart the Print Spooler service

#### Antivirus exeptions

Make sure that your antivirus doesn’t scan `\*.spl, \*.shd or *.tmp` files (or `c:\windows\system32\spool\printers` folder standalone or `c:\windows\system32\spool\{GUID}\printers` for clusters)

#### Print drivers

Start with the latest universal driver, if not good enough then try OEM specific drivers, but keep only one, PCL 5, PCL 6 or Postscript (PS) in the driver catalog.

 [1]: http://blogs.technet.com/b/askperf/archive/2011/03/11/cross-architecture-print-server-migrations-speeding-up-the-migration-process.aspx
 [2]: http://blogs.technet.com/b/yongrhee/archive/2009/09/14/best-practices-on-deploying-a-microsoft-windows-server-2008-windows-server-2008-r2-print-server.aspx
 [3]: http://blogs.technet.com/b/askperf/archive/2012/04/03/migrating-print-queues-quickly-using-printbrm-configuration-files-and-the-generic-text-only-driver.aspx
 [4]: http://blogs.technet.com/b/askperf/archive/2009/02/20/two-minute-drill-printbrm-and-the-configuration-file.aspx