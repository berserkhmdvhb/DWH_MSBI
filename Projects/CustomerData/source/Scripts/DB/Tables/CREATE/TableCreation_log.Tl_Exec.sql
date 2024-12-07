USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_Exec] (
    [LogId] INT IDENTITY(1,1) NOT NULL, -- Auto-incrementing log ID
    [PackageId] UNIQUEIDENTIFIER NOT NULL, -- Links to [log].[Tl_Packages].[PackageId]
    [RunTime] DATETIME NOT NULL, -- Timestamp of the execution
	[ExecutionStatus] NVARCHAR(50) NULL, -- Status: Success/Failure/Running
    CONSTRAINT [PK_Tl_Exec] PRIMARY KEY CLUSTERED ([LogId] ASC), -- Primary key
    CONSTRAINT [FK_Tl_Exec_PackageId] FOREIGN KEY ([PackageId]) -- Foreign key linking to Tl_Packages
        REFERENCES [log].[Tl_Packages] ([PackageId])
        ON DELETE CASCADE ON UPDATE CASCADE -- Maintain referential integrity
);
GO

-- Optional: Add an index for faster lookups by PackageId and RunTime
CREATE NONCLUSTERED INDEX [IX_Tl_Exec_PackageId_RunTime] ON [log].[Tl_Exec] (
    [PackageId] ASC,
    [RunTime] ASC
);
GO
