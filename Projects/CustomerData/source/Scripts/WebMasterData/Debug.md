```
public async void Main()
{
    try
    {
        // Retrieve the file path from the variable
        string filePath = Dts.Variables["User::V_PathFile"].Value.ToString();
        
        // Declare fireAgain for logging
        bool fireAgain = false;

        // Log the file path for debugging
        Dts.Events.FireInformation(0, "Script Task", $"File Path: {filePath}", string.Empty, 0, ref fireAgain);

        // Ensure the directory exists
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
            string jsonResponse = await client.GetStringAsync(url);

            // Log successful fetch
            Dts.Events.FireInformation(0, "Script Task", "API fetch successful.", string.Empty, 0, ref fireAgain);

            // Log before file writing
            Dts.Events.FireInformation(0, "Script Task", "Attempting to write to the file...", string.Empty, 0, ref fireAgain);

            // Write the response to the file
            System.IO.File.WriteAllText(filePath, jsonResponse.Substring(0, 500)); // Write the first 500 characters for testing

            // Log after file writing
            Dts.Events.FireInformation(0, "Script Task", "File written successfully.", string.Empty, 0, ref fireAgain);
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

        // Mark as failure
        Dts.TaskResult = (int)ScriptResults.Failure;
    }
}

```
