USE [CustomerDWH]
GO
/****** Object:  StoredProcedure [tech].[usp_LogWarningDynamic]    Script Date: 1/3/2025 12:38:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   Logs warnings dynamically with source object support
-- =============================================
CREATE PROCEDURE [tech].[usp_LogWarningDynamic]
    @WarningID INT,
    @SourceID NVARCHAR(255),
    @SourceContext NVARCHAR(255),
    @SourceObject NVARCHAR(255),       -- New parameter for source object name
    @CreatedBy UNIQUEIDENTIFIER,
    @DynamicParams NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @MessageTemplate NVARCHAR(1000);
    DECLARE @FinalMessage NVARCHAR(MAX);
    DECLARE @DefaultSeverity NVARCHAR(50);
    DECLARE @DynamicDetails NVARCHAR(MAX);
    DECLARE @Key NVARCHAR(255);

    -- Validate WarningID
    IF NOT EXISTS (SELECT 1 FROM [log].[Tl_WarningDetails] WHERE WarningID = @WarningID)
    BEGIN
        RAISERROR ('Invalid WarningID provided.', 16, 1);
        RETURN;
    END;

    -- Retrieve MessageTemplate and DefaultSeverity
    SELECT 
        @MessageTemplate = MessageTemplate,
        @DefaultSeverity = DefaultSeverity
    FROM [log].[Tl_WarningDetails]
    WHERE WarningID = @WarningID;

    -- Parse JSON into a table variable
    DECLARE @ParamTable TABLE ([Key] NVARCHAR(255), [Value] NVARCHAR(255));
    INSERT INTO @ParamTable ([Key], [Value])
    SELECT [Key], [Value]
    FROM OPENJSON(@DynamicParams)
    WITH ([Key] NVARCHAR(255) '$.Key', [Value] NVARCHAR(255) '$.Value');

    -- Retrieve the first Key where the Value is 'Missing' (if applicable)
    SELECT TOP 1 @Key = [Key]
    FROM @ParamTable
    WHERE [Value] = 'Missing';

    -- Construct the dynamic details string from all key-value pairs, excluding ErrorCode and ErrorColumn
    DECLARE @RowDetails NVARCHAR(MAX) = '';
    SELECT @RowDetails = @RowDetails + [Key] + ': ' + ISNULL([Value], 'NULL') + CHAR(13) + CHAR(10)
    FROM @ParamTable
    WHERE [Key] NOT IN ('ErrorCode', 'ErrorColumn'); -- Exclude ErrorCode and ErrorColumn

    -- Remove trailing newlines
    IF LEN(@RowDetails) > 2
        SET @RowDetails = LEFT(@RowDetails, LEN(@RowDetails) - 2);

    -- Replace placeholders in the template
    SET @FinalMessage = REPLACE(@MessageTemplate, '{DynamicDetails}', @RowDetails);
    SET @FinalMessage = REPLACE(@FinalMessage, '{Key}', ISNULL(@Key, 'Unknown'));

    -- Insert the warning into the log table
    INSERT INTO [log].[Tl_BusinessWarnings] 
        (WarningID, SourceID, SourceContext, SourceObject, CreatedBy, CreatedDate, Severity, MessageDetails)
    VALUES 
        (@WarningID, @SourceID, @SourceContext, @SourceObject, @CreatedBy, GETDATE(), @DefaultSeverity, @FinalMessage);

    PRINT 'Warning successfully logged.';
END;
