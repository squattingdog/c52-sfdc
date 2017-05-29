@ECHO OFF
ECHO.

SET TriggerName=""
SET SObjectType=""
SET DomainClass=""
SET FolderName=""
SET Version=""
SET tab=	
SET SourceFolderType="common"


REM *******************************************************************************************************************
REM Setup vars based on passed in args
REM *******************************************************************************************************************
:PROCESS_ARGS

IF NOT "%1"=="" (
	IF "%1"=="/?" (
		GOTO DISPLAY_USAGE
	)
	IF "%1"=="/n" (
		SET TriggerName=%~2
	)
	IF "%1"=="/o" (
		SET SObjectType=%~2
	)
	IF "%1"=="/d" (
		SET DomainClass=%~2
	)
	IF "%1"=="/f" (
		SET FolderName=%~2
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

REM setup default values / basic error checking

IF %TriggerName%=="" GOTO TRIGGERNAME_NOT_SPECIFIED
IF %SObjectType%=="" GOTO SOBJECTTYPE_NOT_SPECIFIED
SET %DomainClass%="" GOTO DOMAIN_CLASS_NOT_SPECIFIED
IF NOT %FolderName%=="" SET FolderName=\%FolderName%
IF %Version%=="" SET Version=37.0

REM Get the path to the triggers folder
SET ExecutingDir="%CD%"
SET SourceDir=%CD%\..\source\%SourceFolderType%
SET FileName=%TriggerName%.trigger
SET MetaFileName=%FileName%-meta.xml


REM *******************************************************************************************************************
REM Create Trigger File
REM *******************************************************************************************************************

REM check if directory exists
IF NOT EXIST "%SourceDir%\triggers%FolderName%" GOTO DIRECTORY_DOES_NOT_EXIST

REM Check if file exists
FOR %%a IN ("%SourceDir%\triggers%FolderName%\%FileName%") DO IF EXIST %%~sa GOTO TRIGGER_EXISTS

CD "%SourceDir%\triggers%FolderName%"
copy /y nul %FileName%

(
	echo trigger %TriggerName% on %SObjectType% ^(
	echo %tab%after delete, after insert, after update, before delete, before insert, before update^) {
	echo.
	echo %tab%// Creates Domain class instance and calls apprpoprite overideable methods according to Trigger state
	echo %tab%fflib_SObjectDomain.triggerHandler^(%DomainClass%.class^);
	echo }
) >%FileName%

CALL :echoColor Cyan "Trigger file created: %SourceDir%\triggers%FolderName%\%FileName%"
ECHO.


REM *******************************************************************************************************************
REM Create Class Meta File
REM *******************************************************************************************************************

REM Check if file exists
FOR %%b IN ("%SourceDir%\triggers\%FolderName%\%MetaFileName%") DO IF EXIST %%~sb GOTO META_EXISTS

CD "%SourceDir%\triggers\%FolderName%"
copy /y nul %MetaFileName%

(
	ECHO ^<?xml version="1.0" encoding="UTF-8"?^>
	ECHO ^<ApexTrigger  xmlns="http://soap.sforce.com/2006/04/metadata"^>
    ECHO 	^<apiVersion^>%Version%^</apiVersion^>
    ECHO 	^<status^>Active^</status^>
	ECHO ^</ApexTrigger ^>
) >%MetaFileName%


CALL :echoColor Cyan "Trigger meta file created: %SourceDir%\triggers\%FolderName%\%MetaFileName%"
ECHO.

GOTO COMPLETE


REM *******************************************************************************************************************
REM Errors
REM *******************************************************************************************************************
:DIRECTORY_DOES_NOT_EXIST
ECHO.
CALL :echoColor white "the directory %SourceDir%\triggers%FolderName% does not exist."
CALL :echoColor white "Would you like to create it [y or n]"
SET /p CreateDir=": " %=%
IF /I "%CreateDir%"=="y" GOTO CREATE_DIRECTORY
GOTO END

:CREATE_DIRECTORY
MD "%SourceDir%\triggers%FolderName%"
GOTO CREATE_TRIGGER

:TRIGGERNAME_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the trigger must be provided.  Use /n 'name'"
GOTO DISPLAY_USAGE

:SOBJECTTYPE_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the SObjectType must be provided. use /o 'SObjectType'"

:DOMAIN_CLASS_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the fflib registered domain class must be provided.  Use /d 'myDomainClass'"

:TRIGGER_EXISTS
ECHO.
CALL :echoColor red "Error: The trigger already exists.  Please specify a new trigger name."
GOTO END

:META_EXISTS
ECHO.
CALL :echoColor red "Error: The meta file already exists."
GOTO END

:INVALID_ARG_VALUE
ECHO.
CALL :echoColor red "Error: Invalid argument value or value not provided.  Argument values cannot begin with a slash '/'.
GOTO END


:DISPLAY_USAGE
@ECHO ...
ECHO Usage:
ECHO /n: required - the name of the class to create.
ECHO /o: required - the SOBjectType to which the trigger will be applied.
ECHO /d: required - the domain class type that is used in the fflib_SObjectDomain.triggerHandler method.
ECHO /f: optional - The direcotry path inside of $root/classes where the class file will be created.
ECHO %tab%%tab%Leading and trailing slashes will be automatically added.
ECHO %tab%%tab%Pass empty quotes to use the defualt directory.
ECHO %tab%%tab%sample creating a TestServices class: tests\testServices
ECHO /v: optional - the api version to use in the meta file.
ECHO /a: optional - sets the second tier directory under $root where the source is found.
ECHO %tab%%tab%Default value is "common" i.e. $root/source/common
ECHO.
ECHO Example call using the myApps directory
ECHO %tab%createTrigger /n yourTriggerName /o CustomObject__c /d CustomObjects /a myApps
ECHO.
ECHO.
GOTO :END


REM *******************************************************************************************************************
REM Successful completion
REM *******************************************************************************************************************
:COMPLETE
ECHO.
ECHO.
CALL :echoColor Green "Trigger Creation Complete"
GOTO END

:END
ECHO.
CD "%ExecutingDir%"
EXIT /b 0


:echoColor
powershell -Command Write-Host "%2" -foregroundcolor %1