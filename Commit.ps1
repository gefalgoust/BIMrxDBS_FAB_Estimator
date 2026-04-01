# ============================================================
# Commit.ps1
# Interactive Git commit helper for BIMrxDBS FAB Estimator.
# Auto-fills date, prompts for version and message,
# then commits + pushes to origin/master.
# ============================================================

$repoRoot = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
Set-Location $repoRoot

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Git Commit Helper  -  BIMrxDBS FAB Estimator" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# --- Auto date ---
$today = Get-Date -Format "yyyyMMdd"

# --- Detect last version from git log ---
$lastCommit = git log --oneline -1 2>$null
$currentVersion = ""
if ($lastCommit -match "v(\d+\.\d+\.\d+)") {
    $currentVersion = $Matches[1]
}

# --- Version ---
if ($currentVersion) {
    Write-Host "  Current version: v$currentVersion" -ForegroundColor DarkGray
    $version = Read-Host "  New version     (e.g. $currentVersion)"
} else {
    $version = Read-Host "  Version  (e.g. 1.0.0)"
}
$version = $version.Trim().TrimStart("vV")

# --- Type ---
Write-Host ""
Write-Host "  Commit type:" -ForegroundColor Yellow
Write-Host "    1) feat     - new feature or enhancement"
Write-Host "    2) fix      - bug fix"
Write-Host "    3) chore    - maintenance / housekeeping"
Write-Host "    4) refactor - restructure without behaviour change"
Write-Host "    5) docs     - documentation only"
Write-Host ""
$typeChoice = Read-Host "  Choose [1-5]"
switch ($typeChoice.Trim()) {
    "1" { $type = "feat" }
    "2" { $type = "fix" }
    "3" { $type = "chore" }
    "4" { $type = "refactor" }
    "5" { $type = "docs" }
    default {
        Write-Host "  Invalid choice - defaulting to 'chore'" -ForegroundColor Yellow
        $type = "chore"
    }
}

# --- Summary ---
Write-Host ""
$summary = Read-Host "  Summary  (one-line description)"
$summary = $summary.Trim()
if ([string]::IsNullOrWhiteSpace($summary)) {
    Write-Host "  ERROR: Summary cannot be empty." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# --- Build commit message ---
$message = $today + " - v" + $version + ": " + $type + ": " + $summary

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Commit message:" -ForegroundColor Yellow
Write-Host "  $message" -ForegroundColor White
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# --- Confirm ---
$confirm = Read-Host "  Proceed? [Y/N]"
if ($confirm.Trim().ToUpper() -ne "Y") {
    Write-Host "  Cancelled." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 0
}

Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray

# --- Step 1: Pull latest ---
Write-Host "  [1/3] Pulling latest from origin/master..." -ForegroundColor Cyan
git pull --ff-only
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERROR: git pull failed. Resolve conflicts before committing." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# --- Step 2: Stage and commit ---
Write-Host ""
Write-Host "  [2/3] Staging all changes and committing..." -ForegroundColor Cyan
git add -A
git commit -m $message
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERROR: git commit failed. There may be nothing to commit." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# --- Step 3: Push ---
Write-Host ""
Write-Host "  [3/3] Pushing to origin/master..." -ForegroundColor Cyan
git push
if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERROR: git push failed." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  Done! Committed: $message" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to exit"
