To query log table from SSIS:

```sql
USE CustomerDWH;
SELECT 
    event AS EventType,
    source AS SourceComponent,
    starttime AS StartTime,
    endtime AS EndTime,
    message AS Message
FROM dbo.sysssislog
ORDER BY starttime DESC;
```

. Enable Detailed Logging
Ensure your SSIS package is configured to capture detailed logs for relevant events like OnError, OnInformation, and OnWarning.

Steps:
Open the Logging Configuration window:

Right-click the Control Flow surface and select Logging.
Add a Log Provider:

If none exists, add a log provider, such as:
SSIS Log Provider for Text Files: Logs to a file.
SSIS Log Provider for SQL Server: Logs to a database table.
Configure Logged Events:

For the Script Task (or the entire package), enable the following events:
OnError: Logs errors.
OnWarning: Logs warnings.
OnInformation: Logs informational messages.
ScriptTaskLogEntry: Captures custom messages fired from the script.
Verify Destination:

For file-based logging, check the log file path for the actual logs.
For SQL Server logging, review the sysssislog table in the configured database.
