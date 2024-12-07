CREATE TABLE [dwh].[Td_Period](
	[Period_Key] [decimal](8, 0) NOT NULL,
	[Day] [date] NULL,
	[Week_Id] [int] NOT NULL,
	[Week_Desc] [nvarchar](10) NOT NULL,
	[Week_Cd] [nvarchar](10) NOT NULL,
	[Month_Id] [int] NOT NULL,
	[Month_Desc] [nvarchar](10) NOT NULL,
	[Month_Cd] [nvarchar](10) NOT NULL,
	[Quarter_Id] [int] NOT NULL,
	[Quarter_Desc] [nvarchar](10) NOT NULL,
	[Quarter_Cd] [nvarchar](10) NOT NULL,
	[Semester_Id] [int] NOT NULL,
	[Semester_Desc] [nvarchar](10) NOT NULL,
	[Semester_Cd] [nvarchar](10) NOT NULL,
	[Year_Id] [int] NOT NULL,
	[Year_Desc] [nvarchar](10) NOT NULL,
	[Year_Cd] [nvarchar](10) NOT NULL,
	[Source_Id] [nvarchar](20) NOT NULL,
	[Modified_By] [int] NOT NULL,
	[Created_By] [int] NOT NULL
) ON [PRIMARY]
GO


WITH DateRange AS (
    -- Generate a list of dates from 2020-01-01 to 2030-12-31
    SELECT CAST('2020-01-01' AS DATE) AS [Day]
    UNION ALL
    SELECT DATEADD(DAY, 1, [Day])
    FROM DateRange
    WHERE [Day] < '2030-12-31'
)
INSERT INTO [dwh].[Td_Period] (
    Period_Key, Day, Week_Id, Week_Desc, Week_Cd,
    Month_Id, Month_Desc, Month_Cd,
    Quarter_Id, Quarter_Desc, Quarter_Cd,
    Semester_Id, Semester_Desc, Semester_Cd,
    Year_Id, Year_Desc, Year_Cd,
    Source_Id, Modified_By, Created_By
)
SELECT
    -- Period_Key in the format YYYYMMDD
    CONVERT(DECIMAL(8, 0), CONVERT(CHAR(8), [Day], 112)) AS Period_Key,

    -- Day value from DateRange
    [Day],

    -- Week_Id (using DATEPART for ISO week)
    DATEPART(ISO_WEEK, [Day]) + (DATEPART(YEAR, [Day]) * 100) AS Week_Id,

    -- Week_Desc and Week_Cd (formatted as YYYY WXX)
    CONCAT(DATEPART(YEAR, [Day]), ' W', FORMAT(DATEPART(ISO_WEEK, [Day]), '00')) AS Week_Desc,
    CONCAT(DATEPART(YEAR, [Day]), '-W', FORMAT(DATEPART(ISO_WEEK, [Day]), '00')) AS Week_Cd,

    -- Month_Id, Month_Desc, Month_Cd (YYYYMM format)
    DATEPART(YEAR, [Day]) * 100 + DATEPART(MONTH, [Day]) AS Month_Id,
    FORMAT([Day], 'yyyy MMM') AS Month_Desc,
    FORMAT([Day], 'yyyy-MMM') AS Month_Cd,

    -- Quarter_Id, Quarter_Desc, Quarter_Cd (YYYYQX format)
    DATEPART(YEAR, [Day]) * 100 + DATEPART(QUARTER, [Day]) AS Quarter_Id,
    CONCAT('Q', DATEPART(QUARTER, [Day]), '''', RIGHT(DATEPART(YEAR, [Day]), 2)) AS Quarter_Desc,
    CONCAT(DATEPART(YEAR, [Day]), '-Q', DATEPART(QUARTER, [Day])) AS Quarter_Cd,

    -- Semester_Id, Semester_Desc, Semester_Cd (YYYYSX format)
    DATEPART(YEAR, [Day]) * 100 + CASE WHEN DATEPART(QUARTER, [Day]) <= 2 THEN 1 ELSE 2 END AS Semester_Id,
    CONCAT('S', CASE WHEN DATEPART(QUARTER, [Day]) <= 2 THEN 1 ELSE 2 END, '''', RIGHT(DATEPART(YEAR, [Day]), 2)) AS Semester_Desc,
    CONCAT(DATEPART(YEAR, [Day]), '-S', CASE WHEN DATEPART(QUARTER, [Day]) <= 2 THEN 1 ELSE 2 END) AS Semester_Cd,

    -- Year_Id, Year_Desc, Year_Cd
    DATEPART(YEAR, [Day]) AS Year_Id,
    FORMAT([Day], 'yyyy') AS Year_Desc,
    FORMAT([Day], 'yyyy') AS Year_Cd,

    -- Constant values for Source_Id, Modified_By, Created_By
    'XLS_P_S' AS Source_Id,
    0 AS Modified_By,
    0 AS Created_By
FROM DateRange
OPTION (MAXRECURSION 0); -- Allows recursion to go beyond 100 levels
