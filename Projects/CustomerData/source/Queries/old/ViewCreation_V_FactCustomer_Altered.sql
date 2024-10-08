USE [CustomerDWH]
GO

/****** Object:  View [dbo].[V_FactCustomer]    Script Date: 5/14/2024 8:37:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[V_FactCustomer]
AS
SELECT 
	RowNumber AS [Idx],
	CustomerCode AS [Code],
	CustomerName AS [Name],
	CustomerAmount [Amount],
	CountryID_FK AS [CountryID]
FROM dbo.FactCustomer
GO


