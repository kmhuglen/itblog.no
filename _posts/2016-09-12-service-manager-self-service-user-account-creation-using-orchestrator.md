---
layout: post
title: >
    Service Manager self-service User Account creation using
    Orchestrator
published: true
author: kmhuglen
comments: true
date: 2013-10-29 06:10:03
tags:
    - Active Directory
    - Orchestrator
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /2532
image:
    feature: 102913_1721_ServiceMana1.png
---
This is an overview of a Self-Service User Account Creation Workflow using Request Offering in Service Manager and Orchestrator. Configured only to be available for Managers and Human Recourses personnel.

I will not go into details. However, maybe someone can use it to get an Idea for own workflow.

## Request Form

![][1]

## Service Request Template Activities

![][2]

## Request Offering Prompt Mapping


  
         
      
        Question
      
      
      
        Value
      
      
      
        Activity
      
      
      
        Property
      
    
    
    
      
        Select employment type
      
      
      
        List: 
        
        
          
            Consultant
          
          
            Employee
          
          
            Developer
          
        
      
      
      
        Create New Active Directory User Account
      
      
      
        EmploymentType
      
    
    
    
      
        First Name
      
      
      
        Text
      
      
      
        Create New Active Directory User Account
      
      
      
        FirstName
      
    
    
    
      
        Last Name
      
      
      
        Text
      
      
      
        Create New Active Directory User Account
      
      
      
        LastName
      
    
    
    
      
        Mobile Phone
      
      
      
        Text
      
      
      
        Create New Active Directory User Account
      
      
      
        MobilePhone
      
    
    
    
      
        Role
      
      
      
        Objects
      
      
      
        Create New Active Directory User Account
      
      
      
        Affected Configuration Item
      
    
    
    
      
        Organizational Unit
      
      
      
        List: 
        
        
          
            OU A
          
          
            OU B
          
          
            OU C
          
        
      
      
      
        Create New Active Directory User Account
      
      
      
        OU
      
    
    
    
      
        Manager
      
      
      
        Objects
      
      
      
        Add Reviewer
      
      
      
        Affected Configuration Item
      
    
  


&nbsp;

## Service Request Activity overview

###### RB: Add Reviewer

Gets the Manager from Affected Configuration Item of the Activity, and create a new Reviewer on the Manager Approval Review Activity.

  * Initialize Data: ActivityID

![][3]

&nbsp;

###### RA: Manager Approval (Review Activity)

Waits for Approval or Reject from the Manager

###### RB: Create New Active Directory User Account

Create the User Account in Active Directory with a random generated Password, and place the User Account object in the selected OU. If the EmplymentType is Consultant, the Account Expire is set to 90 days in the future. It Enables a Mailbox for the User Account, and return the username and password to the Service Request.

  * 
      Initialize Data:
    
    
      * ActivityID 