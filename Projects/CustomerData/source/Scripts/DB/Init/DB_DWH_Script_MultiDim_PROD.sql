USE [master]
GO
/****** Object:  Database [CustomerDWH]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE DATABASE [CustomerDWH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CustomerDWH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL01P\MSSQL\DATA\CustomerDWH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CustomerDWH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQL01P\MSSQL\DATA\CustomerDWH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
/****** Object:  User [cdc]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE USER [cdc] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[cdc]
GO
ALTER ROLE [db_owner] ADD MEMBER [cdc]
GO
/****** Object:  Schema [cdc]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [cdc]
GO
/****** Object:  Schema [dwh]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [dwh]
GO
/****** Object:  Schema [log]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [log]
GO
/****** Object:  Schema [mdm]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [mdm]
GO
/****** Object:  Schema [rep]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [rep]
GO
/****** Object:  Schema [stg]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [stg]
GO
/****** Object:  Schema [tech]    Script Date: 12/7/2024 7:06:00 PM ******/
CREATE SCHEMA [tech]
GO
/****** Object:  Table [dwh].[Tf_Customer]    Script Date: 12/7/2024 7:06:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[Tf_Customer](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDateID_FK] [int] NULL,
	[CountryID_FK] [int] NULL,
	[StateID_FK] [int] NULL,
	[ProductID_FK] [int] NULL,
	[SalesPersonID_FK] [int] NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [rep].[V_Tf_Customer]    Script Date: 12/7/2024 7:06:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [rep].[V_Tf_Customer]
AS
SELECT 
	RowNumber AS [Idx],
	CustomerCode AS [Code],
	CustomerName AS [Name],
	CustomerAmount [Amount]
FROM dwh.Tf_Customer
GO
/****** Object:  Table [stg].[Td_Country]    Script Date: 12/7/2024 7:06:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Td_Country](
	[CountryID] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dwh].[V_Td_Country]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dwh].[V_Td_Country]
AS
SELECT 
	[CountryID],
	REPLACE(LTRIM(RTRIM(CountryName)), '  ', ' ') AS [CountryName]
FROM [stg].[Td_Country]
WHERE LEN(LTRIM(RTRIM(CountryName))) > 0;

GO
/****** Object:  UserDefinedFunction [cdc].[fn_cdc_get_all_changes_dwh_Tf_Customer]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	create function [cdc].[fn_cdc_get_all_changes_dwh_Tf_Customer]
	(	@from_lsn binary(10),
		@to_lsn binary(10),
		@row_filter_option nvarchar(30)
	)
	returns table
	return
	
	select NULL as __$start_lsn,
		NULL as __$seqval,
		NULL as __$operation,
		NULL as __$update_mask, NULL as [RowNumber], NULL as [CustomerCode], NULL as [CustomerName], NULL as [CustomerAmount], NULL as [SalesDateID_FK], NULL as [CountryID_FK], NULL as [StateID_FK], NULL as [ProductID_FK], NULL as [SalesPersonID_FK], NULL as [SourceID], NULL as [CreatedBy], NULL as [ModifiedBy], NULL as [CreatedDate]
	where ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 0) = 0)

	union all
	
	select t.__$start_lsn as __$start_lsn,
		t.__$seqval as __$seqval,
		t.__$operation as __$operation,
		t.__$update_mask as __$update_mask, t.[RowNumber], t.[CustomerCode], t.[CustomerName], t.[CustomerAmount], t.[SalesDateID_FK], t.[CountryID_FK], t.[StateID_FK], t.[ProductID_FK], t.[SalesPersonID_FK], t.[SourceID], t.[CreatedBy], t.[ModifiedBy], t.[CreatedDate]
	from [cdc].[dwh_Tf_Customer_CT] t with (nolock)    
	where (lower(rtrim(ltrim(@row_filter_option))) = 'all')
	    and ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 0) = 1)
		and (t.__$operation = 1 or t.__$operation = 2 or t.__$operation = 4)
		and (t.__$start_lsn <= @to_lsn)
		and (t.__$start_lsn >= @from_lsn)
		
	union all	
		
	select t.__$start_lsn as __$start_lsn,
		t.__$seqval as __$seqval,
		t.__$operation as __$operation,
		t.__$update_mask as __$update_mask, t.[RowNumber], t.[CustomerCode], t.[CustomerName], t.[CustomerAmount], t.[SalesDateID_FK], t.[CountryID_FK], t.[StateID_FK], t.[ProductID_FK], t.[SalesPersonID_FK], t.[SourceID], t.[CreatedBy], t.[ModifiedBy], t.[CreatedDate]
	from [cdc].[dwh_Tf_Customer_CT] t with (nolock)     
	where (lower(rtrim(ltrim(@row_filter_option))) = 'all update old')
	    and ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 0) = 1)
		and (t.__$operation = 1 or t.__$operation = 2 or t.__$operation = 4 or
		     t.__$operation = 3 )
		and (t.__$start_lsn <= @to_lsn)
		and (t.__$start_lsn >= @from_lsn)
	
GO
/****** Object:  UserDefinedFunction [cdc].[fn_cdc_get_net_changes_dwh_Tf_Customer]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	create function [cdc].[fn_cdc_get_net_changes_dwh_Tf_Customer]
	(	@from_lsn binary(10),
		@to_lsn binary(10),
		@row_filter_option nvarchar(30)
	)
	returns table
	return

	select NULL as __$start_lsn,
		NULL as __$operation,
		NULL as __$update_mask, NULL as [RowNumber], NULL as [CustomerCode], NULL as [CustomerName], NULL as [CustomerAmount], NULL as [SalesDateID_FK], NULL as [CountryID_FK], NULL as [StateID_FK], NULL as [ProductID_FK], NULL as [SalesPersonID_FK], NULL as [SourceID], NULL as [CreatedBy], NULL as [ModifiedBy], NULL as [CreatedDate]
	where ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 1) = 0)

	union all
	
	select __$start_lsn,
	    case __$count_38B7FC9A
	    when 1 then __$operation
	    else
			case __$min_op_38B7FC9A 
				when 2 then 2
				when 4 then
				case __$operation
					when 1 then 1
					else 4
					end
				else
				case __$operation
					when 2 then 4
					when 4 then 4
					else 1
					end
			end
		end as __$operation,
		null as __$update_mask , [RowNumber], [CustomerCode], [CustomerName], [CustomerAmount], [SalesDateID_FK], [CountryID_FK], [StateID_FK], [ProductID_FK], [SalesPersonID_FK], [SourceID], [CreatedBy], [ModifiedBy], [CreatedDate]
	from
	(
		select t.__$start_lsn as __$start_lsn, __$operation,
		case __$count_38B7FC9A 
		when 1 then __$operation 
		else
		(	select top 1 c.__$operation
			from [cdc].[dwh_Tf_Customer_CT] c with (nolock)   
			where  ( (c.[CustomerCode] = t.[CustomerCode]) )  
			and ((c.__$operation = 2) or (c.__$operation = 4) or (c.__$operation = 1))
			and (c.__$start_lsn <= @to_lsn)
			and (c.__$start_lsn >= @from_lsn)
			order by c.__$start_lsn, c.__$command_id, c.__$seqval) end __$min_op_38B7FC9A, __$count_38B7FC9A, t.[RowNumber], t.[CustomerCode], t.[CustomerName], t.[CustomerAmount], t.[SalesDateID_FK], t.[CountryID_FK], t.[StateID_FK], t.[ProductID_FK], t.[SalesPersonID_FK], t.[SourceID], t.[CreatedBy], t.[ModifiedBy], t.[CreatedDate] 
		from [cdc].[dwh_Tf_Customer_CT] t with (nolock) inner join 
		(	select  r.[CustomerCode],
		    count(*) as __$count_38B7FC9A 
			from [cdc].[dwh_Tf_Customer_CT] r with (nolock)
			where  (r.__$start_lsn <= @to_lsn)
			and (r.__$start_lsn >= @from_lsn)
			group by   r.[CustomerCode]) m
		on t.__$seqval = ( select top 1 c.__$seqval from [cdc].[dwh_Tf_Customer_CT] c with (nolock) where  ( (c.[CustomerCode] = t.[CustomerCode]) )  and c.__$start_lsn <= @to_lsn and c.__$start_lsn >= @from_lsn order by c.__$start_lsn desc, c.__$command_id desc, c.__$seqval desc ) and
		    ( (t.[CustomerCode] = m.[CustomerCode]) ) 	
		where lower(rtrim(ltrim(@row_filter_option))) = N'all'
			and ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 1) = 1)
			and (t.__$start_lsn <= @to_lsn)
			and (t.__$start_lsn >= @from_lsn)
			and ((t.__$operation = 2) or (t.__$operation = 4) or 
				 ((t.__$operation = 1) and
				  (2 not in 
				 		(	select top 1 c.__$operation
							from [cdc].[dwh_Tf_Customer_CT] c with (nolock) 
							where  ( (c.[CustomerCode] = t.[CustomerCode]) )  
							and ((c.__$operation = 2) or (c.__$operation = 4) or (c.__$operation = 1))
							and (c.__$start_lsn <= @to_lsn)
							and (c.__$start_lsn >= @from_lsn)
							order by c.__$start_lsn, c.__$command_id, c.__$seqval
						 ) 
	 			   )
	 			 )
	 			) 
			and t.__$operation = (
				select
					max(mo.__$operation)
				from
					[cdc].[dwh_Tf_Customer_CT] as mo with (nolock)
				where
					mo.__$seqval = t.__$seqval
					and 
					 ( (t.[CustomerCode] = mo.[CustomerCode]) ) 
				group by
					mo.__$seqval
			)	
	) Q
	
	union all
	
	select __$start_lsn,
	    case __$count_38B7FC9A
	    when 1 then __$operation
	    else
			case __$min_op_38B7FC9A 
				when 2 then 2
				when 4 then
				case __$operation
					when 1 then 1
					else 4
					end
				else
				case __$operation
					when 2 then 4
					when 4 then 4
					else 1
					end
			end
		end as __$operation,
		case __$count_38B7FC9A
		when 1 then
			case __$operation
			when 4 then __$update_mask
			else null
			end
		else	
			case __$min_op_38B7FC9A 
			when 2 then null
			else
				case __$operation
				when 1 then null
				else __$update_mask 
				end
			end	
		end as __$update_mask , [RowNumber], [CustomerCode], [CustomerName], [CustomerAmount], [SalesDateID_FK], [CountryID_FK], [StateID_FK], [ProductID_FK], [SalesPersonID_FK], [SourceID], [CreatedBy], [ModifiedBy], [CreatedDate]
	from
	(
		select t.__$start_lsn as __$start_lsn, __$operation,
		case __$count_38B7FC9A 
		when 1 then __$operation 
		else
		(	select top 1 c.__$operation
			from [cdc].[dwh_Tf_Customer_CT] c with (nolock)
			where  ( (c.[CustomerCode] = t.[CustomerCode]) )  
			and ((c.__$operation = 2) or (c.__$operation = 4) or (c.__$operation = 1))
			and (c.__$start_lsn <= @to_lsn)
			and (c.__$start_lsn >= @from_lsn)
			order by c.__$start_lsn, c.__$command_id, c.__$seqval) end __$min_op_38B7FC9A, __$count_38B7FC9A, 
		m.__$update_mask , t.[RowNumber], t.[CustomerCode], t.[CustomerName], t.[CustomerAmount], t.[SalesDateID_FK], t.[CountryID_FK], t.[StateID_FK], t.[ProductID_FK], t.[SalesPersonID_FK], t.[SourceID], t.[CreatedBy], t.[ModifiedBy], t.[CreatedDate]
		from [cdc].[dwh_Tf_Customer_CT] t with (nolock) inner join 
		(	select  r.[CustomerCode],
		    count(*) as __$count_38B7FC9A, 
		    CAST(NULL AS varbinary(128)) as __$update_mask
			from [cdc].[dwh_Tf_Customer_CT] r with (nolock)
			where  (r.__$start_lsn <= @to_lsn)
			and (r.__$start_lsn >= @from_lsn)
			group by   r.[CustomerCode]) m
		on t.__$seqval = ( select top 1 c.__$seqval from [cdc].[dwh_Tf_Customer_CT] c with (nolock) where  ( (c.[CustomerCode] = t.[CustomerCode]) )  and c.__$start_lsn <= @to_lsn and c.__$start_lsn >= @from_lsn order by c.__$start_lsn desc, c.__$command_id desc, c.__$seqval desc ) and
		    ( (t.[CustomerCode] = m.[CustomerCode]) ) 	
		where lower(rtrim(ltrim(@row_filter_option))) = N'all with mask'
			and ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 1) = 1)
			and (t.__$start_lsn <= @to_lsn)
			and (t.__$start_lsn >= @from_lsn)
			and ((t.__$operation = 2) or (t.__$operation = 4) or 
				 ((t.__$operation = 1) and
				  (2 not in 
				 		(	select top 1 c.__$operation
							from [cdc].[dwh_Tf_Customer_CT] c with (nolock)
							where  ( (c.[CustomerCode] = t.[CustomerCode]) )  
							and ((c.__$operation = 2) or (c.__$operation = 4) or (c.__$operation = 1))
							and (c.__$start_lsn <= @to_lsn)
							and (c.__$start_lsn >= @from_lsn)
							order by c.__$start_lsn, c.__$command_id, c.__$seqval
						 ) 
	 			   )
	 			 )
	 			) 
			and t.__$operation = (
				select
					max(mo.__$operation)
				from
					[cdc].[dwh_Tf_Customer_CT] as mo with (nolock)
				where
					mo.__$seqval = t.__$seqval
					and 
					 ( (t.[CustomerCode] = mo.[CustomerCode]) ) 
				group by
					mo.__$seqval
			)	
	) Q
	
	union all
	
		select t.__$start_lsn as __$start_lsn,
		case t.__$operation
			when 1 then 1
			else 5
		end as __$operation,
		null as __$update_mask , t.[RowNumber], t.[CustomerCode], t.[CustomerName], t.[CustomerAmount], t.[SalesDateID_FK], t.[CountryID_FK], t.[StateID_FK], t.[ProductID_FK], t.[SalesPersonID_FK], t.[SourceID], t.[CreatedBy], t.[ModifiedBy], t.[CreatedDate]
		from [cdc].[dwh_Tf_Customer_CT] t  with (nolock)
		where lower(rtrim(ltrim(@row_filter_option))) = N'all with merge'
			and ( [sys].[fn_cdc_check_parameters]( N'dwh_Tf_Customer', @from_lsn, @to_lsn, lower(rtrim(ltrim(@row_filter_option))), 1) = 1)
			and (t.__$start_lsn <= @to_lsn)
			and (t.__$start_lsn >= @from_lsn)
			and (t.__$seqval = ( select top 1 c.__$seqval from [cdc].[dwh_Tf_Customer_CT] c with (nolock) where  ( (c.[CustomerCode] = t.[CustomerCode]) )  and c.__$start_lsn <= @to_lsn and c.__$start_lsn >= @from_lsn order by c.__$start_lsn desc, c.__$command_id desc, c.__$seqval desc ))
			and ((t.__$operation = 2) or (t.__$operation = 4) or 
				 ((t.__$operation = 1) and 
				   (2 not in 
				 		(	select top 1 c.__$operation
							from [cdc].[dwh_Tf_Customer_CT] c with (nolock)
							where  ( (c.[CustomerCode] = t.[CustomerCode]) )  
							and ((c.__$operation = 2) or (c.__$operation = 4) or (c.__$operation = 1))
							and (c.__$start_lsn <= @to_lsn)
							and (c.__$start_lsn >= @from_lsn)
							order by c.__$start_lsn, c.__$command_id, c.__$seqval
						 ) 
	 				)
	 			 )
	 			)
			and t.__$operation = (
				select
					max(mo.__$operation)
				from
					[cdc].[dwh_Tf_Customer_CT] as mo with (nolock)
				where
					mo.__$seqval = t.__$seqval
					and 
					 ( (t.[CustomerCode] = mo.[CustomerCode]) ) 
				group by
					mo.__$seqval
			)
	 
GO
/****** Object:  Table [dwh].[Td_Country]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[Td_Country](
	[CountryID] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
	[IsNew] [bit] NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[Td_Period]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[Td_Period](
	[date_key] [int] NOT NULL,
	[date] [date] NOT NULL,
	[weekday] [varchar](9) NOT NULL,
	[weekday_num] [int] NOT NULL,
	[day_month] [int] NOT NULL,
	[day_of_year] [int] NOT NULL,
	[weekend_indr] [varchar](10) NOT NULL,
	[week_of_year] [int] NOT NULL,
	[iso_week] [varchar](10) NOT NULL,
	[week_id] [int] NOT NULL,
	[week_desc] [varchar](10) NOT NULL,
	[month_num] [int] NOT NULL,
	[month_name] [varchar](20) NOT NULL,
	[month_name_short] [char](3) NOT NULL,
	[month_id] [int] NOT NULL,
	[month_desc] [varchar](20) NOT NULL,
	[first_day_of_month] [date] NOT NULL,
	[last_day_of_month] [date] NOT NULL,
	[yyyymm] [char](7) NOT NULL,
	[quarter] [int] NOT NULL,
	[quarter_id] [int] NOT NULL,
	[quarter_desc] [varchar](10) NOT NULL,
	[quarter_cd] [varchar](10) NOT NULL,
	[semester_id] [int] NOT NULL,
	[semester_desc] [varchar](10) NOT NULL,
	[semester_cd] [varchar](10) NOT NULL,
	[year] [int] NOT NULL,
	[year_id] [int] NOT NULL,
	[year_desc] [varchar](10) NOT NULL,
	[year_cd] [varchar](10) NOT NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[Td_Product]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[Td_Product](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[Ef_Date] [datetime] NULL,
	[Ex_Date] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[Td_SalesPerson]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[Td_SalesPerson](
	[SalesPersonID] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SalesPersonBossID_FK] [int] NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_DimSalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[Td_State]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[Td_State](
	[StateID] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[CountryID] [int] NOT NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_DimState] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [log].[ProfilingData]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[ProfilingData](
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
/****** Object:  Table [log].[Tl_BusinessWarnings]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[Tl_BusinessWarnings](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[WarningID] [int] NOT NULL,
	[SourceID] [nvarchar](255) NOT NULL,
	[SourceContext] [nvarchar](255) NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[Severity] [nvarchar](50) NOT NULL,
	[MessageDetails] [nvarchar](1000) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [log].[Tl_Exec]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[Tl_Exec](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[PackageId] [uniqueidentifier] NOT NULL,
	[RunTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Tl_Exec] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [log].[Tl_Packages]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[Tl_Packages](
	[PackageId] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Tl_Packages] PRIMARY KEY CLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [log].[Tl_WarningDetails]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [log].[Tl_WarningDetails](
	[WarningID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[MessageTemplate] [nvarchar](1000) NOT NULL,
	[Category] [nvarchar](255) NOT NULL,
	[DefaultSeverity] [nvarchar](50) NOT NULL,
	[ActionRequired] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WarningID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [mdm].[Tm_Geo]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [mdm].[Tm_Geo](
	[CountryName] [nvarchar](255) NOT NULL,
	[ISO2Code] [nvarchar](2) NOT NULL,
	[CountryID] [nvarchar](3) NOT NULL,
	[CountryCode] [nvarchar](3) NULL,
	[ISO3166_2] [nvarchar](50) NULL,
	[RegionName] [nvarchar](100) NULL,
	[SubRegionName] [nvarchar](100) NULL,
	[IntermediateRegionName] [nvarchar](100) NULL,
	[RegionCode] [nvarchar](3) NULL,
	[SubRegionCode] [nvarchar](3) NULL,
	[IntermediateRegionCode] [nvarchar](3) NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[Td_Product]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Td_Product](
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[Td_SalesPerson]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Td_SalesPerson](
	[SalesPersonID] [int] NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SalesPersonBossID] [int] NOT NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_DimSalesPerson] PRIMARY KEY CLUSTERED 
(
	[SalesPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[Td_State]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Td_State](
	[StateID] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[CountryID] [int] NOT NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_DimState] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[Tf_Customer]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[Tf_Customer](
	[RowNumber] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [int] NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAmount] [money] NULL,
	[SalesDate] [date] NULL,
	[ContryName] [nvarchar](50) NULL,
	[StateName] [nvarchar](50) NULL,
	[ProductName] [nvarchar](50) NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SourceID] [nvarchar](255) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_BusinessWarnings_CreatedDate]    Script Date: 12/7/2024 7:06:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_BusinessWarnings_CreatedDate] ON [log].[Tl_BusinessWarnings]
(
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_BusinessWarnings_Severity]    Script Date: 12/7/2024 7:06:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_BusinessWarnings_Severity] ON [log].[Tl_BusinessWarnings]
(
	[Severity] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_BusinessWarnings_SourceContext]    Script Date: 12/7/2024 7:06:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_BusinessWarnings_SourceContext] ON [log].[Tl_BusinessWarnings]
(
	[SourceContext] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Tl_Exec_PackageId_RunTime]    Script Date: 12/7/2024 7:06:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tl_Exec_PackageId_RunTime] ON [log].[Tl_Exec]
(
	[PackageId] ASC,
	[RunTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Tl_Packages_PackageName]    Script Date: 12/7/2024 7:06:01 PM ******/
CREATE NONCLUSTERED INDEX [IX_Tl_Packages_PackageName] ON [log].[Tl_Packages]
(
	[PackageName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dwh].[Td_Country] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dwh].[Td_Period] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dwh].[Td_SalesPerson] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dwh].[Td_State] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dwh].[Tf_Customer] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [log].[Tl_BusinessWarnings] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [log].[Tl_Packages] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [mdm].[Tm_Geo] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [stg].[Td_Country] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [stg].[Td_Product] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [stg].[Td_SalesPerson] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [stg].[Td_State] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [stg].[Tf_Customer] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dwh].[Tf_Customer]  WITH NOCHECK ADD  CONSTRAINT [FK_Tf_Customer_Td_Period] FOREIGN KEY([SalesDateID_FK])
REFERENCES [dwh].[Td_Period] ([date_key])
GO
ALTER TABLE [dwh].[Tf_Customer] CHECK CONSTRAINT [FK_Tf_Customer_Td_Period]
GO
ALTER TABLE [dwh].[Tf_Customer]  WITH NOCHECK ADD  CONSTRAINT [FK_Tf_Customer_Td_SalesPerson] FOREIGN KEY([SalesPersonID_FK])
REFERENCES [dwh].[Td_SalesPerson] ([SalesPersonID])
GO
ALTER TABLE [dwh].[Tf_Customer] CHECK CONSTRAINT [FK_Tf_Customer_Td_SalesPerson]
GO
ALTER TABLE [dwh].[Tf_Customer]  WITH NOCHECK ADD  CONSTRAINT [FK_Tf_Customer_Td_State] FOREIGN KEY([StateID_FK])
REFERENCES [dwh].[Td_State] ([StateID])
GO
ALTER TABLE [dwh].[Tf_Customer] CHECK CONSTRAINT [FK_Tf_Customer_Td_State]
GO
ALTER TABLE [log].[Tl_BusinessWarnings]  WITH CHECK ADD  CONSTRAINT [FK_BusinessWarnings_WarningDetails] FOREIGN KEY([WarningID])
REFERENCES [log].[Tl_WarningDetails] ([WarningID])
ON DELETE CASCADE
GO
ALTER TABLE [log].[Tl_BusinessWarnings] CHECK CONSTRAINT [FK_BusinessWarnings_WarningDetails]
GO
ALTER TABLE [log].[Tl_Exec]  WITH CHECK ADD  CONSTRAINT [FK_Tl_Exec_PackageId] FOREIGN KEY([PackageId])
REFERENCES [log].[Tl_Packages] ([PackageId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [log].[Tl_Exec] CHECK CONSTRAINT [FK_Tl_Exec_PackageId]
GO
/****** Object:  StoredProcedure [dbo].[cdc_RetainHistory]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   <>
-- =============================================
CREATE PROCEDURE [dbo].[cdc_RetainHistory]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO dbo.Tf_Customer_History
	SELECT *
	FROM [cdc].[dwh_FactCustomer_CT]
	WHERE __$start_lsn > (SELECT ISNULL(MAX(__$start_lsn), 0) FROM dwh.Tf_Customer_History);
END
GO
/****** Object:  StoredProcedure [dwh].[usp_Load_Td_Period]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
/****** Object:  StoredProcedure [dwh].[usp_Select_CustomerInfoFull]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dwh].[usp_Select_CustomerInfoFull]
	-- Add the parameters for the stored procedure here
	@InputCustomerCodes NVARCHAR(MAX) = '1002',
	@InputCustomerObsolete VARCHAR(1) = 'N'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Create a temporary table to store the filtered customer data
    IF OBJECT_ID('tempdb..#CustomerFull') IS NOT NULL
        DROP TABLE #CustomerFull;

    CREATE TABLE #CustomerFull (
        RowNumber INT,
        CustomerCode NVARCHAR(50),
        CustomerName NVARCHAR(255),
        CustomerAmount DECIMAL(18, 2),
        CountryName NVARCHAR(255),
        month_name NVARCHAR(255),
        weekday NVARCHAR(255),
        ProductName NVARCHAR(255),
        SalesPersonName NVARCHAR(255),
        StateName NVARCHAR(255)
    );

    -- Insert filtered data into the temporary table
    INSERT INTO #CustomerFull
    SELECT 
        Tf_C.[RowNumber],
        Tf_C.[CustomerCode],
        Tf_C.[CustomerName],
        Tf_C.[CustomerAmount],
        Td_C.[CountryName],
        Td_D.[month_name],
        Td_D.[weekday],
        Td_P.[ProductName],
        Td_S.[SalesPersonName],
        Td_St.[StateName]
    FROM [CustomerDWH].[dwh].[Tf_Customer] Tf_C
    JOIN [CustomerDWH].[dwh].[Td_Country] AS Td_C ON Tf_C.CountryID_FK = Td_C.CountryID
    JOIN [CustomerDWH].[dwh].[Td_Period] AS Td_D ON Td_D.[date_key] = Tf_C.SalesDateID_FK
    JOIN [CustomerDWH].[dwh].[Td_Product] AS Td_P ON Tf_C.ProductID_FK = Td_P.ProductID
    JOIN [CustomerDWH].[dwh].[Td_SalesPerson] AS Td_S ON Tf_C.SalesPersonID_FK = Td_S.SalesPersonID
    JOIN [CustomerDWH].[dwh].[Td_State] AS Td_St ON Tf_C.StateID_FK = Td_St.StateID
    WHERE Tf_C.CustomerCode IN (SELECT TRIM(value) FROM STRING_SPLIT(@InputCustomerCodes, ','));

    -- Select data from the temporary table for return
    SELECT * FROM #CustomerFull;

    -- Update CustomerAmount to 0 if obsolete flag is 'Y'
    IF UPPER(@InputCustomerObsolete) = 'Y'
    BEGIN
        UPDATE Tf_C
        SET CustomerAmount = 0
        FROM [CustomerDWH].[dwh].[Tf_Customer] Tf_C
        INNER JOIN #CustomerFull CF ON Tf_C.CustomerCode = CF.CustomerCode;
    END
END
GO
/****** Object:  StoredProcedure [mdm].[usp_Update_Geo]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [mdm].[usp_Update_Geo] 
	@CountryName NVARCHAR(255),
	@ISO2Code NVARCHAR(2),
	@CountryID NVARCHAR(3),
	@CountryCode NVARCHAR(3),
	@ISO3166_2 NVARCHAR(50),
	@RegionName NVARCHAR(100),
	@SubRegionName NVARCHAR(100),
	@IntermediateRegionName NVARCHAR(100),
	@RegionCode NVARCHAR(3),
	@SubRegionCode NVARCHAR(3),
	@IntermediateRegionCode NVARCHAR(3),
	@SourceID NVARCHAR(255),
	@CreatedBy UNIQUEIDENTIFIER,
	@ModifiedBy UNIQUEIDENTIFIER,
	@CreatedDate DATETIME
AS
BEGIN
	UPDATE [mdm].[Tm_Geo]
	SET 
		[CountryName] = @CountryName,
		[ISO2Code] = @ISO2Code,
		[CountryCode] = @CountryCode,
		[ISO3166_2] = @ISO3166_2,
		[RegionName] = @RegionName,
		[SubRegionName] = @SubRegionName,
		[IntermediateRegionName] = @IntermediateRegionName,
		[RegionCode] = @RegionCode,
		[SubRegionCode] = @SubRegionCode,
		[IntermediateRegionCode] = @IntermediateRegionCode,
		[SourceID] = @SourceID,
		[CreatedBy] = @CreatedBy,
		[ModifiedBy] = @ModifiedBy,
		[CreatedDate] = @CreatedDate
	WHERE [CountryID] = @CountryID
END

GO
/****** Object:  StoredProcedure [tech].[usp_LogRowMetadata]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   Logs row-level metadata for creation and updates
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
/****** Object:  StoredProcedure [tech].[usp_LogWarningDynamic]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   Logs row-level metadata for creation and updates
-- =============================================
CREATE PROCEDURE [tech].[usp_LogWarningDynamic]
    @WarningID INT,
    @SourceID NVARCHAR(255),
    @SourceContext NVARCHAR(255),
    @CreatedBy UNIQUEIDENTIFIER,
    @DynamicParams NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @MessageTemplate NVARCHAR(1000);
    DECLARE @FinalMessage NVARCHAR(MAX);
    DECLARE @DefaultSeverity NVARCHAR(50);
    DECLARE @DynamicDetails NVARCHAR(MAX);

    -- Validate WarningID
    IF NOT EXISTS (SELECT 1 FROM [log].[Tl_WarningDetails] WHERE WarningID = @WarningID)
    BEGIN
        RAISERROR ('Invalid WarningID provided.', 16, 1);
        RETURN;
    END;

    -- Retrieve MessageTemplate and DefaultSeverity
    SELECT 
        @MessageTemplate = MessageTemplate,
        @DefaultSeverity = DefaultSeverity
    FROM [log].[Tl_WarningDetails]
    WHERE WarningID = @WarningID;

    -- Parse JSON into a table variable
    DECLARE @ParamTable TABLE ([Key] NVARCHAR(255), [Value] NVARCHAR(255));
    INSERT INTO @ParamTable ([Key], [Value])
    SELECT [Key], [Value]
    FROM OPENJSON(@DynamicParams)
    WITH ([Key] NVARCHAR(255) '$.Key', [Value] NVARCHAR(255) '$.Value');

    -- Construct the dynamic details string from all key-value pairs, excluding ErrorCode and ErrorColumn
    DECLARE @RowDetails NVARCHAR(MAX) = '';
    SELECT @RowDetails = @RowDetails + [Key] + ': ' + ISNULL([Value], 'NULL') + CHAR(13) + CHAR(10)
    FROM @ParamTable
    WHERE [Key] NOT IN ('ErrorCode', 'ErrorColumn'); -- Exclude ErrorCode and ErrorColumn

    -- Remove trailing newlines
    SET @RowDetails = LEFT(@RowDetails, LEN(@RowDetails) - 2);
    SET @FinalMessage = REPLACE(@MessageTemplate, '{DynamicDetails}', @RowDetails);

    -- Replace placeholders in the template for other keys
    SELECT @FinalMessage = REPLACE(@FinalMessage, '{' + [Key] + '}', ISNULL([Value], 'Unknown'))
    FROM @ParamTable;

    -- Insert the warning into the log table
    INSERT INTO [log].[Tl_BusinessWarnings] 
        (WarningID, SourceID, SourceContext, CreatedBy, CreatedDate, Severity, MessageDetails)
    VALUES 
        (@WarningID, @SourceID, @SourceContext, @CreatedBy, GETDATE(), @DefaultSeverity, @FinalMessage);

    PRINT 'Warning successfully logged.';
END;
GO
/****** Object:  StoredProcedure [tech].[usp_PopulateWarningDetails]    Script Date: 12/7/2024 7:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        HMDVHB
-- Create date:   12/01/2024
-- Description:   <>
-- =============================================
CREATE PROCEDURE [tech].[usp_PopulateWarningDetails]
    @WarningID INT = NULL,             -- Optional WarningID to uniquely identify the warning
    @Title NVARCHAR(255) = NULL,       -- Title for the warning
    @MessageTemplate NVARCHAR(1000) = NULL, -- Template for the warning message
    @Category NVARCHAR(255) = NULL,    -- Warning category
    @DefaultSeverity NVARCHAR(50) = NULL, -- Default severity level
    @ActionRequired BIT = NULL         -- Flag for action required
AS
BEGIN
    SET NOCOUNT ON;

    -- Variable to store error message
    DECLARE @FailMessage NVARCHAR(4000);

    -- Check if the warning exists based on key columns
    IF EXISTS (
        SELECT 1 
        FROM [log].[Tl_WarningDetails]
        WHERE WarningID = @WarningID
    )
    BEGIN
        PRINT 'Warning already exists. Updating existing entry...';

        -- Update the existing warning details, keeping current values if no new input is provided
        UPDATE [log].[Tl_WarningDetails]
        SET
            Title = COALESCE(@Title, Title),
            MessageTemplate = COALESCE(@MessageTemplate, MessageTemplate),
            Category = COALESCE(@Category, Category),
            DefaultSeverity = COALESCE(@DefaultSeverity, DefaultSeverity),
            ActionRequired = COALESCE(@ActionRequired, ActionRequired)
        WHERE WarningID = @WarningID;

        PRINT 'Warning details updated successfully.';
    END
    ELSE IF @WarningID IS NOT NULL
    BEGIN
        -- Raise an error if WarningID is provided but not found
        SET @FailMessage = 'WarningID not found in table.';
        RAISERROR (@FailMessage, 16, 1);
    END
    ELSE
    BEGIN
        PRINT 'Adding a new warning entry...';

        -- Insert a new warning if it doesn't exist
        INSERT INTO [log].[Tl_WarningDetails] (Title, MessageTemplate, Category, DefaultSeverity, ActionRequired)
        VALUES (@Title, @MessageTemplate, @Category, @DefaultSeverity, @ActionRequired);

        PRINT 'New warning added successfully.';
    END
END;
GO
/****** Object:  StoredProcedure [tech].[usp_TruncateTable]    Script Date: 12/7/2024 7:06:01 PM ******/
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
GO
USE [master]
GO
ALTER DATABASE [CustomerDWH] SET  READ_WRITE 
GO
