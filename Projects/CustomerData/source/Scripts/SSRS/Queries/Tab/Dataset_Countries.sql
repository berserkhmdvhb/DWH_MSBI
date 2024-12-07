SELECT 
	CountryName,
	CountryID
FROM DimCountry
WHERE (IsNew = 1)