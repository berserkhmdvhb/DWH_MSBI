TRUNCATE TABLE [dbo].FactCustomer
DELETE FROM dbo.FactCustomer
DBCC CHECKIDENT ('CustomerDWH.dbo.FactCustomer', RESEED, 0)