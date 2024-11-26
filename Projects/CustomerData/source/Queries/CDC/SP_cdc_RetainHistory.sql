
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HMDVHB
-- Create date: 26.09.2024
-- Description:	Storing CDC of table [dbo].[FactCustomer] in table [dbo].[FactCustomerHistroy]
-- =============================================
CREATE PROCEDURE [dbo].[cdc_RetainHistory]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    INSERT INTO dbo.FactCustomerHistory
	SELECT *
	FROM [cdc].[dbo_FactCustomer_CT]
	WHERE __$start_lsn > (SELECT ISNULL(MAX(__$start_lsn), 0) FROM dbo.FactCustomerHistory);
END
GO
