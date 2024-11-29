USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [mdm].[Tm_Geo] (
    [CountryID] NVARCHAR(10) NOT NULL,			-- Maps to "id2"
    [ISO2Code] CHAR(2) NOT NULL,				-- Maps to "iso2code"
    [CountryName] NVARCHAR(255) NOT NULL,		-- Maps to "value"
    [RegionID] NVARCHAR(10) NULL,				-- Maps to "id3"
    [RegionCode] CHAR(2) NULL,					-- Maps to "iso2code1"
    [RegionName] NVARCHAR(255) NULL,			-- Maps to "value1"
    [IncomeLevelID] NVARCHAR(10) NULL,			-- Maps to "id4"
    [IncomeLevelCode] CHAR(2) NULL,				-- Maps to "iso2code2"
    [IncomeLevelName] NVARCHAR(255) NULL,		-- Maps to "value2"
    [LendingTypeID] NVARCHAR(10) NULL,			-- Maps to "id5" (if applicable, else NULL)
    [LendingTypeCode] CHAR(2) NULL,				-- Maps to "iso2code3" (if applicable, else NULL)
    [LendingTypeName] NVARCHAR(255) NULL,		-- Maps to "value3" (if applicable, else NULL)
    [CapitalCity] NVARCHAR(255) NULL,			-- Maps to "capitalCity"
    [Longitude] FLOAT NULL,						-- Maps to "longitude"
    [Latitude] FLOAT NULL,						-- Maps to "latitude"
	[SourceID] NVARCHAR(255) NULL,				-- Audit field for tracking
	[CreatedBy] UNIQUEIDENTIFIER NULL,			-- Audit field for tracking
	[ModifiedBy] UNIQUEIDENTIFIER NULL,			-- Audit field for tracking
    [CreatedDate] DATETIME DEFAULT GETDATE(),	-- Audit field for tracking
    PRIMARY KEY ([CountryID])					-- Assuming "id2" is unique
);
