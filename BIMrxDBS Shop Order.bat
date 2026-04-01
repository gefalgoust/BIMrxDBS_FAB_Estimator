@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM BIMrxDBS Shop Order.bat (v4 - silent)
REM Strategy C -> D only
REM   C) Copy template to %TEMP% and open
REM   D) COM-based PowerShell helper fallback
REM ============================================================

REM ---- Arguments ----
if "%~1"=="" exit /b 2
set "filePath=%~1"
if not exist "%filePath%" exit /b 3

REM ---- Paths ----
REM OpenFest.ps1 launches this temp-copied batch with WorkingDirectory set to the project folder.
set "projectDir=%CD%"
set "destinationPath=%projectDir%\BIMrxDBS Shop Order.csv"
set "excelTemplate=%projectDir%\Programming ONLY\2025_FAB-Estimator.xltm"
set "psComHelper=%projectDir%\OpenExcelFromTemplate.ps1"

if not exist "%excelTemplate%" exit /b 6

REM Ensure destination dir exists
for %%D in ("%destinationPath%") do set "destDir=%%~dpD"
if not exist "%destDir%" (
  mkdir "%destDir%" 2>nul || exit /b 4
)

REM Copy CSV to destination
copy /y "%filePath%" "%destinationPath%" >nul || exit /b 5

REM Locate Excel
set "excelExe=excel.exe"
where "%excelExe%" >nul 2>&1 || set "excelExe=C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
if not exist "%excelExe%" exit /b 7

REM Strategy C: local template copy
set "localTemplate=%TEMP%\2025_FAB-Estimator.xltm"
copy /y "%excelTemplate%" "%localTemplate%" >nul || goto STRATEGY_D

start "" "%excelExe%" /t "%localTemplate%"
if not errorlevel 1 goto DONE

start "" "%excelExe%" "%localTemplate%"
if not errorlevel 1 goto DONE

:STRATEGY_D
if not exist "%psComHelper%" exit /b 12
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%psComHelper%" -TemplatePath "%excelTemplate%" || exit /b 13

:DONE
exit /b 0
