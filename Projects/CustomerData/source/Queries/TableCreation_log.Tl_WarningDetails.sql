USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_WarningDetails] (
    [WarningID] INT IDENTITY(1,1) PRIMARY KEY,       -- Unique identifier for each warning type
    [MessageTemplate] NVARCHAR(1000) NOT NULL,      -- Template with placeholders (e.g., "Missing key: {KeyValue}")
    [Category] NVARCHAR(255) NOT NULL,             -- Category of the warning (e.g., "Missing Dimension")
    [DefaultSeverity] NVARCHAR(50) NOT NULL,       -- Default severity for the warning (e.g., High, Medium)
    [ActionRequired] BIT NOT NULL DEFAULT 1        -- Indicates if action is required (1 = Yes, 0 = No)
);

-- Example Data:
-- INSERT INTO [log].[Tl_WarningDetails] (MessageTemplate, Category, DefaultSeverity, ActionRequired)
-- VALUES 
-- ('Missing dimension key: {KeyValue} for {DimensionName}', 'Missing Dimension', 'High', 1),
-- ('Data conversion failed for {ColumnName} with value {Value}', 'Data Quality', 'Medium', 1);
