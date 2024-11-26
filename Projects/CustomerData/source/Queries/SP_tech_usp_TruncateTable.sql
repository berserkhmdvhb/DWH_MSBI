GO
/****** Object:  StoredProcedure [dbo].[usp_TruncateTable]    Script Date: 26/11/2024 8:07:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
-- =============================================
-- Author:		HMDVHB
-- Create date: 03.07.2024
-- Description:	Truncate given table with given schema
-- =============================================
CREATE PROCEDURE [tech].[usp_TruncateTable]
	@Schema VARCHAR(100),
	@TableName VARCHAR(100)
	WITH EXECUTE AS N'dbo'
AS
BEGIN
	DECLARE @query NVARCHAR(MAX)
	DECLARE @InputSchema NVARCHAR(100)
	SET @InputSchema = ISNULL(@Schema, 'dbo')
	SET @query = 'TRUNCATE TABLE' + ' ' + @InputSchema + '.' + @TableName
 
	EXEC sp_executesql @query
END