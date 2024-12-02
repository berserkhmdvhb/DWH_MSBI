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

-- Update a Warning Message

EXEC [tech].[usp_PopulateWarningDetails]
	@WarningID = 123,
    @MessageTemplate = 'Data conversion failed for {ErrorColumn} with value {ErrorCode}'
