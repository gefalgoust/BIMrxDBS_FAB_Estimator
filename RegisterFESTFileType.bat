@echo off
setlocal enabledelayedexpansion

echo ============================================================
echo FEST File Type Registration (v4)
echo ============================================================

set "SCRIPT_DIR=%~dp0"
set "PS1=%SCRIPT_DIR%OpenFest.ps1"
set "PROGID=FEST.File"
set "DESC=FAB Estimator Trigger"

if not exist "%PS1%" (
    echo OpenFest.ps1 not found:
    echo %PS1%
    pause
    exit /b 1
)

reg add "HKCU\Software\Classes\.fest" /ve /d "%PROGID%" /f >nul 2>&1
reg add "HKCU\Software\Classes\%PROGID%" /ve /d "%DESC%" /f >nul 2>&1
reg add "HKCU\Software\Classes\%PROGID%\DefaultIcon" /ve /d "%%SystemRoot%%\System32\shell32.dll,269" /f >nul 2>&1
reg add "HKCU\Software\Classes\%PROGID%\shell\open\command" /ve /d "powershell.exe -ExecutionPolicy Bypass -NoProfile -File ""%PS1%"" ""%%1""" /f >nul 2>&1

echo Registered .fest for current user.
pause
endlocal
