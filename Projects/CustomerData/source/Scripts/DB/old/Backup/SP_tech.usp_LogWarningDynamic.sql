USE [CustomerDWH]
GO
/****** Object:  StoredProcedure [tech].[usp_LogWarningDynamic]    Script Date: 12/2/2024 4:49:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   Logs row-level metadata for creation and updates
-- =============================================
ALTER PROCEDURE [tech].[usp_LogWarningDynamic]
    @WarningID INT,                  -- Foreign key to [log].[Tl_WarningDetails]
    @SourceID NVARCHAR(255),         -- Identifier for the source system
    @SourceContext NVARCHAR(255),    -- Context (e.g., "Dimension: Country")
    @CreatedBy UNIQUEIDENTIFIER,     -- ID of the process logging the warning
    @DynamicParams NVARCHAR(MAX)     -- JSON string of dynamic values for placeholders
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @MessageTemplate NVARCHAR(1000);   -- Template fetched from [log].[Tl_WarningDetails]
    DECLARE @FinalMessage NVARCHAR(1000);      -- Final message with placeholders replaced
    DECLARE @DefaultSeverity NVARCHAR(50);     -- Default severity from [log].[Tl_WarningDetails]
    DECLARE @FailMessage NVARCHAR(4000);       -- Error message for invalid WarningID

    -- Validate WarningID
    IF NOT EXISTS (SELECT 1 FROM [log].[Tl_WarningDetails] WHERE WarningID = @WarningID)
    BEGIN
        SET @FailMessage = 'Invalid WarningID provided.';
        RAISERROR (@FailMessage, 16, 1);
        RETURN;
    END;

    -- Retrieve the MessageTemplate and DefaultSeverity for the given WarningID
    SELECT 
        @MessageTemplate = MessageTemplate,
        @DefaultSeverity = DefaultSeverity
    FROM [log].[Tl_WarningDetails]
    WHERE WarningID = @WarningID;

    -- Parse JSON parameters into a table variable
    DECLARE @ParamTable TABLE ([Key] NVARCHAR(255), [Value] NVARCHAR(255));
    INSERT INTO @ParamTable ([Key], [Value])
    SELECT [Key], [Value]
    FROM OPENJSON(@DynamicParams)
    WITH ([Key] NVARCHAR(255) '$.Key', [Value] NVARCHAR(255) '$.Value');

    -- Construct the final message by replacing placeholders
    SET @FinalMessage = @MessageTemplate;

    SELECT @FinalMessage = REPLACE(@FinalMessage, '{' + [Key] + '}', [Value])
    FROM @ParamTable;

    -- Insert the warning into [log].[Tl_BusinessWarnings]
    INSERT INTO [log].[Tl_BusinessWarnings] 
        (WarningID, SourceID, SourceContext, CreatedBy, CreatedDate, Severity, MessageDetails)
    VALUES 
        (@WarningID, @SourceID, @SourceContext, @CreatedBy, GETDATE(), @DefaultSeverity, @FinalMessage);

    PRINT 'Warning successfully logged.';
END;
GO
