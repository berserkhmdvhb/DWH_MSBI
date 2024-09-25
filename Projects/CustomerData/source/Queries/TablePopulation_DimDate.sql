-- Declare variables for the start date and end date
DECLARE @StartDate DATE = '2010-01-01'; -- You can change this to your desired start date
DECLARE @EndDate DATE = '2030-12-31';   -- You can change this to your desired end date

-- Using a Recursive CTE to generate the date sequence
WITH DateSequence AS (
    SELECT @StartDate AS datum
    UNION ALL
    SELECT DATEADD(DAY, 1, datum)
    FROM DateSequence
    WHERE DATEADD(DAY, 1, datum) <= @EndDate
)
-- Inserting data into [dbo].[DimDate]
INSERT INTO [dbo].[DimDate] (
    date_key,
    date,
    weekday,
    weekday_num,
    day_month,
    day_of_year,
    week_of_year,
    iso_week,
    month_num,
    month_name,
    month_name_short,
    quarter,
    year,
    first_day_of_month,
    last_day_of_month,
    yyyymm,
    weekend_indr
)
SELECT 
    CAST(FORMAT(datum, 'yyyyMMdd') AS INT) AS date_key,
    datum AS date,
    DATENAME(WEEKDAY, datum) AS weekday,
    DATEPART(WEEKDAY, datum) AS weekday_num,
    DAY(datum) AS day_month,
    DATEPART(DAYOFYEAR, datum) AS day_of_year,
    DATEPART(WEEK, datum) AS week_of_year,
    FORMAT(DATEPART(ISO_WEEK, datum), '0000') + '-W' + FORMAT(DATEPART(ISO_WEEK, datum), '00') AS iso_week,
    MONTH(datum) AS month_num,
    DATENAME(MONTH, datum) AS month_name,
    LEFT(DATENAME(MONTH, datum), 3) AS month_name_short,
    DATEPART(QUARTER, datum) AS quarter,
    YEAR(datum) AS year,
    DATEFROMPARTS(YEAR(datum), MONTH(datum), 1) AS first_day_of_month,
    EOMONTH(datum) AS last_day_of_month,
    FORMAT(datum, 'yyyy-MM') AS yyyymm,
    CASE
        WHEN DATENAME(WEEKDAY, datum) IN ('Saturday', 'Sunday') THEN 'weekend'
        ELSE 'weekday'
    END AS weekend_indr
FROM DateSequence
OPTION (MAXRECURSION 0); -- Allows recursion beyond the default limit of 100
