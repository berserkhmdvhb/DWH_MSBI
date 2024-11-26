USE CustomerDWH;
DELETE FROM stg.Td_Country
DELETE FROM stg.Td_Product
DELETE FROM stg.Td_SalesPerson
DELETE FROM stg.Td_State
TRUNCATE TABLE stg.Tf_Customer
TRUNCATE TABLE stg.Td_Country
TRUNCATE TABLE stg.Td_Product
TRUNCATE TABLE stg.Td_SalesPerson
TRUNCATE TABLE stg.Td_State



DELETE FROM dwh.Td_Country
DELETE FROM dwh.Td_Product
DELETE FROM dwh.Td_SalesPerson
DELETE FROM dwh.Td_State
DELETE FROM dwh.Tf_Customer
TRUNCATE TABLE dwh.Tf_Customer


DELETE FROM rep.FactCustomerTemp
TRUNCATE TABLE rep.FactCustomerTemp


DELETE FROM [log].LogExec
TRUNCATE TABLE [log].LogExec

--TRUNCATE TABLE dbo.DimDate

