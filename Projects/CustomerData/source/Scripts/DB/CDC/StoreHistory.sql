USE [CustomerDWH]
GO

/****** Object:  Table [cdc].[dbo_FactCustomer_CT]    Script Date: 9/26/2024 11:43:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FactCustomerHistory](
	[__$start_lsn] [binary](10) NOT NULL,
	[__$end_lsn] [binary](10) NULL,
	[__$seqval] [binary](10) NOT NULL,
	[__$operation] [int] NOT NULL,
	[__$update_mask] [varbinary](128) NULL,
	[RowNumber] [int] NULL,
	[CustomerCode] [int] NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [date] NULL,
	[CountryID_FK] [int] NULL,
	[StateID_FK] [int] NULL,
	[ProductID_FK] [int] NULL,
	[SalesPersonID_FK] [int] NULL,
	[__$command_id] [int] NULL
) ON [PRIMARY]
GO






EXEC [dbo].[cdc_RetainHistory]