```
public async void Main()
{
    // Declare variables at the beginning of the method to ensure global access
    string logFilePath = string.Empty; // Ensure it is initialized to avoid unassigned variable issues
    bool fireAgain = false;

    try
    {
        // Retrieve variables
        string filePath = Dts.Variables["User::V_PathFile"].Value.ToString();
        logFilePath = Dts.Variables["User::V_PathFile_Log"].Value.ToString();

        // Log file paths for debugging
        Dts.Events.FireInformation(0, "Script Task", $"File Path: {filePath}", string.Empty, 0, ref fireAgain);
        Dts.Events.FireInformation(0, "Script Task", $"Log File Path: {logFilePath}", string.Empty, 0, ref fireAgain);

        // Ensure the directory for the log file exists
        string logDirectoryPath = System.IO.Path.GetDirectoryName(logFilePath);
        if (!System.IO.Directory.Exists(logDirectoryPath))
        {
            System.IO.Directory.CreateDirectory(logDirectoryPath);
            Dts.Events.FireInformation(0, "Script Task", $"Log directory created: {logDirectoryPath}", string.Empty, 0, ref fireAgain);
        }

        // Ensure the directory for the output file exists
        string directoryPath = System.IO.Path.GetDirectoryName(filePath);
        if (!System.IO.Directory.Exists(directoryPath))
        {
            System.IO.Directory.CreateDirectory(directoryPath);
            Dts.Events.FireInformation(0, "Script Task", $"Directory created: {directoryPath}", string.Empty, 0, ref fireAgain);
        }
        else
        {
            Dts.Events.FireInformation(0, "Script Task", $"Directory exists: {directoryPath}", string.Empty, 0, ref fireAgain);
        }

        string url = "https://restcountries.com/v3.1/all";

        // Log start of execution
        Dts.Events.FireInformation(0, "Script Task", "Starting API fetch...", string.Empty, 0, ref fireAgain);

        // Fetch JSON data asynchronously
        using (HttpClient client = new HttpClient())
        {
            try
            {
                // Log before making the HTTP request
                Dts.Events.FireInformation(0, "Script Task", "Making HTTP request to API...", string.Empty, 0, ref fireAgain);

                string jsonResponse = await client.GetStringAsync(url);

                // Log after receiving the response
                Dts.Events.FireInformation(0, "Script Task", $"API fetch successful. Response length: {jsonResponse.Length}", string.Empty, 0, ref fireAgain);

                // Log before file writing
                Dts.Events.FireInformation(0, "Script Task", "Attempting to write to the file...", string.Empty, 0, ref fireAgain);

                // Write the response to the file
                System.IO.File.WriteAllText(filePath, jsonResponse);

                // Log after file writing
                Dts.Events.FireInformation(0, "Script Task", "File written successfully.", string.Empty, 0, ref fireAgain);
            }
            catch (HttpRequestException httpEx)
            {
                // Log detailed HTTP request error
                Dts.Events.FireError(0, "HTTP Request Error", 
                    $"HTTP Error: {httpEx.Message}\nStack Trace: {httpEx.StackTrace}", null, 0);

                if (httpEx.InnerException != null)
                {
                    Dts.Events.FireError(0, "Inner Exception", 
                        $"Inner Error: {httpEx.InnerException.Message}", null, 0);
                }

                // Write error details to the log file
                string errorContent = $"HTTP Error: {httpEx.Message}\nStack Trace: {httpEx.StackTrace}";
                if (httpEx.InnerException != null)
                {
                    errorContent += $"\nInner Error: {httpEx.InnerException.Message}";
                }
                System.IO.File.WriteAllText(logFilePath, errorContent);
                Dts.Events.FireInformation(0, "Script Task", $"Error details written to log file: {logFilePath}", string.Empty, 0, ref fireAgain);

                // Re-throw the exception to mark the task as failed
                throw;
            }
        }

        // Mark as success
        Dts.TaskResult = (int)ScriptResults.Success;
    }
    catch (Exception ex)
    {
        // Log detailed error information
        Dts.Events.FireError(0, "Script Task Error", 
            $"Error: {ex.Message}\nStack Trace: {ex.StackTrace}", null, 0);

        // Log inner exception if any
        if (ex.InnerException != null)
        {
            Dts.Events.FireError(0, "Inner Exception", 
                $"Inner Error: {ex.InnerException.Message}", null, 0);
        }

        // Write general error details to the log file
        string errorContent = $"Error: {ex.Message}\nStack Trace: {ex.StackTrace}";
        if (ex.InnerException != null)
        {
            errorContent += $"\nInner Error: {ex.InnerException.Message}";
        }
        System.IO.File.WriteAllText(logFilePath, errorContent);
        Dts.Events.FireInformation(0, "Script Task", $"Error details written to log file: {logFilePath}", string.Empty, 0, ref fireAgain);

        // Mark as failure
        Dts.TaskResult = (int)ScriptResults.Failure;
    }
}

```
