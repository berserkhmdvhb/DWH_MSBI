SELECT 
	[ProductID],
	[ProductName],
    [Ef_Date],
	[Ex_Date]
FROM [CustomerDWH].[dbo].[DimProduct]
WHERE Ex_Date IS NULL
