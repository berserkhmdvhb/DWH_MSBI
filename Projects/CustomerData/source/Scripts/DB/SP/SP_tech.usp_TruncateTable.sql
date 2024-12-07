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
CREATE PROCEDURE [tech].[usp_TruncateTable]
    @Schema VARCHAR(100),
    @TableName VARCHAR(100)
AS
BEGIN
    DECLARE @query NVARCHAR(MAX)
    DECLARE @InputSchema NVARCHAR(100)
    SET @InputSchema = ISNULL(@Schema, 'dbo')
    SET @query = 'TRUNCATE TABLE ' + QUOTENAME(@InputSchema) + '.' + QUOTENAME(@TableName)

    EXEC sp_executesql @query
END
