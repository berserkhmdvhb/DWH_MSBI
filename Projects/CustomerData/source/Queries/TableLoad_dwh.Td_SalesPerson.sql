UPDATE [dbo].[DimSalesPerson]
SET SalesPersonBossID_FK = 5
WHERE SalesPersonID IN (1,3)

UPDATE [dbo].[DimSalesPerson]
SET SalesPersonBossID_FK = 6
WHERE SalesPersonID IN (2,4)