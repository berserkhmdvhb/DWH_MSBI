
  -- Select retention period
  EXEC sys.sp_cdc_change_job 
    @job_type = N'cleanup', 
    @retention = 7200--<retention_period_in_minutes>;