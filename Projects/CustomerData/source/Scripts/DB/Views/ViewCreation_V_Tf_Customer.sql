USE [CustomerDWH]
GO

/****** Object:  View [dwh].[V_Tf_Customer]    Script Date: 11/28/2024 1:41:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dwh].[V_Tf_Customer]
AS
SELECT 
	[CustomerCode],
	[CustomerName],
	[CustomerAmount],
	[SalesDate],
	[ContryName],
	[StateName],
	[ProductName],
	[SalesPersonName]
FROM [stg].[Tf_Customer]
WHERE [CustomerAmount] > 0
GO
