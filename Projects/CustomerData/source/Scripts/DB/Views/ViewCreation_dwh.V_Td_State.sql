USE [CustomerDWH]
GO

/****** Object:  View [dwh].[V_Td_State]    Script Date: 11/28/2024 1:41:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dwh].[V_Td_State]
AS
SELECT
	[StateID],
	[StateName],
	[CountryID]
FROM [stg].[Td_State]
GO
