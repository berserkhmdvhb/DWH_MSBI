USE CustomerDWH;
DELETE FROM dbo.DimCountry
DELETE FROM dbo.DimProduct
DELETE FROM dbo.DimSalesPerson
DELETE FROM dbo.DimState
TRUNCATE TABLE dbo.FactCustomer
TRUNCATE TABLE dbo.FactCustomerTemp
TRUNCATE TABLE dbo.LogExec
--TRUNCATE TABLE dbo.DimDate
