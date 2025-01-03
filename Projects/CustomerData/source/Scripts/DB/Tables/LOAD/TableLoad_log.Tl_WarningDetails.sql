USE CustomerDWH;
EXEC [tech].[usp_PopulateWarningDetails]
	@Title = 'Warning - Missing Dimension Key',
    @MessageTemplate = 'Missing dimension key: {KeyValue} for {DimensionName}',
    @Category = 'Data Loss',
    @DefaultSeverity = 'High',
    @ActionRequired = 1;

EXEC [tech].[usp_PopulateWarningDetails]
	@Title = 'Issue - Thershold exceed',
    @MessageTemplate = 'Threshold exceeded: {ColumnName} value {Value} exceeds limit.',
    @Category = 'Business Rule',
    @DefaultSeverity = 'High',
    @ActionRequired = 1;

EXEC [tech].[usp_PopulateWarningDetails]
	@Title = 'Warning - Negative Value',
    @MessageTemplate = 'Negative value detected in {ColumnName} for row {RowIdentifier}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Medium',
    @ActionRequired = 1;

EXEC [tech].[usp_PopulateWarningDetails]
	@Title = 'Issue - Data Conversion Fail',
    @MessageTemplate = 'Data conversion failed for {ColumnName} with value {Value}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Medium',
    @ActionRequired = 1;

EXEC [tech].[usp_PopulateWarningDetails]
	@Title = 'Warning - Missing Value (NULL)',
    @MessageTemplate = 'Null value found in {ColumnName} for row {RowIdentifier}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Low',
    @ActionRequired = 1;


EXEC [tech].[usp_PopulateWarningDetails]
    @Title = 'Issue - Data Retrieval Failed',
    @MessageTemplate = 'Failed to retrieve data from source URL',
    @Category = 'Data Scraping',
    @DefaultSeverity = 'High',
    @ActionRequired = 1;

EXEC [tech].[usp_PopulateWarningDetails]
    @Title = 'Issue - MDM Geo file missing',
    @MessageTemplate = 'File {FileName} is not generated',
    @Category = 'Data Scraping',
    @DefaultSeverity = 'High',
    @ActionRequired = 1;

EXEC [tech].[usp_PopulateWarningDetails]
    @Title = 'Warning - Missing Dimension Key',
    @MessageTemplate = 'There is no correspondence on {Key} for the following row: {DynamicDetails}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Medium',
    @ActionRequired = 1;


-- Update a Warning Message
EXEC [tech].[usp_PopulateWarningDetails]
    @WarningID = 4,
    @MessageTemplate = 'Data conversion failed for column with code {ErrorColumn} by error code {ErrorCode}.
The failing row is following:
{DynamicDetails}'
