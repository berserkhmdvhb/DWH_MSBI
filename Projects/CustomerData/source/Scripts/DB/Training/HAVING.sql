SELECT 
	STRING_AGG(RowNumber, ',') AS CONCAT_RowNumbers,
	[CountryID_FK],
	AVG(CustomerAmount) AS AVG_prices
FROM dbo.FactCustomer
GROUP BY [CountryID_FK]
HAVING AVG(CustomerAmount) > 300;