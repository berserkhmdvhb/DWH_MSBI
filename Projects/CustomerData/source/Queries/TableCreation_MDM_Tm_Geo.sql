USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [mdm].[Tm_Geo] (
    [CountryID] NVARCHAR(255) NOT NULL,         -- Unique identifier for the country (e.g., "AFG").
    [ISO2Code] NVARCHAR(255) NOT NULL,              -- ISO 3166-1 alpha-2 country code (e.g., "AF").
    [CountryName] NVARCHAR(255) NOT NULL,     -- Full name of the country (e.g., "Afghanistan").
    [CapitalCity] NVARCHAR(255) NULL,         -- Name of the capital city (e.g., "Kabul").
    [Longitude] FLOAT NULL,                   -- Longitude of the capital city.
    [Latitude] FLOAT NULL,                    -- Latitude of the capital city.
    [RegionID] NVARCHAR(255) NULL,             -- Unique identifier for the region (e.g., "SAS").
    [RegionCode] NVARCHAR(255) NULL,           -- ISO-like region code (e.g., "8S").
    [RegionName] NVARCHAR(255) NULL,          -- Full name of the region (e.g., "South Asia").
    [SourceID] NVARCHAR(255) NULL,				-- Audit field for tracking
	[CreatedBy] UNIQUEIDENTIFIER NULL,			-- Audit field for tracking
	[ModifiedBy] UNIQUEIDENTIFIER NULL,			-- Audit field for tracking
    [CreatedDate] DATETIME DEFAULT GETDATE(),	-- Audit field for tracking
    PRIMARY KEY ([CountryID])                 -- Ensures CountryID is unique.
);