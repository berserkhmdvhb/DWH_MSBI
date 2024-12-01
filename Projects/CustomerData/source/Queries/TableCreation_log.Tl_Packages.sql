USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_Packages] (
    [PackageId] UNIQUEIDENTIFIER NOT NULL, -- System::PackageID
    [PackageName] NVARCHAR(255) NOT NULL, -- Name of the package
    [CreatedDate] DATETIME NOT NULL DEFAULT GETDATE(), -- When the entry was created
    [IsActive] BIT NOT NULL DEFAULT 1, -- Indicates if the package is active
    CONSTRAINT [PK_Tl_Packages] PRIMARY KEY CLUSTERED ([PackageId] ASC)
);

-- Optional Index for faster lookups by PackageName
CREATE NONCLUSTERED INDEX [IX_Tl_Packages_PackageName]
ON [log].[Tl_Packages] ([PackageName]);