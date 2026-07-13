$ErrorActionPreference = "Stop"

$payloadsDir = Join-Path $PSScriptRoot "payloads"
$resultsPath = Join-Path $PSScriptRoot "test_results.csv"
$callbackUrl = "http://localhost:8090/"
$clientSecret = "harness-secret"
$endpoint = "http://localhost:8090/"

$hmac = New-Object System.Security.Cryptography.HMACSHA256
$hmac.Key = [System.Text.Encoding]::UTF8.GetBytes($clientSecret)

$files = Get-ChildItem -Path $payloadsDir -Filter "*.json" | Sort-Object Name

$results = @()

foreach ($f in $files) {
    $body = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $timestampMs = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds()

    $sourceString = "POST" + $callbackUrl + $body + $timestampMs
    $sourceBytes = [System.Text.Encoding]::UTF8.GetBytes($sourceString)
    $hash = $hmac.ComputeHash($sourceBytes)
    $signature = [Convert]::ToBase64String($hash)

    $statusCode = -1
    $errorMessage = ""
    try {
        $response = Invoke-WebRequest -Uri $endpoint -Method Post -Body $body `
            -ContentType "application/json" `
            -Headers @{ "X-HubSpot-Signature-v3" = $signature; "X-HubSpot-Request-Timestamp" = "$timestampMs" } `
            -UseBasicParsing
        $statusCode = $response.StatusCode
    } catch {
        if ($_.Exception.Response) {
            $statusCode = [int]$_.Exception.Response.StatusCode
        }
        $errorMessage = $_.Exception.Message
    }

    $results += [pscustomobject]@{
        PayloadFile = $f.Name
        StatusCode  = $statusCode
        Error       = $errorMessage
    }

    Write-Host ("{0} -> {1} {2}" -f $f.Name, $statusCode, $errorMessage)
    Start-Sleep -Milliseconds 150
}

$results | Export-Csv -Path $resultsPath -NoTypeInformation
Write-Host "Wrote results to $resultsPath"
