USE [CustomerDWH]
GO

/****** Object:  View [dbo].[V_FactCustomer]    Script Date: 11/28/2024 1:41:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dwh].[V_Td_Country]
AS
SELECT 
	[CountryID],
	REPLACE(LTRIM(RTRIM(CountryName)), '  ', ' ') AS [CountryName]
FROM [stg].[Td_Country]
WHERE LEN(LTRIM(RTRIM(CountryName))) > 0;

GO

