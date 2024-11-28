```
public void Main()
{
    try
    {
        // Declare the fireAgain variable
        bool fireAgain = false;

        // Test if variable is accessible
        string filePath = Dts.Variables["User::V_PathFile"].Value.ToString();
        string url = "https://restcountries.com/v3.1/all";

        // Log variable value
        Dts.Events.FireInformation(0, "Script Task", $"File Path: {filePath}", string.Empty, 0, ref fireAgain);

        // Fetch JSON data
        using (HttpClient client = new HttpClient())
        {
            string jsonResponse = client.GetStringAsync(url).Result;

            // Write first 500 characters to file for testing
            System.IO.File.WriteAllText(filePath, jsonResponse.Substring(0, 500));
        }

        // Mark as success
        Dts.TaskResult = (int)ScriptResults.Success;
    }
    catch (Exception ex)
    {
        // Log detailed error information
        Dts.Events.FireError(0, "Script Task Error", $"Error: {ex.Message}\nStack Trace: {ex.StackTrace}", null, 0);
        Dts.TaskResult = (int)ScriptResults.Failure;
    }
}

```
