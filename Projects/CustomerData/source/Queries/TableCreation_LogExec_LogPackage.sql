
/*

GO
 
/****** Object:  Table [dbo].[RunLog]    Script Date: 05/08/2024 5:04:18 PM ******/
SET ANSI_NULLS ON
GO
 
SET QUOTED_IDENTIFIER ON
GO
 
CREATE TABLE [dbo].[RunLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[PackageID] UNIQUEIDENTIFIER NOT NULL,
	[RunTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
*/
USE [CustomerDWH];
CREATE TABLE [dbo].[LogPackages] (
	PackageId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
	PackageName NVARCHAR(255) NOT NULL,
	CreatedDate DATETIME DEFAULT GETDATE(),
	IsActive BIT DEFAULT 1
	);
 
INSERT INTO LogPackages (
	PackageId,
	PackageName
	)
VALUES (
	NEWID(),
	'ETL_Dim_Country'
	),
	(
	NEWID(),
	'ETL_Dim_Product'
	),
	(
	NEWID(),
	'ETL_Dim_SalesPerson'
	),
	(
	NEWID(),
	'ETL_Dim_State'
	),
	(
	NEWID(),
	'ETL_Fact_Customer'
	),
	(
	NEWID(),
	'Export_FactCustomer_Summary'
	),
	(
	NEWID(),
	'Master_ETL'
	),
	(
	NEWID(),
	'Split'
	)
	;
 
SELECT * FROM LogPackages
 
CREATE TABLE [dbo].[LogExec] (
	LogId INT IDENTITY(1, 1) PRIMARY KEY,
	PackageId UNIQUEIDENTIFIER NOT NULL,
	RunTime DATETIME NOT NULL,
	UNIQUE (
		PackageId,
		RunTime
		),
	CONSTRAINT FK_ExecLog_PackageId FOREIGN KEY (PackageId) REFERENCES [dbo].[LogPackages](PackageId)
	);
 
SELECT MAX(RunTime) FROM [dbo].[LogExec] WHERE PackageId = (SELECT PackageId FROM [dbo].[LogPackages] WHERE PackageName = 'Master_ETL')
 
/*
INSERT INTO LogExec (PackageId, RunTime)
SELECT PackageId, GETDATE()
FROM LogPackages
WHERE PackageName = 'MIGRATION_RIITA_to_360L';

TRUNCATE TABLE LogExec
*/