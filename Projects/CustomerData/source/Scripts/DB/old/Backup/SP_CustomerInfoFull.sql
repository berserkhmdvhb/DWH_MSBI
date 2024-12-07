-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
USE [CustomerDWH]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dwh].[usp_Select_CustomerInfoFull]
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
