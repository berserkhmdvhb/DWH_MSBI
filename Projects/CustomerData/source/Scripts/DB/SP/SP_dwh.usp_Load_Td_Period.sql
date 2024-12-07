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
CREATE PROCEDURE [dwh].[usp_Load_Td_Period]
    @ToBackup BIT
AS
BEGIN
    DECLARE @CDate NVARCHAR(8) = CONVERT(NVARCHAR(8), GETDATE(), 112);
    DECLARE @BackupTableName NVARCHAR(255) = '[CustomerDWH].[dwh].[Td_Period_' + @CDate + ']';
    DECLARE @QueryBackup NVARCHAR(MAX) = 'SELECT * INTO ' + @BackupTableName + ' FROM [CustomerDWH].[dwh].[Td_Period]';
    DECLARE @MaxDate DATE;
    DECLARE @CurrentDate DATE;
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);
    DECLARE @EndDate DATE = EOMONTH(DATEFROMPARTS(YEAR(@Today) + 1, 12, 1));

    -- Get the latest date from the Td_Period table
    SELECT @MaxDate = MAX([date]) FROM [dwh].[Td_Period];

    -- If the table is empty, start from 1990-01-01; otherwise, continue from the last date
    IF @MaxDate IS NULL
        SET @CurrentDate = '1990-01-01';
    ELSE
        SET @CurrentDate = DATEADD(DAY, 1, @MaxDate);

    -- Backup the table if requested
    IF @ToBackup = 1
    BEGIN
        EXEC sp_executesql @QueryBackup;
        PRINT 'Backup table created: ' + @BackupTableName;
    END

    -- Fill the Td_Period table
    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO [dwh].[Td_Period] (
            [date_key], [date], [weekday], [weekday_num], [day_month], [day_of_year],
            [week_of_year], [iso_week], [week_id], [week_desc],
            [month_num], [month_name], [month_name_short], [month_id], [month_desc],
            [first_day_of_month], [last_day_of_month], [yyyymm],
            [quarter], [quarter_id], [quarter_desc], [quarter_cd],
            [semester_id], [semester_desc], [semester_cd],
            [year], [year_id], [year_desc], [year_cd],
            [weekend_indr]
        )
        SELECT
            CAST(FORMAT(@CurrentDate, 'yyyyMMdd') AS INT) AS [date_key],
            @CurrentDate AS [date],
            DATENAME(WEEKDAY, @CurrentDate) AS [weekday],
            DATEPART(WEEKDAY, @CurrentDate) AS [weekday_num],
            DAY(@CurrentDate) AS [day_month],
            DATEPART(DAYOFYEAR, @CurrentDate) AS [day_of_year],
            DATEPART(WEEK, @CurrentDate) AS [week_of_year],
            FORMAT(DATEPART(ISO_WEEK, @CurrentDate), '0000') + '-W' + FORMAT(DATEPART(ISO_WEEK, @CurrentDate), '00') AS [iso_week],
            DATEPART(YEAR, @CurrentDate) * 100 + DATEPART(ISO_WEEK, @CurrentDate) AS [week_id],
            CONCAT(YEAR(@CurrentDate), ' W', FORMAT(DATEPART(ISO_WEEK, @CurrentDate), '00')) AS [week_desc],
            MONTH(@CurrentDate) AS [month_num],
            DATENAME(MONTH, @CurrentDate) AS [month_name],
            LEFT(DATENAME(MONTH, @CurrentDate), 3) AS [month_name_short],
            DATEPART(YEAR, @CurrentDate) * 100 + MONTH(@CurrentDate) AS [month_id],
            FORMAT(@CurrentDate, 'yyyy MMM') AS [month_desc],
            DATEFROMPARTS(YEAR(@CurrentDate), MONTH(@CurrentDate), 1) AS [first_day_of_month],
            EOMONTH(@CurrentDate) AS [last_day_of_month],
            FORMAT(@CurrentDate, 'yyyy-MM') AS [yyyymm],
            DATEPART(QUARTER, @CurrentDate) AS [quarter],
            DATEPART(YEAR, @CurrentDate) * 100 + DATEPART(QUARTER, @CurrentDate) AS [quarter_id],
            CONCAT('Q', DATEPART(QUARTER, @CurrentDate), '''', RIGHT(YEAR(@CurrentDate), 2)) AS [quarter_desc],
            CONCAT(YEAR(@CurrentDate), '-Q', DATEPART(QUARTER, @CurrentDate)) AS [quarter_cd],
            DATEPART(YEAR, @CurrentDate) * 100 + CASE WHEN DATEPART(QUARTER, @CurrentDate) <= 2 THEN 1 ELSE 2 END AS [semester_id],
            CONCAT('S', CASE WHEN DATEPART(QUARTER, @CurrentDate) <= 2 THEN 1 ELSE 2 END, '''', RIGHT(YEAR(@CurrentDate), 2)) AS [semester_desc],
            CONCAT(YEAR(@CurrentDate), '-S', CASE WHEN DATEPART(QUARTER, @CurrentDate) <= 2 THEN 1 ELSE 2 END) AS [semester_cd],
            YEAR(@CurrentDate) AS [year],
            YEAR(@CurrentDate) AS [year_id],
            FORMAT(@CurrentDate, 'yyyy') AS [year_desc],
            FORMAT(@CurrentDate, 'yyyy') AS [year_cd],
            CASE WHEN DATENAME(WEEKDAY, @CurrentDate) IN ('Saturday', 'Sunday') THEN 'weekend' ELSE 'weekday' END AS [weekend_indr];

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END
END
GO
