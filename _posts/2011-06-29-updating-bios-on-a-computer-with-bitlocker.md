---
layout: post
title: Updating BIOS on a computer with Bitlocker
published: true
author: Knut Magne Huglen
comments: true
date: 2011-06-29 02:06:00
tags:
    - BitLocker
    - Windows
categories:
    - it-pro
permalink: /902
image:
    feature: image20.png
---
Before updating BIOS or doing changes to the BIOS on a computer that has BitLocker enabled, suspend BitLocker encryption before you update the BIOS.

If BitLocker was not suspended, the computer will not accept your BitLocker key the next time your computer boots and the only way you can start your computer is with a recovery key. You will be asked to enter the recovery key every time you restart your computer unless you suspend and resume BitLocker.

In order to avoid having to get into this dilemma, you can suspend BitLocker before you run the BIOS update utility for you computer. Here’s how:

1. Go to *Control Panel* > *System and Security* > *BitLocker Drive Encryption*

![1]

2. Choose *Suspend Protection* and confirm it by responding *Yes*

![2]![3]

3. Go ahead and update the BIOS. Restart your computer afterwards.

4. Resume BitLocker after the reboot, by click *Resume Protection*

![4]

[1]: /assets/2011-06-29_image1.png
[2]: /assets/2011-06-29_image2.png
[3]: /assets/2011-06-29_image3.png
[4]: /assets/2011-06-29_image4.png