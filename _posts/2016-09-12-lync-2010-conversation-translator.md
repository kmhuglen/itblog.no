---
layout: post
title: Lync 2010 Conversation Translator
published: true
author: kmhuglen
comments: true
date: 2011-08-01 01:08:17
tags:
    - Lync
categories:
    - it-pro
permalink: /890
image:
    feature: image_thumb.png
---
Just by adding a few registry entries in the Current User hive, you can have a conversation with a person in a different language and every sentence will be translated on the fly (on a window at the side of the conversation).

Copy the following to a text file and name it something.reg, double click, and you’ve got the new menu. (restart Lync if menu don’t appear at once.

[code title=&#8221;Lync2010ConversationTranslator.reg&#8221;]Windows Registry Editor Version 5.00

[HKEY\_CURRENT\_USERSoftwareMicrosoftCommunicatorContextPackages{54C2C31A-A291-4DFA-825A-18994EBE9877}]
  
&#8220;Name&#8221;=&#8221;Conversation Translator&#8221;
  
&#8220;ExtensibilityApplicationType&#8221;=dword:00000000
  
&#8220;ExtensibilityWindowSize&#8221;=dword:00000001
  
&#8220;DefaultContextPackage&#8221;=dword:00000000
  
&#8220;InternalURL&#8221;=&#8221;http://input.microsoft.com/translator/OCTranslatorTestPage.html&#8221;
  
&#8220;ExternalURL&#8221;=&#8221;http://input.microsoft.com/translator/OCTranslatorTestPage.html&#8221;

[HKEY\_CURRENT\_USERSoftwareMicrosoftWindowsCurrentVersionInternet SettingsZoneMapDomainsmicrosoft.cominput]
  
&#8220;http&#8221;=dword:00000002[/code]

[][1]

[][2]

Source: [http://msdn.microsoft.com/en-us/library/gg436843.aspx][3]

 [1]: /wp-content/uploads/image.png
 [2]: /wp-content/uploads/image1.png
 [3]: http://msdn.microsoft.com/en-us/library/gg436843.aspx "http://msdn.microsoft.com/en-us/library/gg436843.aspx"