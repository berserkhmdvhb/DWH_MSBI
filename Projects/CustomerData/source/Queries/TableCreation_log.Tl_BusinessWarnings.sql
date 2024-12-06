USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_BusinessWarnings] (
    [RowID] INT IDENTITY(1,1) PRIMARY KEY,          -- Unique identifier for each warning instance
    [WarningID] INT NOT NULL,                      -- Foreign key to [log].[Tl_WarningDetails].[WarningID]
    [SourceID] NVARCHAR(255) NOT NULL,             -- Identifier for the source system (e.g., MDM, ETL)
    [SourceContext] NVARCHAR(255) NOT NULL,        -- Context (e.g., "Dimension: Country" or "Fact: Sales")
    [CreatedBy] UNIQUEIDENTIFIER NOT NULL,         -- SSIS package or process logging the warning
    [CreatedDate] DATETIME DEFAULT GETDATE(),      -- Timestamp when the warning was logged
	[Severity] NVARCHAR(50) NOT NULL,              -- Severity level of the warning (e.g., High, Medium, Low)
    [MessageDetails] NVARCHAR(1000) NOT NULL,      -- Fully contextualized warning message
    CONSTRAINT FK_BusinessWarnings_WarningDetails FOREIGN KEY (WarningID)
        REFERENCES [log].[Tl_WarningDetails] (WarningID) 
        ON DELETE CASCADE
);

CREATE NONCLUSTERED INDEX IX_BusinessWarnings_Severity
ON [log].[Tl_BusinessWarnings] (Severity);

CREATE NONCLUSTERED INDEX IX_BusinessWarnings_SourceContext
ON [log].[Tl_BusinessWarnings] (SourceContext);

CREATE NONCLUSTERED INDEX IX_BusinessWarnings_CreatedDate
ON [log].[Tl_BusinessWarnings] (CreatedDate);

