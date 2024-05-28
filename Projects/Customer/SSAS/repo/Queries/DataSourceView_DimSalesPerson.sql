SELECT 
	TD_SP_1.[SalesPersonID],
	TD_SP_1.[SalesPersonName],
	TD_SP_1.[SalesPersonBossID_FK],
	TD_SP_2.[SalesPersonName] AS SalesPersonBossName 
FROM [CustomerDWH].[dbo].[DimSalesPerson] AS TD_SP_1
LEFT OUTER JOIN [CustomerDWH].[dbo].[DimSalesPerson] AS TD_SP_2
	ON TD_SP_1.SalesPersonBossID_FK = TD_SP_2.SalesPersonID