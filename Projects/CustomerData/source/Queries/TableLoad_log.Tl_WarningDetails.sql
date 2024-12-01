EXEC [log].[usp_PopulateWarningDetails]
    @MessageTemplate = 'Missing dimension key: {KeyValue} for {DimensionName}',
    @Category = 'Missing Dimension',
    @DefaultSeverity = 'High',
    @ActionRequired = 1;

EXEC [log].[usp_PopulateWarningDetails]
    @MessageTemplate = 'Data conversion failed for {ColumnName} with value {Value}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Medium',
    @ActionRequired = 1;

EXEC [log].[usp_PopulateWarningDetails]
    @MessageTemplate = 'Threshold exceeded: {ColumnName} value {Value} exceeds limit.',
    @Category = 'Business Rule',
    @DefaultSeverity = 'High',
    @ActionRequired = 1;

EXEC [log].[usp_PopulateWarningDetails]
    @MessageTemplate = 'Negative value detected in {ColumnName} for row {RowIdentifier}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Medium',
    @ActionRequired = 1;

EXEC [log].[usp_PopulateWarningDetails]
    @MessageTemplate = 'Null value found in {ColumnName} for row {RowIdentifier}',
    @Category = 'Data Quality',
    @DefaultSeverity = 'Low',
    @ActionRequired = 1;