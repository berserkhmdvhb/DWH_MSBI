USE CustomerDWH;

--Drop
/*
-- STG
DROP TABLE [STG].[Td_Country]
DROP TABLE [STG].[Td_Product]
DROP TABLE [STG].[Td_SalesPerson]
DROP TABLE [STG].[Td_State]
DROP TABLE [STG].[Tf_Customer]

-- DWH
DROP TABLE [DWH].[Td_Country]
DROP TABLE [DWH].[Td_Product]
DROP TABLE [DWH].[Td_SalesPerson]
DROP TABLE [DWH].[Td_State]
DROP TABLE [DWH].[Tf_Customer]
DROP TABLE [DWH].[Tf_Customer_Temp]
DROP TABLE [DWH].[Td_Period]

-- MDM
DROP TABLE [MDM].[Tm_Country]

-- LOG
DROP TABLE [LOG].[Tl_Exec]
DROP TABLE [LOG].[Tl_Packages]
*/

-- STG
DELETE FROM stg.Td_Country
DELETE FROM stg.Td_Product
DELETE FROM stg.Td_SalesPerson
DELETE FROM stg.Td_State
TRUNCATE TABLE stg.Tf_Customer
TRUNCATE TABLE stg.Td_Country
TRUNCATE TABLE stg.Td_Product
TRUNCATE TABLE stg.Td_SalesPerson
TRUNCATE TABLE stg.Td_State

-- MDM
TRUNCATE TABLE mdm.Tm_Geo
-- DWH
DELETE FROM dwh.Td_Country
DELETE FROM dwh.Td_Product
DELETE FROM dwh.Td_SalesPerson
DELETE FROM dwh.Td_State
DELETE FROM dwh.Tf_Customer
TRUNCATE TABLE dwh.Tf_Customer


-- LOG
DELETE FROM [log].Tl_Exec
TRUNCATE TABLE [log].Tl_Exec

DELETE FROM [log].Tl_Packages
ALTER TABLE [log].[Tl_Exec] DROP CONSTRAINT [FK_Tl_Exec_PackageId]
TRUNCATE TABLE [log].Tl_Packages
ALTER TABLE [log].[Tl_Exec] ADD CONSTRAINT [FK_Tl_Exec_PackageId] FOREIGN KEY ([PackageId]) REFERENCES [log].[Tl_Packages] ([PackageId])



DELETE FROM [log].Tl_BusinessWarnings
TRUNCATE TABLE [log].Tl_BusinessWarnings

DELETE FROM [log].Tl_WarningDetails
ALTER TABLE [log].[Tl_BusinessWarnings] DROP CONSTRAINT FK_BusinessWarnings_WarningDetails
TRUNCATE TABLE [log].Tl_WarningDetails
ALTER TABLE [log].[Tl_BusinessWarnings] ADD CONSTRAINT FK_BusinessWarnings_WarningDetails FOREIGN KEY (WarningID) REFERENCES [log].[Tl_WarningDetails] (WarningID) ON DELETE CASCADE


--TRUNCATE TABLE dbo.DimDate


