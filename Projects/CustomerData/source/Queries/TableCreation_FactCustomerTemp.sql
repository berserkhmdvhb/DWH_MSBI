USE [CustomerDWH]
GO

/****** Object:  Table [dbo].[FactCustomer]    Script Date: 5/5/2024 4:40:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactCustomerTemp](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [date] NULL
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
