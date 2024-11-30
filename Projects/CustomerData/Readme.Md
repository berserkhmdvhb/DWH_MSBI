


# Documentation


## Source Data



---
### MasterData

The MasterData of countries [JSON file](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/Dataset/Input/MasterData/Countries/Countries.json) is taken from [GitHub Repo](https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/tree/master).
#### 1. `name`
- **Description**: Full name of the country.
- **Example**: `"Afghanistan"`
- **Data Type**: `NVARCHAR(255)`
- **Details**: 
  - Accommodates country names, including special characters or Unicode.
  - Used as a descriptive field for the country.



#### 2. `alpha-2`
- **Description**: ISO 3166-1 alpha-2 country code.
- **Example**: `"AF"`
- **Data Type**: `CHAR(2)`
- **Details**: 
  - Fixed-length two-character code.
  - Represents the country in ISO 3166-1 standards.



#### 3. `alpha-3`
- **Description**: ISO 3166-1 alpha-3 country code.
- **Example**: `"AFG"`
- **Data Type**: `NVARCHAR(3)`
- **Details**: 
  - Allows Unicode compatibility.
  - Commonly used as a unique identifier for countries.



#### 4. `country-code`
- **Description**: Numeric country code as per ISO standards.
- **Example**: `"004"`
- **Data Type**: `VARCHAR(3)`
- **Details**: 
  - May include leading zeros.
  - Useful for numeric-based identification of countries.



#### 5. `iso_3166-2`
- **Description**: ISO 3166-2 region code.
- **Example**: `"ISO 3166-2:AF"`
- **Data Type**: `NVARCHAR(50)`
- **Details**: 
  - Contains region codes in the format specified by ISO 3166-2.
  - May include combinations of letters and numbers.



#### 6. `region`
- **Description**: Name of the region where the country is located.
- **Example**: `"Asia"`
- **Data Type**: `NVARCHAR(100)`
- **Details**: 
  - Represents the high-level region, such as "Europe" or "Africa".
  - Provides geographical categorization.



### 7. `sub-region`
- **Description**: Name of the sub-region where the country is located.
- **Example**: `"Southern Asia"`
- **Data Type**: `NVARCHAR(100)`
- **Details**: 
  - Refines the region into smaller geographical areas.
  - Allows for more granular geographical analysis.



#### 8. `intermediate-region`
- **Description**: Optional name of an intermediate region, if applicable.
- **Example**: `"Middle Africa"`
- **Data Type**: `NVARCHAR(100)`
- **Details**: 
  - Often empty or `NULL`.
  - Represents a mid-level grouping of countries in some geographical frameworks.


#### 9. `region-code`
- **Description**: Numeric code for the region.
- **Example**: `"142"`
- **Data Type**: `VARCHAR(3)`
- **Details**: 
  - Numeric representation of the region.
  - Corresponds to `region`.



#### 10. `sub-region-code`
- **Description**: Numeric code for the sub-region.
- **Example**: `"034"`
- **Data Type**: `VARCHAR(3)`
- **Details**: 
  - Numeric representation of the sub-region.
  - Corresponds to `sub-region`.


#### 11. `intermediate-region-code`
- **Description**: Numeric code for the intermediate region.
- **Example**: `"017"`
- **Data Type**: `VARCHAR(3)`
- **Details**: 
  - Numeric representation of the intermediate region.
  - Often empty or `NULL`.



#### **Notes on Data Quality**
- **Missing Data**: Fields like `intermediate-region` and `intermediate-region-code` may be `NULL` for certain countries.
- **Empty Strings**: Some fields might contain empty strings instead of `NULL`. Ensure these are handled during processing.
- **Encoding**: All string fields are expected to support Unicode to handle special characters in country names and region descriptions.
- **Numeric Codes**: Use `VARCHAR` for numeric codes to preserve leading zeros and handle all formats consistently.


#### **Example Data Entry**
```json
{
    "name": "Afghanistan",
    "alpha-2": "AF",
    "alpha-3": "AFG",
    "country-code": "004",
    "iso_3166-2": "ISO 3166-2:AF",
    "region": "Asia",
    "sub-region": "Southern Asia",
    "intermediate-region": "",
    "region-code": "142",
    "sub-region-code": "034",
    "intermediate-region-code": ""
}
```
---
