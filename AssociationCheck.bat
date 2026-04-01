@echo off
setlocal
set "OUT=%TEMP%\FEST_Association.txt"
(
  echo ===== FEST Association Dump =====
  echo Date: %date% %time%
  echo.
  echo [Query] HKCU\Software\Classes\.fest
  reg query "HKCU\Software\Classes\.fest" /ve
  echo.
  echo [Query] HKCU\Software\Classes\FEST.File
  reg query "HKCU\Software\Classes\FEST.File" /ve
  echo.
  echo [Query] HKCU\Software\Classes\FEST.File\shell\open\command
  reg query "HKCU\Software\Classes\FEST.File\shell\open\command" /ve
) > "%OUT%" 2>&1
notepad "%OUT%"
endlocal
