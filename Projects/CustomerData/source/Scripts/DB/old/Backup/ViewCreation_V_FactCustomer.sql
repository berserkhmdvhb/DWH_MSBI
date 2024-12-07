USE [CustomerDWH]
GO

/****** Object:  View [dbo].[V_FactCustomer]    Script Date: 5/14/2024 8:30:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [rep].[V_Tf_Customer]
AS
SELECT 
	RowNumber AS [Idx],
	CustomerCode AS [Code],
	CustomerName AS [Name],
	CustomerAmount [Amount]
FROM dbo.FactCustomer
GO


