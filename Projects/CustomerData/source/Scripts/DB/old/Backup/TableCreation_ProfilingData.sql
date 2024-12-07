USE [CustomerDWH]
GO

/****** Object:  Table [dbo].[FactCustomer]    Script Date: 5/27/2024 11:47:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProfilingData](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Email Address] [nvarchar](250) NULL,
	[D O B] DATE NULL,
	[Salary] [bigint] NULL,
	[CountryCode] [nvarchar](250) NULL,
	[EMP Code] [nvarchar](250) NULL,
	[Dept Code] [nvarchar](250) NULL,
	[Country] [nvarchar](250) NULL,
	[CountryTaxCode] [nvarchar](250) NULL,
	[TaxPercentage] [float] NULL,
	[Pan card] [nvarchar](250) NULL
PRIMARY KEY CLUSTERED 
(
	[RowNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
