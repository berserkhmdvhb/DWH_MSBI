USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Tf_Customer]    Script Date: 5/3/2024 3:03:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_AuditRowLevel] (
    [RowId] INT IDENTITY(1,1) NOT NULL,               -- Auto-incrementing unique ID
    [SourceID] NVARCHAR(255) NULL,                    -- Source system identifier
    [ActionType] NVARCHAR(50) NOT NULL,               -- 'CREATE' or 'UPDATE'
    [CreatedBy] UNIQUEIDENTIFIER NULL,                -- Package responsible for the row
    [ModifiedBy] UNIQUEIDENTIFIER NULL,               -- Package that modified the row
    [CreatedDate] DATETIME DEFAULT GETDATE(),         -- Timestamp of creation
    [TableName] NVARCHAR(255) NOT NULL,               -- Destination table name
    CONSTRAINT [PK_Tl_AuditRowLevel] PRIMARY KEY ([RowId])
);