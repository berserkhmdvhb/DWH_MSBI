USE [CustomerDWH]
GO

/****** Object:  Table [dwh].[Td_State]    Script Date: 5/20/2024 5:49:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dwh].[Td_State](
	[StateID] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[CountryID] [int] NOT NULL,
	[IsNew] [bit] NULL,
	[SourceID] NVARCHAR(255) NULL,
	[SourceContext] NVARCHAR(255) NULL,
	[CreatedBy] UNIQUEIDENTIFIER NULL,
	[ModifiedBy] UNIQUEIDENTIFIER NULL,
    [CreatedDate] DATETIME DEFAULT GETDATE()
) ON [PRIMARY]
GO

