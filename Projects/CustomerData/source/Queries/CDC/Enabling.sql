USE CustomerDWH;

-- ====
-- Enable Database for CDC
-- ====

--ALTER AUTHORIZATION ON DATABASE::[CustomerDWH] to [AzureAD\HamedVAHEB];
EXEC sys.sp_cdc_enable_db


-- Enable CDC for a table specifying filegroup
USE CustomerDWH;
GO

EXEC sys.sp_cdc_enable_table
    @source_schema = N'dbo',
    @source_name   = N'FactCustomer',
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
WHERE [name] = 'FactCustomer'

--Disabling
USE CustomerDWH;
GO
    EXEC sys.sp_cdc_disable_table
    @source_schema = N'dbo',
    @source_name   = N'FactCustomer',
    @capture_instance = N'dbo_FactCustomer'
GO