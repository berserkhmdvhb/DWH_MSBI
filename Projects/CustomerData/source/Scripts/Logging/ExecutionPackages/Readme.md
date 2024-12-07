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
|SourceContext|`@[$Package::PK_SourceContext]`|
|CreatedBy|`(DT_GUID) @[System::PackageID]`|
|ModifiedBy|`(DT_GUID) @[System::PackageID]`|
|CreatedDate|`@[System::StartTime]`|


![Vars2](./DerivedColVars.PNG)

---
## Method III. Business Warnings
Some known warnings and issues that should be reported to stakeholders are logged with this method.
The tables [log].[Tl_BusinessWarnings].

The [script](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Scripts/Logging/ExecutionPackages/Script_JSONParamConstruction.md) is used to construct a dynamic JSON parameters based on the initial input columns, as well as columns generated from failing component as metadata.

```sql
EXEC [tech].[usp_LogWarningDynamic]
    @WarningID = 4,
    @SourceID = 'FlatFile',
    @SourceContext = 'Dimension - Country',
    @CreatedBy = '906BA838-DFA5-4DC7-8DF6-D8ABBF7A4BA0',
    @DynamicParams = '[{"Key":"ErrorCode","Value":"-1071607681"},{"Key":"ErrorColumn","Value":"45"},{"Key":"CountryID","Value":"1"},{"Key":"CountryName","Value":"India"}]';
```
