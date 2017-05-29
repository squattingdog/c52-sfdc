@ECHO OFF

ECHO.

SET ComponentName=""
SET IncludeControllerClass=""
SET ControllerClassName=""
SET Version=""
SET tab=	
SET SourceFolderType="common"

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
		SET ComponentName=%~2
	)
	IF "%1"=="/c" (
		SET ControllerClassName=%~2
	)
	IF "%1"=="/i" (
		SET IncludeControllerClass=%~2
	)
	IF "%1"=="/v" (
		SET Version=%~2
	)
	IF "%1"=="/a" (
		SET SourceFolderType=%~2
	)
	
	SHIFT & SHIFT
	GOTO PROCESS_ARGS
)

:VALIDATE_ARGS
IF %ComponentName%=="" GOTO COMPONENTNAME_NOT_SPECIFIED
IF %IncludeControllerClass%=="" SET IncludeControllerClass=0
IF %ControllerClassName%=="" SET ControllerClassName=%ComponentName%Controller
IF %Version%=="" SET Version=31.0

REM Get the path to the classes folder
SET ExecutingDir="%CD%"
SET SourceDir=%CD%\..\source\%SourceFolderType%
SET FileName=%ComponentName%.component
SET MetaFileName=%FileName%-meta.xml


REM *******************************************************************************************************************
REM Create Component File
REM *******************************************************************************************************************

REM Check if file exists
FOR %%b IN ("%SourceDir%\components\%FileName%") DO IF EXIST %%~sb GOTO PAGE_EXISTS

CD "%SourceDir%\components"
copy /y nul %FileName%

(
	ECHO ^<apex:component controller="%ControllerClassName%" ^>
	ECHO.%tab%
	ECHO ^</apex:component^>
) >%FileName%

CALL :echoColor Cyan "Component file created: %SourceDir%\components\%FileName%"
ECHO.


REM *******************************************************************************************************************
REM Create Class Meta File
REM *******************************************************************************************************************

REM Check if file exists
FOR %%b IN ("%SourceDir%\components\%MetaFileName%") DO IF EXIST %%~sb GOTO META_EXISTS

copy /y nul %MetaFileName%

(
	ECHO ^<?xml version="1.0" encoding="UTF-8"?^>
	ECHO ^<ApexComponent xmlns="http://soap.sforce.com/2006/04/metadata"^>
    ECHO %tab%^<apiVersion^>%Version%^</apiVersion^>
	ECHO %tab%^<label^>%ComponentName%^</label^>
	ECHO %tab%^<description^>^</description^>
	ECHO ^</ApexComponent^>
) >%MetaFileName%

CALL :echoColor Cyan "Component meta file created: %SourceDir%\components\%MetaFileName%"
ECHO.

REM *******************************************************************************************************************
REM Create Controller
REM *******************************************************************************************************************

rem if not creating the controller class, process is complete
IF NOT %IncludeControllerClass%==1 GOTO COMPLETE

CALL :echoColor Yellow "Creating classes."
REM create the contorller class, class meta, test class and test meta files
CD "%ExecutingDir%"
CALL createClass /n %ControllerClassName% /s 1 /f controllers /v %Version% /c 1 /a %SourceFolderType%
GOTO COMPLETE



REM *******************************************************************************************************************
REM Errors
REM *******************************************************************************************************************

:COMPONENTNAME_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the component must be provided."
GOTO END

:PAGE_EXISTS
ECHO.
CALL :echoColor red "Error: The component already exists.  Please specify a new component name."
GOTO END

:META_EXISTS
ECHO.
CALL :echoColor red "Error: The component meta file already exists."
GOTO END

:DISPLAY_USAGE
@ECHO ...
ECHO Usage:
ECHO createComponent /n [/c /i /v /a]
ECHO.
ECHO /n: component name - the name of the component to create - used for file name and meta label text.
ECHO /c: controller class name - the value set in the controller attribute of the page.  If not specified, the word 'Controller' will be appended to the componentName.
ECHO /i: include creating the controller class.  set to 1 for true anything else for false.  If set to 1, test class and meta files will also be created.
ECHO /v: version - the sf api version (default is 31.0)
ECHO /a: 2nd tier directory under $root.  i.e. $root/source/[dir] (default is 'common")
ECHO.
ECHO Example usage:
ECHO %tab%createComponent /n MC_AcctComponent [/v 33.0 /i 1 /c MC_AcctComponentController /a myAppDir]
ECHO.
ECHO.
GOTO :END


REM *******************************************************************************************************************
REM Successful completion
REM *******************************************************************************************************************
:COMPLETE
ECHO.
ECHO.
CALL :echoColor Green "Component create complete."
GOTO END

:END
ECHO.
CD "%ExecutingDir%"
EXIT /b 0


:echoColor
powershell -Command Write-Host "%2" -foregroundcolor %1
