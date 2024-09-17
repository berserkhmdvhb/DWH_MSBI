USE [CustomerDWH]
GO

/****** Object:  Table [dbo].[FactCustomer]    Script Date: 5/5/2024 4:40:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DimDate](
	[date_key] [int] NOT NULL,
	[date] [date] NOT NULL,
	[weekday] [varchar](9) NOT NULL,
	[weekday_num] [int] NOT NULL,
	[day_month] [int] NOT NULL,
	[day_of_year] [int] NOT NULL,
	[week_of_year] [int] NOT NULL,
	[iso_week] [char](10) NOT NULL,
	[month_num] [int] NOT NULL,
	[month_name] [varchar](9) NOT NULL,
	[month_name_short] [char](3) NOT NULL,
	[quarter] [int] NOT NULL,
	[year] [int] NOT NULL,
	[first_day_of_month] [date] NOT NULL,
	[last_day_of_month] [date] NOT NULL,
	[yyyymm] [char](7) NOT NULL,
	[weekend_indr] [char](10) NOT NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
