The MasterData of countries [JSON file](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/Dataset/Input/MasterData/Countries/Countries.json) is taken from [GitHub Repo](https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/tree/master).


## Documentation of columns in masterdata file
name:
Table Equivalent: CountryName
Data Type: NVARCHAR(255)
Explanation: Accommodates country names, including Unicode characters.
2. alpha-2:
Table Equivalent: ISO2Code
Data Type: CHAR(2)
Explanation: Fixed two-character ISO 3166-1 alpha-2 code.
3. alpha-3:
Table Equivalent: CountryID
Data Type: NVARCHAR(3)
Explanation: Stores the ISO 3166-1 alpha-3 code, allowing Unicode compatibility.
4. country-code:
Table Equivalent: Not explicitly defined in your schema but could be added if needed.
Suggested Data Type: VARCHAR(3)
Explanation: Stores numeric country codes; some may have leading zeros.
5. iso_3166-2:
Table Equivalent: ISO3166_2
Data Type: NVARCHAR(50)
Explanation: Accommodates mixed character and numeric ISO 3166-2 values.
6. region:
Table Equivalent: RegionName
Data Type: NVARCHAR(100)
Explanation: Stores the region name, e.g., "Asia".
7. sub-region:
Table Equivalent: SubRegionName
Data Type: NVARCHAR(100)
Explanation: Stores sub-region names, e.g., "Southern Asia".
8. intermediate-region:
Table Equivalent: IntermediateRegionName
Data Type: NVARCHAR(100)
Explanation: Optional intermediate region names.
9. region-code:
Table Equivalent: RegionCode
Data Type: VARCHAR(3)
Explanation: Numeric code for the region.
10. sub-region-code:
Table Equivalent: SubRegionCode
Data Type: VARCHAR(3)
Explanation: Numeric code for the sub-region.
11. intermediate-region-code:
Table Equivalent: IntermediateRegionCode
Data Type: VARCHAR(3)
Explanation: Numeric code for intermediate regions.
