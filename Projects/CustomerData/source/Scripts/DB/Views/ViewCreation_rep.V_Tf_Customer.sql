USE [CustomerDWH]
GO

/****** Object:  View [rep].[V_Tf_Customer]    Script Date: 1/7/2025 1:16:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [rep].[V_Tf_Customer]
AS
SELECT 
	RowNumber AS [Idx],
	CustomerCode AS [Code],
	CustomerName AS [Name],
	CustomerAmount [Amount]
FROM dwh.Tf_Customer
WHERE 1=1
	AND
	(
		(
			CreatedDate >= GETDATE() - 10
			AND
			CustomerCode NOT IN (SELECT CustomerCode FROM [stg].[Td_StaticIds])
		)
		OR
		(
			CustomerCode IN (SELECT CustomerCode FROM [stg].[Td_StaticIds])
		)
	)

GO


