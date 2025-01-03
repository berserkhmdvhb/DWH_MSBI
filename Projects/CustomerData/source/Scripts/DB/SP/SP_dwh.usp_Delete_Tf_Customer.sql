CREATE PROCEDURE [dwh].[usp_Delete_Tf_Customer]
AS
BEGIN
	SET NOCOUNT ON

	DELETE F
	FROM [dwh].[V_Tf_Customer] S
	INNER JOIN [dwh].[Tf_Customer] F ON 
		S.SalesDate = CONVERT(DATE, CAST(F.SalesDateID_FK AS CHAR(8))) 
END