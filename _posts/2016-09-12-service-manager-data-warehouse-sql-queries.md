---
layout: post
title: Service Manager Data WareHouse SQL Queries
published: true
author: kmhuglen
comments: true
date: 2014-09-16 11:09:06
tags:
    - Data Warehouse
    - Report Builder
    - Service Manager
    - SQL Query
categories:
    - it-pro
permalink: /5618
---
This post list common SQL queries that I use when building reports against Service Manager Data Warehouse with SQL Server Report Builder.
  


**List Active Business Services**

SELECT
	Replace(Replace(Replace(DisplayName,'_',' '),' ',' '),' ',' ') As Service 
	*/ The replace of underscore and Spaces is customer spesific */
FROM 
	ServiceDimvw
WHERE
	DisplayName not like 'NULL'
	AND
	Status_ServiceStatusId = '6'
	AND
	IsBusinessService = '1'
ORDER BY
	DisplayName


**List Available Incident Classifications**

SELECT 
	DisplayName
FROM
	IncidentClassificationvw
	
	Left Join DisplayStringDimvw StringClassification ON IncidentClassificationvw.EnumTypeId = StringClassification.BaseManagedEntityId

WHERE
	DisplayName NOT Like '%(not in use)%'
	*/ The '%(not in use)%' is customer spesific */
	AND
	DisplayName NOT Like 'Incident Classification'
	AND
	LanguageCode = 'ENU'


**List Available Sources**

SELECT 
	DisplayName
FROM
	IncidentSourcevw
	Left Join DisplayStringDimvw StringSource ON IncidentSourcevw.EnumTypeId = StringSource.BaseManagedEntityId
WHERE
	DisplayName NOT Like 'Incident Source'
	AND
	LanguageCode = 'ENU'


**Count of Incidents by Tier by days/week/month/year**

SELECT
	StringTierQueues.DisplayName As Tier,
	COUNT(Case when 
		(
			Incident.Status Not Like 'IncidentStatusEnum.Resolved' 
			And
			Incident.Status Not Like 'IncidentStatusEnum.Closed'
		)
		Then 1 end)	As "Open Incidents",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			DATEPART(wk,Incident.ResolvedDate) = DATEPART(wk,getdate())
			And
			DAY(Incident.ResolvedDate) = Day(getdate())
		)
		Then 1 End) As "Today", 
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			DATEPART(wk,Incident.ResolvedDate) = DATEPART(wk,getdate())
			And
			DAY(Incident.ResolvedDate) = Day(DATEADD(Day,-1,getdate()))
		)
		Then 1 End) As "Yesterday",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			DATEPART(wk,Incident.ResolvedDate) = DATEPART(wk,getdate())
			And
			DAY(Incident.ResolvedDate) = Day(DATEADD(Day,-2,getdate()))
		)
		Then 1 End) As "2 days ago",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			DATEPART(wk,Incident.ResolvedDate) = DATEPART(wk,getdate())
		)
		Then 1 End) As "This Week",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			DATEPART(wk,Incident.ResolvedDate) = DATEPART(wk,DATEADD(WEEK,-1,getdate()))
		)
		Then 1 End) As "Last Week",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			DATEPART(wk,Incident.ResolvedDate) = DATEPART(wk,DATEADD(WEEK,-2,getdate()))
		)
		Then 1 End) As "2 Weeks ago",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			MONTH(Incident.ResolvedDate) = MONTH(getdate())
		)
		Then 1 End) As "This Month",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			MONTH(Incident.ResolvedDate) = ((MONTH(getdate()))-1)
		)
		Then 1 End) As "Last Month",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
			And
			MONTH(Incident.ResolvedDate) = ((MONTH(getdate()))-2)
		)
		Then 1 End) As "2 Months ago",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = YEAR(getdate())
		)
		Then 1 End) As "This Year",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = ((YEAR(getdate()))-1)
		)
		Then 1 End) As "Last Year",
	COUNT(Case when
		(
			YEAR(Incident.ResolvedDate) = ((YEAR(getdate()))-2)
		)
		Then 1 End) As "2 Years Ago"
		
FROM 
	IncidentDimvw AS Incident

	Join IncidentClassificationvw ClassificationVW ON Incident.Classification_IncidentClassificationId = ClassificationVW.IncidentClassificationId
	Join DisplayStringDimvw StringClassification ON ClassificationVW.EnumTypeId = StringClassification.BaseManagedEntityId

	Join IncidentSourcevw SourceVW ON Incident.Source_IncidentSourceId = SourceVW.IncidentSourceId
	Join DisplayStringDimvw StringSource ON SourceVW.EnumTypeId = StringSource.BaseManagedEntityId

	Join IncidentTierQueuesvw TierQueuesVW ON Incident.TierQueue_IncidentTierQueuesId = TierQueuesVW.IncidentTierQueuesId 
	Join DisplayStringDimvw StringTierQueues ON TierQueuesVW.EnumTypeId = StringTierQueues.BaseManagedEntityId

WHERE 
	StringClassification.DisplayName IN (@Classification)
	AND
	StringSource.DisplayName IN (@Source)
	AND
	StringClassification.LanguageCode = 'ENU'
	AND
	StringSource.LanguageCode = 'ENU'
	AND
	StringTierQueues.LanguageCode = 'ENU'
	
	  
GROUP BY 
	StringTierQueues.DisplayName
