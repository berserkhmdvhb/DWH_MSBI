USE [CustomerDWH]
GO

/****** Object:  View [dwh].[V_Td_Product]    Script Date: 11/28/2024 1:41:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dwh].[V_Td_Product]
AS
SELECT
	[ProductID],
	REPLACE(LTRIM(RTRIM([ProductName])), '  ', ' ') AS [ProductName]
FROM [stg].[Td_Product]
WHERE LEN(LTRIM(RTRIM(ProductName))) > 0;
GO
