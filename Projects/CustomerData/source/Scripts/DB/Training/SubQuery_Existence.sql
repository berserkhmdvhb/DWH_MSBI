SELECT customerName
  FROM dbo.FactCustomer c
 WHERE EXISTS (
       SELECT 1
         FROM dbo.DimSalesPerson s
        WHERE ISNULL(c.SalesPersonID_FK, 11111) = ISNULL(s.SalesPersonBossID_FK, 22222)
       );