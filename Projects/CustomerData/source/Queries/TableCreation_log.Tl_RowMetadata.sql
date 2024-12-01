USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Tf_Customer]    Script Date: 5/3/2024 3:03:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[Tf_Customer](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [date] NULL,
	[ContryName] [nvarchar](50) NULL,
	[StateName] [nvarchar](50) NULL,
	[ProductName] [nvarchar](50) NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SourceID] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
    [CreatedDate] DATETIME DEFAULT GETDATE()
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
