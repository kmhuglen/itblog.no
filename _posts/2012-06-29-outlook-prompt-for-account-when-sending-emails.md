---
layout: post
title: 'Outlook: Prompt for account when sending emails'
published: true
author: Knut Magne Huglen
comments: true
date: 2012-06-29 09:06:40
tags:
    - Office
    - Office 365
categories:
    - it-pro
permalink: /1162
---
**EDIT**: Updated post for Outlook 2016
  
**EDIT**: Updated post for Outlook 2013

I often configure my Outlook to different Exchange and other IMAP accounts, and by accident send from the wrong account. In earlier version of Outlook, I made a VBA macro to control the account for sending email. But since I always forget to back up my VBA project and/or backup my profile when refreshing the computer, it is now lost. And I don&#8217;t bother to create it again.

Today, after a simple Google search, I found a nice article regarding this subject. There is a registry tweak that will turn the New Mail form in Outlook to not have a default account selected.

The article [Always prompt for sending account][1] at [MSOutlook.info] describe how to enable the native support in Outlook 2010 and also gives more tips about earlier versions.

**Enable native support in Outlook 2016 to clear the FROM field on New Email forms.**

  * **Key**: HKEY\_CURRENT\_USER\Software\Policies\Microsoft\office\16.0\outlook\options
  * **Value name**: forceaccountselection
  * **Value type**: REG_DWORD
  * **Value**: 1

**Outlook 2016**
  
<script src="https://gist.github.com/kmhuglen/6d4f526ec8494f600ada.js"></script>
  
**Outlook 2013**
  
<script src="https://gist.github.com/kmhuglen/6f6363a9199d701c9ea1.js"></script>
  
**Outlook 2010**

<script src="https://gist.github.com/kmhuglen/c8534740f062b517c8be.js"></script>

[1]: http://www.msoutlook.info/question/477
[2]: http://www.msoutlook.info/