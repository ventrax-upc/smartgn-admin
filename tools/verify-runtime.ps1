[CmdletBinding()]
param(
    [string]$BaseUrl = 'http://127.0.0.1:8089',
    [int]$WaitSeconds = 90
)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot

function Get-LocalSetting([string]$Name, [string]$Default) {
    $processValue = [Environment]::GetEnvironmentVariable($Name, 'Process')
    if (-not [string]::IsNullOrWhiteSpace($processValue)) { return $processValue }

    $envFile = Join-Path $repositoryRoot '.env'
    if (Test-Path -LiteralPath $envFile) {
        foreach ($line in Get-Content -LiteralPath $envFile) {
            if ($line -match ('^\s*' + [regex]::Escape($Name) + '\s*=\s*(.*)\s*$')) {
                return $Matches[1].Trim().Trim('"').Trim("'")
            }
        }
    }
    return $Default
}

$username = Get-LocalSetting 'SMARTGN_ADMIN_USERNAME' 'admin'
$password = Get-LocalSetting 'SMARTGN_ADMIN_PASSWORD' 'local-admin-password'
$basicToken = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("${username}:${password}"))
$headers = @{ Authorization = "Basic $basicToken" }
$healthUri = ($BaseUrl.TrimEnd('/') + '/actuator/health')
$deadline = (Get-Date).AddSeconds($WaitSeconds)
$health = $null

do {
    try {
        $health = Invoke-RestMethod -Method Get -Uri $healthUri -Headers $headers -TimeoutSec 5
        if ($health.status -eq 'UP') { break }
    } catch {
        Start-Sleep -Seconds 2
    }
} while ((Get-Date) -lt $deadline)

if ($null -eq $health -or $health.status -ne 'UP') {
    throw "Admin health did not report UP at $healthUri within $WaitSeconds seconds."
}

Write-Host "PASS Admin Actuator health: $($health.status) ($healthUri)"
