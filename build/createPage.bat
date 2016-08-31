@ECHO OFF

ECHO.

SET PageName=""
SET IncludeControllerClass=""
SET ControllerClassName=""
SET Version=""
SET tab=	

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
		SET PageName=%~2
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
	
	SHIFT & SHIFT
	GOTO PROCESS_ARGS
)

:VALIDATE_ARGS
IF %PageName%=="" GOTO PAGENAME_NOT_SPECIFIED 
IF %IncludeControllerClass%=="" SET IncludeControllerClass=0
IF %ControllerClassName%==""  SET ControllerClassName=%PageName%Controller
IF %Version%=="" SET Version=31.0

REM Get the path to the classes folder
SET ExecutingDir="%CD%"
SET SourceDir=%CD%\..\source
SET FileName=%PageName%.page
SET MetaFileName=%FileName%-meta.xml


REM *******************************************************************************************************************
REM Create Page File
REM *******************************************************************************************************************

REM Check if file exists
FOR %%b IN ("%SourceDir%\pages\%FileName%") DO IF EXIST %%~sb GOTO PAGE_EXISTS

CD "%SourceDir%\pages"
copy /y nul %FileName%

(
	ECHO ^<apex:page controller="%ControllerClassName%" showHeader="false" standardStylesheets="false" docType="html-5.0"^>
	ECHO %tab%^<apex:composition template="MC_MasterPage"^>
	ECHO %tab%^<apex:define name="ngModules"^>{!ngModules}^</apex:define^>
	ECHO %tab%%tab%^<apex:define name="title"^>%PageName%^</apex:define^>
	ECHO %tab%%tab%^<apex:define name="body"^>
	ECHO.
	ECHO %tab%%tab%^</apex:define^>
	ECHO %tab%^</apex:composition^>
	ECHO ^</apex:page^>
) >%FileName%

CALL :echoColor Cyan "Page file created: %SourceDir%\pages\%FileName%"
ECHO.


REM *******************************************************************************************************************
REM Create Class page File
REM *******************************************************************************************************************

REM Check if file exists
FOR %%b IN ("%SourceDir%\pages\%MetaFileName%") DO IF EXIST %%~sb GOTO META_EXISTS

copy /y nul %MetaFileName%

(
	ECHO ^<?xml version="1.0" encoding="UTF-8"?^>
	ECHO ^<ApexPage xmlns="http://soap.sforce.com/2006/04/metadata"^>
    ECHO 	^<apiVersion^>%Version%^</apiVersion^>
    ECHO 	^<availableInTouch^>true^</availableInTouch^>
	ECHO 	^<confirmationTokenRequired^>false^</confirmationTokenRequired^>
	ECHO 	^<label^>%PageName%^</label^>
	ECHO ^</ApexPage^>
) >%MetaFileName%

CALL :echoColor Cyan "Page meta file created: %SourceDir%\pages\%MetaFileName%"
ECHO.

REM *******************************************************************************************************************
REM Create Controller
REM *******************************************************************************************************************

rem if not creating the controller class, process is complete
IF NOT %IncludeControllerClass%==1 GOTO COMPLETE

CALL :echoColor Yellow "Creating classes."
REM create the contorller class, class meta, test class and test meta files
CD "%ExecutingDir%"
CALL createClass /n %ControllerClassName% /s 1 /f controllers /v %Version% /c 1
GOTO COMPLETE



REM *******************************************************************************************************************
REM Errors
REM *******************************************************************************************************************

:PAGENAME_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the page must be provided."
GOTO END

:PAGE_EXISTS
ECHO.
CALL :echoColor red "Error: The page already exists.  Please specify a new page name."
GOTO END

:META_EXISTS
ECHO.
CALL :echoColor red "Error: The page meta file already exists."
GOTO END

:DISPLAY_USAGE
@ECHO ...
ECHO Usage:
ECHO createPage /n [/c /i /v]
ECHO.
ECHO /n: page name - the name of the page to create - used for file name and meta label text.
ECHO /c: controller class name - the value set in the controller attribute of the page.
ECHO /i: include creating the controller class.  set to 1 for true anything else for false.
ECHO /v: version - the sf api version (default is 31.0)
ECHO.
ECHO Example usage:
ECHO %tab%createPage /n MC_Account [/v 33.0 /i 1 /c MC_AccountController]
ECHO.
ECHO.
GOTO :END


REM *******************************************************************************************************************
REM Successful completion
REM *******************************************************************************************************************
:COMPLETE
ECHO.
ECHO.
CALL :echoColor Green "Page create complete."
GOTO END

:END
ECHO.
CD "%ExecutingDir%"
EXIT /b 0


:echoColor
powershell -Command Write-Host "%2" -foregroundcolor %1
