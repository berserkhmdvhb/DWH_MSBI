USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Product]    Script Date: 5/3/2024 3:03:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[Td_Product](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL
) ON [PRIMARY]
GO


