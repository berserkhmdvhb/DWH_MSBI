SELECT 
	[RowNumber],
	[CustomerCode],
	[CustomerName],
	[CustomerAmount],
	[SalesDate],
	[CountryID_FK],
	[StateID_FK],
	[ProductID_FK],
	[SalesPersonID_FK],
	[DummyCol_Date],
	SUM(LEN(CustomerName)) OVER (
		PARTITION BY CountryID_FK ORDER BY LEN(CustomerName) ASC
		) AS running_total_length
FROM dbo.FactCustomer
ORDER BY CountryID_FK