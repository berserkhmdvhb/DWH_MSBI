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
CREATE PROCEDURE [tech].[usp_LogRowMetadata]
    @PackageId UNIQUEIDENTIFIER, -- System::PackageID
    @TableName NVARCHAR(255),    -- Name of the affected table
    @SourceID NVARCHAR(255)      -- Source system identifier
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    -- Log creations
    SET @SQL = '
        INSERT INTO [log].[Tl_AuditRowLevel] (SourceID, ActionType, CreatedBy, ModifiedBy, CreatedDate, TableName)
        SELECT 
            @SourceID AS SourceID,
            ''CREATE'' AS ActionType,
            CreatedBy,
            NULL AS ModifiedBy, -- No modification on creation
            CreatedDate,
            @TableName AS TableName
        FROM ' + QUOTENAME(@TableName) + '
        WHERE CreatedBy = @PackageId AND ModifiedBy IS NULL;
    ';
    EXEC sp_executesql @SQL,
        N'@SourceID NVARCHAR(255), @PackageId UNIQUEIDENTIFIER, @TableName NVARCHAR(255)',
        @SourceID = @SourceID, @PackageId = @PackageId, @TableName = @TableName;

    -- Log modifications
    SET @SQL = '
        INSERT INTO [log].[Tl_AuditRowLevel] (SourceID, ActionType, CreatedBy, ModifiedBy, CreatedDate, TableName)
        SELECT 
            @SourceID AS SourceID,
            ''UPDATE'' AS ActionType,
            NULL AS CreatedBy, -- No creation on update
            ModifiedBy,
            CreatedDate,
            @TableName AS TableName
        FROM ' + QUOTENAME(@TableName) + '
        WHERE ModifiedBy = @PackageId AND CreatedBy IS NOT NULL;
    ';
    EXEC sp_executesql @SQL,
        N'@SourceID NVARCHAR(255), @PackageId UNIQUEIDENTIFIER, @TableName NVARCHAR(255)',
        @SourceID = @SourceID, @PackageId = @PackageId, @TableName = @TableName;
END;
GO
