---
layout: post
title: Bitlocker failure introduction
published: true
author: Knut Magne Huglen
comments: true
date: 2011-12-13 10:12:19
tags:
    - Active Directory
    - BitLocker
categories:
    - it-pro
permalink: /986
---
**Before altering BIOS, drives, partitions and volumes**
  
If you alter the BIOS, drives partition and volumes protected by Bitlocker the result will in most cases be that the OS is asking for the Recovery Password before boot. By suspending the Bitlocker on all drives before alter any bios or volumes; you’ll save yourself a lot of hassle.

**Bitlocker Active Directory Recovery Password Viewer**

Use a computer running Windows Server 2008 R2 or Windows 7 with RSAT installed

* Install the Active Directory Users and Computers MMC from Turn Windows Feature On or Off
* Register the Bitlocker MMC extension: regsvr32.exe BdeAducExt.dll
* Open a computer objects properties and go to the Bitlocker Recovery tab

In most cases you are able to unlock Bitlocker protected harddrives just by providing the Recovery Password when asked.

**Suspend the Bitlocker**
  
When a computer starts asking for Recovery Password, the fastest way to fix it is to suspend and then turn it on again after a reboot.

[See my erlier post about suspending bitlocker here][1]

**Using the BitLocker Repair Tool to Recover a Drive**
  
The BitLocker Repair Tool (Repair-bde) is a command-line tool included with Windows 7 and Windows Server 2008 R2. This tool can be used to access encrypted data on a severely damaged hard disk if the drive was encrypted by using BitLocker Drive Encryption. Repair-bde can reconstruct critical parts of the drive and salvage recoverable data as long as a valid recovery password or recovery key is used to decrypt the data. The Repair-bde command-line tool is intended for use when the operating system does not start, or when you cannot start the BitLocker Recovery Console. If a drive has been physically damaged, it may not be recoverable.

To repair a BitLocker-protected drive by using Repair-bde

You need the following setup:

* A Machine running Windows 7 with an extra volume with the same or more capacity as the damaged volume.
* The Recovery Password for the damaged disk (stored in Active Directory on the Computer Object)

1. Connect the damaged disk to the machine and start up windows.
2. Open a Command Prompt window as an administrator.
3. Use diskpart to determine the volume for the damaged disk and the volume that will be used for decrypting the damaged disk to.

```batch
diskpart
DISKPART list volume
exit
```

1. At the command prompt, type the following commands:

```batch
repair-bde <InputVolume> <OutputVolumeorImage> -recoverypassword <recovery-password>
```

Example:

```batch
repair-bde E: Z: -rp 062612-026103-175593-225830-027357-086526-362263-513414
```

**More information from Microsoft TechNet on this subject:**

* Using the BitLocker Active Directory Recovery Password Viewer to View Recovery Passwords
* Turning Off BitLocker Drive Encryption (Windows 7)
* Repair-bde.exe Parameter Reference
* Using the BitLocker Repair Tool to Recover a Drive

[1]: /902