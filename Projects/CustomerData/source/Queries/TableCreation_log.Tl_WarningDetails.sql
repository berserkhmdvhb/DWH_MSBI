USE [CustomerDWH]
GO

/****** Object:  Table [stg].[Td_Country]    Script Date: 5/3/2024 3:03:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [log].[Tl_WarningDetails] (
    WarningID INT IDENTITY(1,1) PRIMARY KEY,  -- Unique identifier for each warning
    Title NVARCHAR(255) NOT NULL,            -- Short title for the warning
    MessageTemplate NVARCHAR(1000) NOT NULL, -- Template for warning message
    Category NVARCHAR(255) NOT NULL,         -- Category of the warning
    DefaultSeverity NVARCHAR(50) NOT NULL,   -- Default severity level
    ActionRequired BIT NOT NULL              -- Indicates if action is required
);


