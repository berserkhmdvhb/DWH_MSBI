USE [CustomerDWH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   Logs row-level metadata for creation and updates
-- =============================================
CREATE PROCEDURE [tech].[usp_PopulateWarningDetails]
    @MessageTemplate NVARCHAR(1000),  -- Warning template with placeholders
    @Category NVARCHAR(255),          -- Category of the warning
    @DefaultSeverity NVARCHAR(50),    -- Default severity (e.g., High, Medium, Low)
    @ActionRequired BIT               -- Whether action is required (1 = Yes, 0 = No)
AS
BEGIN
    SET NOCOUNT ON;

     -- Check if the warning already exists
    IF NOT EXISTS (
        SELECT 1
        FROM [log].[Tl_WarningDetails]
        WHERE MessageTemplate = @MessageTemplate
    )
    BEGIN
        -- Insert the new warning
        INSERT INTO [log].[Tl_WarningDetails] (MessageTemplate, Category, DefaultSeverity, ActionRequired)
        VALUES (@MessageTemplate, @Category, @DefaultSeverity, @ActionRequired);

        PRINT 'Warning successfully added.';
    END
    ELSE
    BEGIN
        PRINT 'Warning already exists. No action taken.';
    END
END;
GO