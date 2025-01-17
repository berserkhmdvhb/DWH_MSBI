USE [CustomerDWH]
GO

/****** Object:  Table [dwh].[Td_SalesPerson]    Script Date: 5/28/2024 1:57:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dwh].[Td_SalesPerson](
	[SalesPersonID] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SalesPersonBossID_FK] [int],
	[IsNew] [bit] NULL,
	[SourceID] NVARCHAR(255) NULL,
	[SourceContext] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
    [CreatedDate] DATETIME DEFAULT GETDATE()
) ON [PRIMARY]
GO


