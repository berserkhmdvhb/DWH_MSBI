INSERT INTO [log].[Tl_Packages] (
	PackageId,
	PackageName
	)
VALUES 
	(
	NEWID(),
	'stg_Td_Country'
	),
	(
	NEWID(),
	'stg_Td_Product'
	),
	(
	NEWID(),
	'stg_Td_SalesPerson'
	),
	(
	NEWID(),
	'stg_Td_State'
	),
	(
	NEWID(),
	'stg_Tf_Customer'
	),
	(
	NEWID(),
	'dwh_Td_Country'
	),
	(
	NEWID(),
	'dwh_Td_Product'
	),
	(
	NEWID(),
	'dwh_Td_SalesPerson'
	),
	(
	NEWID(),
	'dwh_Td_State'
	),
	(
	NEWID(),
	'dwh_Tf_Customer'
	),
	(
	NEWID(),
	'REP_Tf_Customer_Summary'
	),
	(
	NEWID(),
	'Master'
	),
	(
	NEWID(),
	'REP_Split'
	)
	;
 
 
--SELECT MAX(RunTime) FROM [dbo].[LogExec] WHERE PackageId = (SELECT PackageId FROM [dbo].[LogPackages] WHERE PackageName = 'Master_ETL')
 
/*
INSERT INTO LogExec (PackageId, RunTime)
SELECT PackageId, GETDATE()
FROM LogPackages
WHERE PackageName = 'MIGRATION_RIITA_to_360L';

TRUNCATE TABLE LogExec
*/