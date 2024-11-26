USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_State]    Script Date: 5/20/2024 5:49:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[Td_State](
	[StateID] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[CountryID] [int] NOT NULL
 CONSTRAINT [PK_DimState] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO