USE [master]
GO
/****** Object:  Database [CustomerDWH]    Script Date: 9/25/2024 5:56:03 PM ******/
CREATE DATABASE [CustomerDWH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CustomerDWH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVERH\MSSQL\DATA\CustomerDWH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CustomerDWH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVERH\MSSQL\DATA\CustomerDWH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CustomerDWH] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CustomerDWH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CustomerDWH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CustomerDWH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CustomerDWH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CustomerDWH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CustomerDWH] SET ARITHABORT OFF 
GO
ALTER DATABASE [CustomerDWH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CustomerDWH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CustomerDWH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CustomerDWH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CustomerDWH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CustomerDWH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CustomerDWH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CustomerDWH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CustomerDWH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CustomerDWH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CustomerDWH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CustomerDWH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CustomerDWH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CustomerDWH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CustomerDWH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CustomerDWH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CustomerDWH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CustomerDWH] SET RECOVERY FULL 
GO
ALTER DATABASE [CustomerDWH] SET  MULTI_USER 
GO
ALTER DATABASE [CustomerDWH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CustomerDWH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CustomerDWH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CustomerDWH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CustomerDWH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CustomerDWH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CustomerDWH', N'ON'
GO
ALTER DATABASE [CustomerDWH] SET QUERY_STORE = ON
GO
ALTER DATABASE [CustomerDWH] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CustomerDWH]
GO
/****** Object:  Table [dbo].[FactCustomer]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCustomer](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [date] NULL,
	[CountryID_FK] [int] NULL,
	[StateID_FK] [int] NULL,
	[ProductID_FK] [int] NULL,
	[SalesPersonID_FK] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_FactCustomer]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[V_FactCustomer]
AS
SELECT 
	RowNumber AS [Idx],
	CustomerCode AS [Code],
	CustomerName AS [Name],
	CustomerAmount [Amount]
FROM dbo.FactCustomer
GO
/****** Object:  Table [dbo].[DimCountry]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCountry](
	[CountryID] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[IsNew] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDate]    Script Date: 9/25/2024 5:56:03 PM ******/
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
/****** Object:  Table [dbo].[DimProduct]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProduct](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[Ef_Date] [datetime] NULL,
	[Ex_Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSalesPerson]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSalesPerson](
	[SalesPersonID] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SalesPersonBossID_FK] [int] NULL,
 CONSTRAINT [PK_DimSalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimState]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimState](
	[StateID] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[CountryID] [int] NOT NULL,
 CONSTRAINT [PK_DimState] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCustomerTemp]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCustomerTemp](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogExec]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogExec](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [uniqueidentifier] NOT NULL,
	[RunTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PackageId] ASC,
	[RunTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogPackages]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogPackages](
	[PackageId] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProfilingData]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProfilingData](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Email Address] [nvarchar](250) NULL,
	[D O B] [date] NULL,
	[Salary] [bigint] NULL,
	[CountryCode] [nvarchar](250) NULL,
	[EMP Code] [nvarchar](250) NULL,
	[Dept Code] [nvarchar](250) NULL,
	[Country] [nvarchar](250) NULL,
	[CountryTaxCode] [nvarchar](250) NULL,
	[TaxPercentage] [float] NULL,
	[Pan card] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[RowNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RunLog]    Script Date: 9/25/2024 5:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RunLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[PackageID] [uniqueidentifier] NOT NULL,
	[RunTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LogPackages] ADD  DEFAULT (newid()) FOR [PackageId]
GO
ALTER TABLE [dbo].[LogPackages] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[LogPackages] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimSalesPerson] FOREIGN KEY([SalesPersonID_FK])
REFERENCES [dbo].[DimSalesPerson] ([SalesPersonID])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimSalesPerson]
GO
ALTER TABLE [dbo].[FactCustomer]  WITH NOCHECK ADD  CONSTRAINT [FK_FactCustomer_DimState] FOREIGN KEY([StateID_FK])
REFERENCES [dbo].[DimState] ([StateID])
GO
ALTER TABLE [dbo].[FactCustomer] CHECK CONSTRAINT [FK_FactCustomer_DimState]
GO
ALTER TABLE [dbo].[LogExec]  WITH CHECK ADD  CONSTRAINT [FK_ExecLog_PackageId] FOREIGN KEY([PackageId])
REFERENCES [dbo].[LogPackages] ([PackageId])
GO
ALTER TABLE [dbo].[LogExec] CHECK CONSTRAINT [FK_ExecLog_PackageId]
GO
USE [master]
GO
ALTER DATABASE [CustomerDWH] SET  READ_WRITE 
GO
