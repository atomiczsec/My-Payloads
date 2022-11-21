while (1){
Start-Sleep -Second 45
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys('{CAPSLOCK}')
Start-Sleep -Second 150
$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys('{CAPSLOCK}')
} 
