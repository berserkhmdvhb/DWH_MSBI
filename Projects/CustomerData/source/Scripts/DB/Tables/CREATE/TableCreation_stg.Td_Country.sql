USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[Td_Country](
	[CountryID] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[SourceID] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
    [CreatedDate] DATETIME DEFAULT GETDATE()
) ON [PRIMARY]
GO
