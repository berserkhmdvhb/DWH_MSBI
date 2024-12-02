## Method I. Event Handler - Log Packages Execution & and Packages Metadata
In SSMS SQL server, Create the log tables [[log].[Tl_Exec]](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Queries/TableCreation_LOG_Tl_Exec.sql) and [[log].[Tl_Packages]](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Queries/TableCreation_LOG_Tl_Packages.sql).


In all SSIS packages, add an `Execute SQL task` in Event Handler, set it to OLE DB connection, and use the following script:
```sql
-- Ensure the package exists in Tl_Packages
MERGE INTO [log].[Tl_Packages] AS Target
USING (
	SELECT 
		? AS PackageId, -- System::PackageID
		? AS PackageName, -- System::PackageName
		CAST(? AS DATETIME) AS CreatedDate, -- System::CreationDate
		1 AS IsActive -- Active status
	) AS Source
	ON Target.PackageId = Source.PackageId
WHEN MATCHED
	THEN
		UPDATE
		SET 
			Target.PackageName = Source.PackageName, -- Update name if necessary
			Target.IsActive = Source.IsActive -- Maintain active status
WHEN NOT MATCHED
	THEN
		INSERT (
			PackageId,
			PackageName,
			CreatedDate,
			IsActive
			)
		VALUES (
			Source.PackageId,
			Source.PackageName,
			Source.CreatedDate,
			Source.IsActive
			);

-- Log the package execution in Tl_Exec
MERGE INTO [log].[Tl_Exec] AS Target
USING (
	SELECT 
		? AS PackageId,
		CAST(? AS DATETIME) AS RunTime,
		'Success' AS ExecutionStatus
	) AS Source
	ON Target.PackageId = Source.PackageId
		AND Target.RunTime = Source.RunTime
WHEN MATCHED
	THEN
		UPDATE
		SET 
			Target.ExecutionStatus = Source.ExecutionStatus
WHEN NOT MATCHED
	THEN
		INSERT (
			PackageId,
			RunTime,
			ExecutionStatus
			)
		VALUES (
			Source.PackageId,
			Source.RunTime,
			Source.ExecutionStatus
			);
```
Then, map to corresponding variables:

![Vars](./EventHandlerVars.PNG)

This code is for event `OnPostExecute`. Redo the same for the event `OnError` but change the ExecutionStatus in code to `Fail`.

---
## Method II. Add Metadata Columns to Tables
This methods is designed to know how each row is created/updated, and trace the packageID responsible for it.
And thanks to Approach I, one can readily find package metadata (name, etc) in log table [[log].[Tl_Packages]](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Queries/TableCreation_LOG_Tl_Packages.sql)

To all tables, add the following metadata columns in table creation script of SQL

```sql
[SourceID] NVARCHAR(255) NULL,
[CreatedBy] UNIQUEIDENTIFIER NULL,
[ModifiedBy] UNIQUEIDENTIFIER NULL,
[CreatedDate] DATETIME DEFAULT GETDATE()
```

In SSIS, add a `Derived Column Transfer` component as following:

| Derived Column Name | Expression |
|------------|------------|
|SourceID|`@[$Package::PK_SourceID]`|
|CreatedBy|`(DT_GUID) @[System::PackageID]`|
|ModifiedBy|`(DT_GUID) @[System::PackageID]`|
|CreatedDate|`@[System::StartTime]`|


![Vars2](./DerivedColVars.PNG)
---
## Method III.

```sql
USE CustomerDWH;
EXEC [tech].[usp_LogWarningDynamic]
    @WarningID = 1, -- Corresponds to "Missing dimension key" in [log].[Tl_WarningDetails]
    @SourceID = 'ETL',
    @SourceContext = 'Dimension: Country',
    @CreatedBy = 'D18C4AB2-56F7-4C58-8F02-BF841024DC81',
    @DynamicParams = '[{"Key":"KeyValue", "Value":"US"}, {"Key":"DimensionName", "Value":"Country"}]',
    @Severity = NULL; -- Use default severity
```


```sql
EXEC [tech].[usp_LogWarningDynamic]
    @WarningID = 2,
    @SourceID = 'FlatFile',
    @SourceContext = 'Dimension - Country',
    @CreatedBy = '906BA838-DFA5-4DC7-8DF6-D8ABBF7A4BA0',
    @DynamicParams = '[{"Key":"ErrorColumn","Value":"CountryID"},
 {"Key":"ErrorCode","Value":"12345"},
 {"Key":"CountryID","Value":"NULL"},
 {"Key":"CountryName","Value":"India"}]',
    @Severity = 'High';
```
