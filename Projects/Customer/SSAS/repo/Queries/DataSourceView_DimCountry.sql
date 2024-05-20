SELECT 
	[CountryID],
	[CountryName],
	[IsNew]
FROM [CustomerDWH].[dbo].[DimCountry]
WHERE IsNew = 1
