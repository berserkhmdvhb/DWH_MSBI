## Method I. Event Handler - Log Packages Execution & and Packages Metadata
In SSMS SQL server, Create the log tables [[log].[Tl_Exec]](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Queries/TableCreation_LOG_Tl_Exec.sql) and [[log].[Tl_Packages]](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Queries/TableCreation_LOG_Tl_Packages.sql).


In all SSIS packages, add an `Execute SQL task` in Event Handler, set it to OLE DB connection, and use the following script:
```sql
-- Ensure the package exists in Tl_Packages
MERGE INTO [log].[Tl_Packages] AS Target
USING (
	SELECT ? AS PackageId,
		? AS PackageName,
		CAST(? AS DATETIME) AS CreatedDate,
		1 AS IsActive
	) AS Source
	ON Target.PackageId = Source.PackageId
WHEN MATCHED
	THEN
		UPDATE
		SET Target.PackageName = Source.PackageName,
			Target.IsActive = Source.IsActive
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
	SELECT ? AS PackageId,
		CAST(? AS DATETIME) AS RunTime,
		? AS ExecutionStatus
	) AS Source
	ON Target.PackageId = Source.PackageId
		AND Target.RunTime = Source.RunTime
WHEN MATCHED
	THEN
		UPDATE
		SET Target.ExecutionStatus = Source.ExecutionStatus
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

![Vars](./LOG_EventHandlerVars.PNG)

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
|SourceObject|`(DT_WSTR,255)@[User::V_FileName] OR (DT_WSTR,255)@[$Package::PK_TableName]`|
|CreatedBy|`(DT_GUID) @[System::PackageID]`|
|ModifiedBy|`(DT_GUID) @[System::PackageID]`|
|CreatedDate|`@[System::StartTime]`|


![Vars2](./LOG_DerivedColVars.PNG)

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
    @SourceObject = 'Country.txt',
    @CreatedBy = '906BA838-DFA5-4DC7-8DF6-D8ABBF7A4BA0',
    @DynamicParams = '[{"Key":"ErrorCode","Value":"-1071607681"},{"Key":"ErrorColumn","Value":"45"},{"Key":"CountryID","Value":"1"},{"Key":"CountryName","Value":"India"}]';
```

```sql
EXEC [tech].[usp_LogWarningDynamic]
    @WarningID = 7,
    @SourceID = 'Web',
    @SourceContext = 'MDM - Geo',
    @SourceObject = 'https://raw.githubusercontent.com/berserkhmdvhb/DWH_MSBI/refs/heads/main/Projects/CustomerData/Dataset/PROD/Input/MasterData/Geo/References.json',
    @CreatedBy = '906BA838-DFA5-4DC7-8DF6-D8ABBF7A4BA0',
    @DynamicParams = '[{"Key":"FileName","Value":"References.json"}]';
```

```sql
EXEC [tech].[usp_LogWarningDynamic]
    @WarningID = 8,
    @SourceID = 'schema stg',
    @SourceContext = 'Fact - CustomerV_Tf_Customer',
    @SourceObject = 'V_Tf_Customer',
    @CreatedBy = 'ED8CEC59-DE21-41BA-B578-D534A5C24B95',
    @DynamicParams = '[{"Key":"CountryID","Value":"Missing"},{"Key":"CustomerCode","Value":"1014"},{"Key":"CustomerName","Value":"Pooya"},{"Key":"CustomerAmount","Value":"800"},{"Key":"SalesDate","Value":"7/21/2022 12:00:00 AM"}]';
```
