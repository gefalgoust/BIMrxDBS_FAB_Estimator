@ECHO OFF

:: Check if an argument is provided
IF "%~1"=="" (
    ECHO No file provided. Please pass a file as an argument.
    PAUSE
    EXIT /B 1
)

:: Set the argument as the file path
SET "filePath=%~1"

:: Display the file and its path
ECHO File Path: "%filePath%"
ECHO File Name: "%~nx1"
ECHO Directory: "%~dp1"

:: Pause to keep the command window open
PAUSE