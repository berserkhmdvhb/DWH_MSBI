USE [master]
GO

/****** Object:  Login [AzureAD\HamedVAHEB]    Script Date: 2/6/2024 12:37:20 PM ******/
CREATE LOGIN [AzureAD\HamedVAHEB] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [securityadmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [serveradmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [setupadmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [processadmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [diskadmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [dbcreator] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [bulkadmin] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_ServerStateReader##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_ServerStateManager##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_DefinitionReader##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_DatabaseConnector##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_DatabaseManager##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_LoginManager##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_SecurityDefinitionReader##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_PerformanceDefinitionReader##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_ServerSecurityStateReader##] ADD MEMBER [AzureAD\HamedVAHEB]
GO

ALTER SERVER ROLE [##MS_ServerPerformanceStateReader##] ADD MEMBER [AzureAD\HamedVAHEB]
GO


