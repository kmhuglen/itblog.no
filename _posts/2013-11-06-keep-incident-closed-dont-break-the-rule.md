---
layout: post
title: "Keep incidents closed, don't break the rule."
published: true
author: Knut Magne Huglen
comments: true
date: 2013-11-06 03:11:28
tags:
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /3192
image:
    feature: 110613_1533_KeepInciden5.png
---
Many have implemented a template that sets the status of the Incident to Active or Updated by End User in the Exchange Connector when the connector process an e-mail with an [IRxxxx] already in Service Manager. Some have made similar workflows for when End User Comments are added, to notify the Assigned To User.

This is well and good, for Pending or Resolved Incidents but as the Exchange Connector will also do this on closed Incidents, it will break the best practice rule of ITIL and MOF.

This solution will (re-)Close the incident if the status changes from Closed to anything else, and also send an e-mail to the Affected User instructing him to open a new incident.

This is just a workaround if you have implemented a solution similar to the one described at the top. I would encourage you to change the other workflows, so an incident never changes a form Closed to Active in the first place.

  * Make a New Management Pack and call it something like &#8220;Custom Keep Closed Incident Closed&#8221;
 
      * AdministrationManagement Pack – Create Management Pack
      * ![][1]

  * Make a new Template for Incident with the status set to Closed and save it to the same MP
    
      * LibraryTemplate – Create Template
      * ![][2]
      * You will first have to resolve the Incident Template using the Change Incident Status Action
      * ![][3]
      * ![][4]
      * Then Close the Incident Template using the same Change Incident Status Action
      * ![][5]
      * ![][6]

  * Make a new Notification Template for Incident with instruction to the end user to create a new incident through the portal or remove the old Incident ID from the subject field.
      
      * AdministrationNotificationsTemplates – Create E-Mail Template
      * ![][7]
      * ![][8]
  
  * Make a new Workflow for Incident Events to trigger on update of incident
      
      * AdministrationWorkflowsConfigurationIncident event Workflow Configuration – Properties – Add
      * ![][9]
      * ![][10]
      * ![][11]
      * ![][12]
      * ![][13]

You can also clean the Incident template, to remove the Action log and other property that are not necessary by exporting the management pack and manually removing the unwanted stuff.

![][14]

  * Export the Management Pack and open it in Notepad
  * Locate the Incident Template, it is located under  
    
      * There are two of them one for the E-Mail Notification Template and one for the Incident Template
      * ![][15]
  
  * Remove everything between  and  except the line with the property for the Status

      * ![][16]
    
  * Import the Management Pack back into Service Manager
  * ![][17]

Download [Custom.KeepClosedIncidentClosed.xml][18] (Unseal Management Pack)

[1]: /assets/2013-11-06_KeepInciden1.png
[2]: /assets/2013-11-06_KeepInciden2.png
[3]: /assets/2013-11-06_KeepInciden3.png
[4]: /assets/2013-11-06_KeepInciden4.png
[5]: /assets/2013-11-06_KeepInciden5.png
[6]: /assets/2013-11-06_KeepInciden6.png
[7]: /assets/2013-11-06_KeepInciden7.png
[8]: /assets/2013-11-06_KeepInciden8.png
[9]: /assets/2013-11-06_KeepInciden9.png
[10]: /assets/2013-11-06_KeepInciden10.png
[11]: /assets/2013-11-06_KeepInciden11.png
[12]: /assets/2013-11-06_KeepInciden12.png
[13]: /assets/2013-11-06_KeepInciden13.png
[14]: /assets/2013-11-06_KeepInciden14.png
[15]: /assets/2013-11-06_KeepInciden15.png
[16]: /assets/2013-11-06_KeepInciden16.png
[17]: /assets/2013-11-06_KeepInciden17.png
[18]: https://gist.github.com/kmhuglen/f96003fe9eabc06bd528730fc05eab4d