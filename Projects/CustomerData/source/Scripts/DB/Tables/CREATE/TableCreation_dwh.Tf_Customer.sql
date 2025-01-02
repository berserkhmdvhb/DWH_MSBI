USE [CustomerDWH]
GO

/****** Object:  Table [dwh].[Tf_Customer]    Script Date: 5/3/2024 3:03:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dwh].[Tf_Customer](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDateID_FK] [int] NULL,
	[CountryID_FK] [int] NULL,
	[StateID_FK] [int] NULL,
	[ProductID_FK] [int] NULL,
	[SalesPersonID_FK] [int] NULL,
	[SourceID] NVARCHAR(255) NULL,
	[SourceContext] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
    [CreatedDate] DATETIME DEFAULT GETDATE()
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*
ALTER TABLE [dwh].[Tf_Customer] WITH NOCHECK ADD  CONSTRAINT [FK_Tf_Customer_Td_SalesPerson] FOREIGN KEY([SalesPersonId_FK])
REFERENCES [dwh].[Td_SalesPerson] ([SalesPersonID])
GO

ALTER TABLE [dwh].[Tf_Customer] CHECK CONSTRAINT [FK_Tf_Customer_Td_SalesPerson]
GO

ALTER TABLE [dwh].[Tf_Customer]  WITH NOCHECK ADD  CONSTRAINT [FK_Tf_Customer_Td_State] FOREIGN KEY([StateId_FK])
REFERENCES [dwh].[Td_State] ([StateID])
GO

ALTER TABLE [dwh].[Tf_Customer] CHECK CONSTRAINT [FK_Tf_Customer_Td_State]
GO
*/

ALTER TABLE [dwh].[Tf_Customer] WITH NOCHECK ADD  CONSTRAINT [FK_Tf_Customer_Td_Period] FOREIGN KEY([SalesDateId_FK])
REFERENCES [dwh].[Td_Period] ([date_key])
GO

ALTER TABLE [dwh].[Tf_Customer] CHECK CONSTRAINT [FK_Tf_Customer_Td_Period]
GO


