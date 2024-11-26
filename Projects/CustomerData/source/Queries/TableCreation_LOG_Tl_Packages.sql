USE [CustomerDWH]
GO

/****** Object:  Table [log].[Tl_Packages]    Script Date: 11/26/2024 5:42:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_Packages](
	[PackageId] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT (newid()) FOR [PackageId]
GO

ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT ((1)) FOR [IsActive]
GO


