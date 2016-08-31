ECHO OFF
ECHO.

SET PermSetName=""
SET FileName=""

REM *******************************************************************************************************************
REM Setup vars based on passed in args
REM *******************************************************************************************************************
:PROCESS_ARGS
IF [%1] == []  (
	GOTO VALIDATE_ARGS
)
	
IF NOT "%1" =="" (
	IF "%1"=="/?" (
		GOTO DISPLAY_USAGE
	)
	IF "%1"=="/n" (
		SET PermSetName=%~2
	)
	IF "%1"=="/f" (
		SET FileName=%~2
	)
	
	SHIFT & SHIFT
	GOTO PROCESS_ARGS
)

:VALIDATE_ARGS
REM basic error checking
IF %PermSetName%=="" GOTO PERMISSION_SET_NAME_NOT_SPECIFIED

IF %FileName% == "" (
	SET FileName=%PermSetName%.permissionset
) ELSE (
	SET FileName=%FileName%.permissionset
)

REM Get the path to the classes folder
SET ExecutingDir="%CD%"
SET SourceDir=%CD%\..\source


:CREATE_PERMISSION_SET
REM Check if file exists
FOR %%b IN ("%SourceDir%\permissionsets\%FileName%") DO IF EXIST %%~sb GOTO PERMISSION_SET_EXISTS

CD "%SourceDir%\permissionsets"
copy /y nul %FileName%

(
	ECHO ^<?xml version="1.0" encoding="UTF-8"?^>
	ECHO ^<PermissionSet xmlns="http://soap.sforce.com/2006/04/metadata"^>
    ECHO 	^<label^>%PermSetName%^</label^>
	ECHO ^</PermissionSet^>
) >%FileName%

CALL :echoColor Cyan "PermissionSet file created: %SourceDir%\permissionsets\%FileName%"
ECHO. 
GOTO COMPLETE


:PERMISSION_SET_EXISTS
ECHO.
CALL :echoColor red "Error: The permission set already exists.  Please specify a new permission set name."
GOTO END


:PERMISSION_SET_NAME_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the permission set must be provided."
GOTO DISPLAY_USAGE


:DISPLAY_USAGE
@ECHO ...
ECHO Usage:
ECHO createPermSet /n [/f]
ECHO.
ECHO /n: PermSetName - the name of the permission set to create.  This is the label text.
ECHO /f: FileName - the name of the file.  If not set, the PermSetName value will be used. 
ECHO.
ECHO Example usage:
ECHO %tab%createPermSet /n "permission set name" [/f fileName]
ECHO.
ECHO.
GOTO :END


REM *******************************************************************************************************************
REM Successful completion
REM *******************************************************************************************************************
:COMPLETE
ECHO.
ECHO.
CALL :echoColor Green "Permission Set Creation Complete"
GOTO END


:END
ECHO.
CD %ExecutingDir%
EXIT /b 0


:echoColor
powershell -Command Write-Host "%2" -foregroundcolor %1