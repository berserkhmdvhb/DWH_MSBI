USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_SalesPerson]    Script Date: 5/28/2024 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[Td_SalesPerson](
	[SalesPersonID] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SalesPersonBossID] [int] NOT NULL,
	[SourceID] NVARCHAR(255) NULL,
	[SourceContext] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
    [CreatedDate] DATETIME DEFAULT GETDATE()
 CONSTRAINT [PK_DimSalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


