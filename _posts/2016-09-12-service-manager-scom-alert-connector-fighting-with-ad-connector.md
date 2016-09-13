---
layout: post
title: 'Service Manager: SCOM Alert connector fighting with AD connector?'
published: true
author: kmhuglen
comments: true
date: 2014-05-08 10:05:23
tags:
    - Active Directory
    - Operations Manager
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /5472
---
I am experiencing some conflicts between the Operations Manager Alert connector and the Active Directory connector. They are both updating the same property values, but the values are not the same.

Example:

A User changes Department, and the Department property in Active Directory are modified with the name of the new Department

  1.  The Active Directory connector modifies the value of the User Objects Department property in the Service Manager Configuration Management Database
  2.  Then the Operations Manager Alert connector modifies the same property on the User Object with the old value.

Have someone seen the same behavior?

I&#8217;ve put this out on the TechNet Forum also: 