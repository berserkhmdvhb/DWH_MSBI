-- Drop table if it exists
IF OBJECT_ID('dbo.DimDate', 'U') IS NOT NULL
  DROP TABLE dbo.DimDate;

-- Create the table
CREATE TABLE dbo.DimDate
(
  date_key              INT NOT NULL,
  date                  DATE NOT NULL,
  weekday               VARCHAR(9) NOT NULL,
  weekday_num           INT NOT NULL,
  day_month             INT NOT NULL,
  day_of_year           INT NOT NULL,
  week_of_year          INT NOT NULL,
  iso_week              CHAR(10) NOT NULL,
  month_num             INT NOT NULL,
  month_name            VARCHAR(9) NOT NULL,
  month_name_short      CHAR(3) NOT NULL,
  quarter               INT NOT NULL,
  year                  INT NOT NULL,
  first_day_of_month    DATE NOT NULL,
  last_day_of_month     DATE NOT NULL,
  yyyymm                CHAR(7) NOT NULL,
  weekend_indr          CHAR(10) NOT NULL
);

-- Add a primary key
ALTER TABLE dbo.DimDate ADD CONSTRAINT PK_DimDate PRIMARY KEY (date_key);

-- Create an index
CREATE INDEX IDX_date_date_actual ON dbo.DimDate(date);

-- Insert data into table
;WITH DateRange AS (
    SELECT CAST('2010-01-01' AS DATE) AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM DateRange
    WHERE DateValue < '2029-12-31'
)
INSERT INTO dbo.DimDate
SELECT 
    CONVERT(varchar, DateValue, 112) AS date_key,
    DateValue AS date,
    DATENAME(WEEKDAY, DateValue) AS weekday,
    DATEPART(WEEKDAY, DateValue) AS weekday_num,
    DATEPART(DAY, DateValue) AS day_month,
    DATEPART(DAYOFYEAR, DateValue) AS day_of_year,
    DATEPART(WEEK, DateValue) AS week_of_year,
    FORMAT(DateValue, 'yyyy') + '-W' + FORMAT(DATEPART(ISOWK, DateValue), '00') + '-' + CONVERT(VARCHAR, DATEPART(WEEKDAY, DateValue)) AS iso_week,
    DATEPART(MONTH, DateValue) AS month_num,
    DATENAME(MONTH, DateValue) AS month_name,
    LEFT(DATENAME(MONTH, DateValue), 3) AS month_name_short,
    DATEPART(QUARTER, DateValue) AS quarter,
    YEAR(DateValue) AS year,
    DATEADD(DAY, 1 - DAY(DateValue), DateValue) AS first_day_of_month,
    EOMONTH(DateValue) AS last_day_of_month,
    CONVERT(CHAR(4), YEAR(DateValue)) + '-' + RIGHT('00' + CONVERT(VARCHAR, MONTH(DateValue)), 2) AS yyyymm,
    CASE WHEN DATEPART(WEEKDAY, DateValue) IN (1, 7) THEN 'weekend' ELSE 'weekday' END AS weekend_indr
FROM DateRange
OPTION (MAXRECURSION 0);

-- Select data to display
SELECT * FROM dbo.DimDate;
