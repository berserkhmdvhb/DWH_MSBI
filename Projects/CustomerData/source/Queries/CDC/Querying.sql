USE CustomerDWH;
/*
Operation Column
1: DELETE
2: INSERT
3: BEFORE UPDATE
4: AFTER UPDATE
*/
SELECT TOP (1000) [__$start_lsn]
      ,[__$end_lsn]
      ,[__$seqval]
      ,[__$operation]
      ,[__$update_mask]
      ,[RowNumber]
      ,[CustomerCode]
      ,[CustomerName]
      ,[CustomerAmount]
      ,[SalesDate]
      ,[CountryID_FK]
      ,[StateID_FK]
      ,[ProductID_FK]
      ,[SalesPersonID_FK]
      ,[__$command_id]
  FROM [CustomerDWH].[cdc].[dbo_FactCustomer_CT]


  -- Select retention period
  EXEC sys.sp_cdc_change_job 
    @job_type = N'cleanup', 
    @retention = 7200--<retention_period_in_minutes>;


