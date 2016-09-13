---
layout: post
title: >
    User Inputs from SCSM Portal to Description field using
    Orchestrator
published: true
author: kmhuglen
comments: true
date: 2013-12-16 05:12:20
tags:
    - Orchestrator
    - PowerShell
    - Service Manager
    - System Center
categories:
    - it-pro
permalink: /4462
image:
    feature: 121613_1123_UserInputsf4.png
---
There are several blog posts already about how to get the User Input from a Service Request or Incident Request formatted and put into the description field.

But I wanted to use Orchestrator so I could make changes without having to recompile the solution every time.

I used some of the script published by Kurt Van Hoecke at Authoring Friday  in my orchestrator version.

Another blog: Solution to clean User Input from Service Manager Portal and commit it to the Action Log @ Coretech Blog

**Orchestrator Monitor Runbooks
  
** 

![][1]

![][2]

![][3]

Orchestrator is set up with a generic Service Manager monitor for new Incident Request and Service Request , and using the Link Include Filter, I send all new incident and service request with source Portal to the Runbook.

**UserInput to Description Runbook
  
** ![][4]

  1. I take the ID of the Work Item as an input in the Initialize Data activity.
  2. Link filter WorkItemID starts with IR or SR.
  3. In the Get Incident/Service Request activity I have a filter ID equals WorkItemID from Initialize Data.
  4. The UserInput from the Get Get Incident/Service Request activity are used in the script in Get IR/SR UserInput.
  5. And finaly I update the IR/SR description field.

Here I use the Execute PS Secript activity from the [Orchestrator Integration Pack for PowerShell Script Execution 1.2][5] for my Get IR/SR UserInput activities, but the default Run .Net Script Activity would also work just fine.

**PowerShell script:**

$UserInput= '{UserInput from "Get Incident Request"}'
$nl = [Environment]::NewLine
$content=[XML]$UserInput
$inputs = $content.UserInputs.UserInput
foreach ($input in $inputs)
{
    if($($input.Answer) -like "&lt;value*")
    {       
        [xml]$answer = $input.answer
        foreach($value in $($($answer.values)))
        {
                foreach($item in $value)
                {                   
                    foreach ($txt in $($item.value))
                    {                     
                        $ListArray += $($txt.DisplayName)                  
                    }
                    $Array += $input.Question + " = " + [string]::Join(" ; ",$ListArray) +$nl
                    $ListArray = $null
                }
        }
    }
    else 
    {
         if ($input.type -eq "enum")
        {
            $ListGuid = Get-SCSMEnumeration -Id $input.Answer
            $Array += $($input.Question + " = " + $ListGuid.displayname)  +$nl
        }
        else 
        {
        $Array += $($input.Question + " = " + $input.Answer)  +$nl
        }
    }
}
$Array

 [1]: /wp-content/uploads/121613_1123_UserInputsf1.png
 [2]: /wp-content/uploads/121613_1123_UserInputsf2.png
 [3]: /wp-content/uploads/121613_1123_UserInputsf3.png
 [4]: /wp-content/uploads/121613_1123_UserInputsf4.png
 [5]: http://gallery.technet.microsoft.com/Orchestrator-Integration-438f9ece