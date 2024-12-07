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
