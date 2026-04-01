param(
    [Parameter(Mandatory=$true)]
    [string]$TemplatePath
)
try {
    if (-not (Test-Path -LiteralPath $TemplatePath)) { throw "Template not found: $TemplatePath" }
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $true
    $null = $excel.Workbooks.Add($TemplatePath)
    $excel.WindowState = -4143  # xlNormal
}
catch {
    Write-Error $_.Exception.Message
    exit 1
}
