SELECT 
  	FactCustomer.CustomerCode,
	FactCustomer.CustomerName,
	FactCustomer.CustomerAmount,
	DimState.StateName,
	DimSalesPerson.SalesPersonName,
	DimProduct.ProductName,
	DimCountry.CountryName,
	DimDate.[date]
FROM FactCustomer
INNER JOIN DimDate ON FactCustomer.SalesDateID_FK = DimDate.date_key
INNER JOIN DimSalesPerson ON FactCustomer.SalesPersonID_FK = DimSalesPerson.SalesPersonID
INNER JOIN DimState ON FactCustomer.StateID_FK = DimState.StateID
INNER JOIN DimCountry ON FactCustomer.CountryID_FK = DimCountry.CountryID
INNER JOIN DimProduct ON FactCustomer.ProductID_FK = DimProduct.ProductID
