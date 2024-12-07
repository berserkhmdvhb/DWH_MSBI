USE [CustomerDWH]
GO
/****** Object:  StoredProcedure [dm].[usp_Update_Account]    Script Date: 12/1/2024 6:17:06 PM ******/
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

