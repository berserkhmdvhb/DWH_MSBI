USE [CustomerDWH]
GO
/****** Object:  StoredProcedure [tech].[usp_LogWarningDynamic]    Script Date: 12/6/2024 5:48:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   <>
-- =============================================
CREATE PROCEDURE [tech].[usp_PopulateWarningDetails]
    @WarningID INT = NULL,             -- Optional WarningID to uniquely identify the warning
    @Title NVARCHAR(255) = NULL,       -- Title for the warning
    @MessageTemplate NVARCHAR(1000) = NULL, -- Template for the warning message
    @Category NVARCHAR(255) = NULL,    -- Warning category
    @DefaultSeverity NVARCHAR(50) = NULL, -- Default severity level
    @ActionRequired BIT = NULL         -- Flag for action required
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable to store error message
    DECLARE @FailMessage NVARCHAR(4000);

    -- Check if the warning exists based on key columns
    IF EXISTS (
        SELECT 1 
        FROM [log].[Tl_WarningDetails]
        WHERE WarningID = @WarningID
    )
    BEGIN
        PRINT 'Warning already exists. Updating existing entry...';

        -- Update the existing warning details, keeping current values if no new input is provided
        UPDATE [log].[Tl_WarningDetails]
        SET
            Title = COALESCE(@Title, Title),
            MessageTemplate = COALESCE(@MessageTemplate, MessageTemplate),
            Category = COALESCE(@Category, Category),
            DefaultSeverity = COALESCE(@DefaultSeverity, DefaultSeverity),
            ActionRequired = COALESCE(@ActionRequired, ActionRequired)
        WHERE WarningID = @WarningID;

        PRINT 'Warning details updated successfully.';
    END
    ELSE IF @WarningID IS NOT NULL
    BEGIN
        -- Raise an error if WarningID is provided but not found
        SET @FailMessage = 'WarningID not found in table.';
        RAISERROR (@FailMessage, 16, 1);
    END
    ELSE
    BEGIN
        PRINT 'Adding a new warning entry...';

        -- Insert a new warning if it doesn't exist
        INSERT INTO [log].[Tl_WarningDetails] (Title, MessageTemplate, Category, DefaultSeverity, ActionRequired)
        VALUES (@Title, @MessageTemplate, @Category, @DefaultSeverity, @ActionRequired);

        PRINT 'New warning added successfully.';
    END
END;
GO