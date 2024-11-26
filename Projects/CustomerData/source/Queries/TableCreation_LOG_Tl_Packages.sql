USE [CustomerDWH]
GO

/****** Object:  Table [log].[Tl_Packages]    Script Date: 11/26/2024 5:42:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_Packages](
	[PackageId] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	[PackageName] [nvarchar](255) NOT NULL,
	[CreatedDate] DATETIME DEFAULT GETDATE(),
	[IsActive] BIT DEFAULT 1
) ON [PRIMARY]
GO

ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT (newid()) FOR [PackageId]
GO

ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO

ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT ((1)) FOR [IsActive]
GO


