---
layout: post
title: Switch between Hyper-V and VMware on Windows
published: true
author: Knut Magne Huglen
comments: true
date: 2015-04-14 02:04:01
tags:
    - Dual Boot
    - Hyper-V
    - VMware
    - Windows
categories:
    - it-pro
permalink: /5783
---
Do you already use Hyper-V in Windows 8, and need to run other virtualization solutions?

You are not able to install other hypervisors when the Hyper-V feature is installed. You could uninstall the Hyper-V feature or dual booting between an installation with Hyper-V and one without. Taking up double the disk space, and the extra effort keeping two operating system up-to-date.

A better solution could be to use BCDEdit to create two boot options, one with Hyper-V and one where the Hyper-V hypervisor is turned off. Giving you the ability to install VMware, Virtual Box or other visualization solution without the Hyper-V feature giving your problem.

To create the Boot Options with BCDEdit run the following commands in an elevated command prompt.

`bcdedit /copy {current} /d "Hyper-V"`

`bcdedit /set {current} hypervisorlaunchtype off`

Next time you reboot you will see a Boot Menu. If you do not select anything, after 30 seconds, Windows 8.1 will boot up with the Hyper-V feature disabled.

You can configure the default boot options by going to Control Panel\System and Security\System, select &#8220;Advanced system settings&#8221; from the left side, go to Advanced pane and click the Settings button within the Setup and Recovery section. Here you can select with operation system would be your default operating system, configure the amount of second to wait for input etc.