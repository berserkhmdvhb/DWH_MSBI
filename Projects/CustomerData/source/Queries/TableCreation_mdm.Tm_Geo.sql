USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [mdm].[Tm_Geo] (
    [CountryName] NVARCHAR(255) NOT NULL,          -- Full name of the country (e.g., "Afghanistan").
    [ISO2Code] CHAR(2) NOT NULL,                  -- ISO 3166-1 alpha-2 country code (e.g., "AF").
    [CountryID] NVARCHAR(3) NOT NULL,             -- ISO 3166-1 alpha-3 country code (e.g., "AFG").
    [CountryCode] VARCHAR(3) NULL,                -- Numeric country code (e.g., "004").
    [ISO3166_2] NVARCHAR(50) NULL,                -- ISO 3166-2 region code (e.g., "ISO 3166-2:AF").
    [RegionName] NVARCHAR(100) NULL,              -- Name of the region (e.g., "Asia").
    [SubRegionName] NVARCHAR(100) NULL,           -- Name of the sub-region (e.g., "Southern Asia").
    [IntermediateRegionName] NVARCHAR(100) NULL,  -- Name of the intermediate region (optional, e.g., "Middle Africa").
    [RegionCode] VARCHAR(3) NULL,                 -- Numeric code for the region (e.g., "142").
    [SubRegionCode] VARCHAR(3) NULL,              -- Numeric code for the sub-region (e.g., "034").
    [IntermediateRegionCode] VARCHAR(3) NULL,     -- Numeric code for the intermediate region (e.g., "017").
    [CreatedBy] UNIQUEIDENTIFIER NULL,            -- Audit field for tracking the user who created the record.
    [ModifiedBy] UNIQUEIDENTIFIER NULL,           -- Audit field for tracking the user who last modified the record.
    [CreatedDate] DATETIME DEFAULT GETDATE(),     -- Audit field for tracking the creation date.
    [ModifiedDate] DATETIME NULL,                 -- Audit field for tracking the last modification date.
    PRIMARY KEY ([CountryID])                     -- Ensures CountryID is unique.
);



--CONDITION: !ISNULL([alpha-3Conv]) && LEN(TRIM([alpha-3Conv])) > 0	
