@echo off
setlocal
set "PROGID=FEST.File"
reg delete "HKCU\Software\Classes\.fest" /f >nul 2>&1
reg delete "HKCU\Software\Classes\%PROGID%" /f >nul 2>&1
echo Unregistered .fest.
pause
endlocal
