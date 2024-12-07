USE CustomerDWH;

-- ====
-- Enable Database for CDC
-- ====

-- Verify Access 
/*
SELECT name, suser_sname(owner_sid) AS owner
FROM sys.databases
WHERE name = 'CustomerDWH';

SELECT dp.name AS UserName, sp.name AS LoginName
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
ON dp.sid = sp.sid
WHERE dp.name = 'dbo';

SELECT name, type_desc
FROM sys.server_principals
WHERE name = 'AzureAD\HamedVAHEB';

USE CustomerDWH;
SELECT name, type_desc
FROM sys.database_principals
WHERE name = 'dbo';


SELECT suser_sname();

SELECT sp.name AS LoginName, slr.name AS RoleName
FROM sys.server_role_members srm
JOIN sys.server_principals sp ON srm.member_principal_id = sp.principal_id
JOIN sys.server_principals slr ON srm.role_principal_id = slr.principal_id
WHERE sp.name = 'AzureAD\HamedVAHEB';

USE CustomerDWH;
SELECT dp.name AS UserName, dr.name AS RoleName
FROM sys.database_role_members drm
JOIN sys.database_principals dp ON drm.member_principal_id = dp.principal_id
JOIN sys.database_principals dr ON drm.role_principal_id = dr.principal_id
WHERE dp.name = 'dbo' OR dp.name = 'AzureAD\HamedVAHEB';

USE CustomerDWH;
--ALTER ROLE db_owner ADD MEMBER [AzureAD\HamedVAHEB];
--ALTER AUTHORIZATION ON DATABASE::[CustomerDWH] to [AzureAD\HamedVAHEB];
*/
USE master;
ALTER AUTHORIZATION ON DATABASE::CustomerDWH TO sa;

EXEC sys.sp_cdc_enable_db

SELECT name, is_cdc_enabled
FROM sys.databases
WHERE name = 'CustomerDWH';

-- Enable CDC for a table specifying filegroup
USE CustomerDWH;
GO

EXEC sys.sp_cdc_enable_table
    @source_schema = N'dwh',
    @source_name   = N'Tf_Customer',
    @role_name     = NULL,--N'db_owner',
    @filegroup_name = NULL,--N'MyDB_CT',
    @supports_net_changes = 1
GO

-- Check if CDC is enabled
-- DB Level
SELECT name, is_cdc_enabled
FROM sys.databases
WHERE [name] = 'CustomerDWH'
-- Table Level
SELECT name,type,type_desc,is_tracked_by_cdc
FROM sys.tables
WHERE [name] = 'Tf_Customer'

--Disabling
USE CustomerDWH;
GO
    EXEC sys.sp_cdc_disable_table
    @source_schema = N'dwh',
    @source_name   = N'Tf_Customer',
    @capture_instance = N'dwh_Tf_Customer'
GO