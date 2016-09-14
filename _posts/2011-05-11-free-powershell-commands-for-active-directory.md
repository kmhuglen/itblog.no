---
layout: post
title: Free PowerShell Commands for Active Directory
published: true
author: Knut Magne Huglen
comments: true
date: 2011-05-11 01:05:12
tags:
    - Active Directory
    - PowerShell
categories:
    - it-pro
permalink: /873
---
As I have been using a lot of PowerShell script lately for extracting and modifying Active Directory objects, and of course search the web for how-to and examples on how to do stuff. I have often come over examples where they use CMDLETS that is not available from a the default Active Directory Module for Windows PowerShell.

After a couple of new google search I found
  
ActiveRoles Management Shell for Active Directory from Quest Software. It is free and you can [download from Quest.com][1]

```
Add-QADCertificate
Add-QADCertificateRevocationList
Add-QADGroupMember
Add-QADMemberOf
Add-QADPasswordSettingsObjectAppliesTo
Add-QADPermission
Add-QADProxyAddress
Approve-QARSApprovalTask
Clear-QADProxyAddress
Connect-QADService
Convert-QADAttributeValue
Deprovision-QADUser
Disable-QADComputer
Disable-QADDiagnosticLog
Disable-QADEmailAddressPolicy
Disable-QADUser
Disconnect-QADService
Edit-QADCertificate
Enable-QADComputer
Enable-QADDiagnosticLog
Enable-QADEmailAddressPolicy
Enable-QADUser
Export-QADCertificate
Export-QADCertificateRevocationList
Get-QADCertificate
Get-QADCertificateRevocationList
Get-QADComputer
Get-QADDiagnosticLogStatus
Get-QADGroup
Get-QADGroupMember
Get-QADInactiveAccountsPolicy
Get-QADLocalCertificateStore
Get-QADManagedObject
Get-QADMemberOf
Get-QADObject
Get-QADObjectSecurity
Get-QADPasswordSettingsObject
Get-QADPasswordSettingsObjectAppliesTo
Get-QADPermission
Get-QADPKIObject
Get-QADProgressPolicy
Get-QADPSSnapinSettings
Get-QADRootDSE
Get-QADUser
Get-QARSAccessTemplate
Get-QARSAccessTemplateLink
Get-QARSApprovalTask
Get-QARSLastOperation
Get-QARSOperation
Get-QARSWorkflowDefinition
Get-QARSWorkflowInstance
Import-QADCertificate
Import-QADCertificateRevocationList
Move-QADObject
New-QADComputer
New-QADGroup
New-QADLocalCertificateStore
New-QADObject
New-QADPasswordSettingsObject
New-QADUser
New-QARSAccessTemplateLink
Publish-QADCertificate
Publish-QADCertificateRevocationList
Publish-QARSGroup
Reject-QARSApprovalTask
Remove-QADCertificate
Remove-QADCertificateRevocationList
Remove-QADGroupMember
Remove-QADLocalCertificateStore
Remove-QADMemberOf
Remove-QADObject
Remove-QADPasswordSettingsObjectAppliesTo
Remove-QADPermission
Remove-QADPrivateKey
Remove-QADProxyAddress
Remove-QARSAccessTemplateLink
Rename-QADObject
Reset-QADComputer
Restore-QADDeletedObject
Set-QADComputer
Set-QADGroup
Set-QADInactiveAccountsPolicy
Set-QADObject
Set-QADObjectSecurity
Set-QADProgressPolicy
Set-QADProxyAddress
Set-QADPSSnapinSettings
Set-QADUser
Set-QARSAccessTemplateLink
Show-QADCertificate
Unlock-QADUser
Unpublish-QADCertificate
Unpublish-QADCertificateRevocationList
Unpublish-QARSGroup
Where-QADCertificate
```

[1]: http://www.quest.com/powershell/activeroles-server.aspx