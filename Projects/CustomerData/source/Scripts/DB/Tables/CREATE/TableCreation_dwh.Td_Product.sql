USE [CustomerDWH]
GO

/****** Object:  Table [dwh].[Td_Product]    Script Date: 5/3/2024 3:03:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dwh].[Td_Product](
	[ProductID] INT NOT NULL,
	[ProductName] NVARCHAR(50) NULL,
	[Ef_Date] DATETIME NULL,
	[Ex_Date] DATETIME NULL,
	[SourceID] NVARCHAR(255) NULL,
	[SourceContext] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
	[CreatedDate] DATETIME DEFAULT GETDATE()
) ON [PRIMARY]
GO


