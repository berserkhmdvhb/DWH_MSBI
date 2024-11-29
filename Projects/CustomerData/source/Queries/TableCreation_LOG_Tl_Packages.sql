USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_Packages] (
    [PackageId] UNIQUEIDENTIFIER NOT NULL, -- Use System::PackageID for consistency
    [PackageName] NVARCHAR(255) NOT NULL, -- Name of the package
    [CreatedDate] DATETIME NOT NULL DEFAULT GETDATE(), -- When the entry was created
    [IsActive] BIT NOT NULL DEFAULT 1, -- Indicates if the package is active
    CONSTRAINT [PK_Tl_Packages] PRIMARY KEY CLUSTERED ([PackageId] ASC) -- Primary key
);
GO

-- Optional: Add an index to improve lookups by PackageName
CREATE UNIQUE NONCLUSTERED INDEX [IX_PackageName] ON [log].[Tl_Packages] ([PackageName] ASC);
GO
