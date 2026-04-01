param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$FestPath
)

# OpenFest.ps1 (v4 - silent)
# - Resolves sibling CSV (same base name)
# - Copies batch to %TEMP% and runs local copy (avoids network security prompt)
# - Hidden window

$LogFile = Join-Path $env:TEMP "OpenFest_Log.txt"
function Write-Log { param([string]$m) ("{0}`t{1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $m) | Out-File $LogFile -Append -Encoding UTF8 }

try {
    $FestPath = [System.IO.Path]::GetFullPath($FestPath)
    if (-not (Test-Path -LiteralPath $FestPath)) { throw "FEST file not found: `"$FestPath`"" }

    $folder   = Split-Path -Path $FestPath -Parent
    $basename = [System.IO.Path]::GetFileNameWithoutExtension($FestPath)
    $CsvPath  = Join-Path $folder ($basename + ".csv")
    if (-not (Test-Path -LiteralPath $CsvPath)) { throw "Expected CSV not found next to FEST: `"$CsvPath`"" }

    $ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
    $BatchPath = Join-Path $ScriptDir "BIMrxDBS Shop Order.bat"
    if (-not (Test-Path -LiteralPath $BatchPath)) { throw "Handler batch not found: `"$BatchPath`"" }

    # Option C: run a local copy
    $TempBat = Join-Path $env:TEMP "BIMrxDBS_Shop_Order.bat"
    Copy-Item -LiteralPath $BatchPath -Destination $TempBat -Force
    Unblock-File -LiteralPath $TempBat -ErrorAction SilentlyContinue

    Start-Process -FilePath $TempBat `
                  -ArgumentList @("`"$CsvPath`"") `
                  -WorkingDirectory (Split-Path -Path $BatchPath -Parent) `
                  -WindowStyle Hidden
}
catch {
    # For quick diag, uncomment next line and switch WindowStyle to Normal above
    # Write-Log $_.Exception.Message
    exit 1
}
