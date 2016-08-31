@ECHO OFF
ECHO.

SET ClassName=""
SET TestClassSwitch=""
SET FolderName=""
SET Version=""
SET IsController=0
SET tab=	


REM *******************************************************************************************************************
REM Setup vars based on passed in args
REM *******************************************************************************************************************
:PROCESS_ARGS

IF NOT "%1"=="" (
	IF "%1"=="/?" (
		GOTO DISPLAY_USAGE
	)
	IF "%1"=="/n" (
		SET ClassName=%~2
	)
	IF "%1"=="/s" (
		SET TestClassSwitch=%~2
	)
	IF "%1"=="/f" (
		SET FolderName=%~2
	)
	IF "%1"=="/v" (
		SET Version=%~2
	)
	IF "%1"=="/c" (
		SET IsController=%~2
	)
	
	SHIFT & SHIFT
	GOTO PROCESS_ARGS
)

REM setup default values / basic error checking

IF %ClassName%=="" GOTO CLASSNAME_NOT_SPECIFIED
IF %TestClassSwitch%=="" SET TestClassSwitch=0
IF NOT %FolderName%=="" SET FolderName=\%FolderName%
IF %Version%=="" SET Version=31.0

REM Get the path to the classes folder
SET ExecutingDir="%CD%"
SET SourceDir=%CD%\..\source
SET FileName=%ClassName%.cls
SET MetaFileName=%FileName%-meta.xml
SET TestFileName=%ClassName%Test.cls
SET TestMetaFileName=%TestFileName%-meta.xml


REM *******************************************************************************************************************
REM Create Class File
REM *******************************************************************************************************************
IF %TestClassSwitch%==2 GOTO CREATE_TEST_CLASS
IF %FolderName%=="" GOTO CREATE_CLASS

REM check if directory exists
IF NOT EXIST "%SourceDir%\Classes%FolderName%" GOTO DIRECTORY_DOES_NOT_EXIST

REM Check if file exists
:CREATE_CLASS
FOR %%a IN ("%SourceDir%\Classes%FolderName%\%FileName%") DO IF EXIST %%~sa GOTO CLASS_EXISTS

CD "%SourceDir%\Classes%FolderName%"
copy /y nul %FileName%

(
	IF %IsController%==1 (
		echo public with sharing class %ClassName% extends MC_ControllerBase {
		echo.
		echo.
		echo %tab%/**********************************
		echo %tab%**  MC_ControllerBase Overrides  **
		echo %tab%**********************************/
		echo %tab%protected override List^<MC_Request^> getRetrieveRequestList^(^) {
		echo %tab%%tab%throw new MC_Exceptions.UnimplementedException^(^);
		echo %tab%}
	) ELSE (
		echo public with sharing class %ClassName% {
	)
	echo.
	echo }
) >%FileName%

CALL :echoColor Cyan "Class file created: %SourceDir%\Classes%FolderName%\%FileName%"
ECHO.


REM *******************************************************************************************************************
REM Create Class Meta File
REM *******************************************************************************************************************

CALL :CREATE_META_FILE "%SourceDir%\classes\meta\%MetaFileName%"
CALL :echoColor Cyan "Class meta file created: %SourceDir%\Classes\meta\%MetaFileName%"
ECHO.

REM complete if not creating test class
IF %TestClassSwitch%==0 GOTO COMPLETE


REM *******************************************************************************************************************
REM Create Test Class File
REM *******************************************************************************************************************

:CREATE_TEST_CLASS
REM set folder location where class will be created. TestClassSwitch 2 allows for specifying the folder name.
IF %TestClassSwitch%==2 (
	SET TestClassPathAndName = "%SourceDir%\classes\tests\%FolderName%\%TestFileName%"
) ELSE (
	SET TestClassPathAndName = "%SourceDir%\classes\tests\%TestFileName%"
)
REM Check if file exists
FOR %%b IN ("%TestClassPathAndName%") DO IF EXIST %%~sb GOTO TEST_EXISTS

CD "%SourceDir%\Classes\tests"
copy /y nul %TestFileName%

(	
	ECHO @isTest
	ECHO public class %ClassName%Test {
	ECHO %tab%static testMethod void Test^(^) {
	ECHO.
	ECHO %tab%%tab%Test.startTest^(^);
	ECHO.
	ECHO.
	ECHO %tab%%tab%Test.stopTest^(^);
	ECHO %tab%}
	ECHO }
) >%TestFileName%

CALL :echoColor Cyan "Test class file created: %SourceDir%\Classes\tests\%TestFileName%"
ECHO.


REM *******************************************************************************************************************
REM Create Test Class Meta File
REM *******************************************************************************************************************

CALL :CREATE_META_FILE "%SourceDir%\classes\tests\meta\%TestMetaFileName%"
CALL :echoColor Cyan "Test class meta file created: %SourceDir%\Classes\tests\meta\%TestMetaFileName%"
ECHO.
GOTO COMPLETE



REM *******************************************************************************************************************
REM Errors
REM *******************************************************************************************************************
:DIRECTORY_DOES_NOT_EXIST
ECHO.
CALL :echoColor white "the directory %SourceDir%\Classes%FolderName% does not exist."
CALL :echoColor white "Would you like to create it [y or n]"
SET /p CreateDir=": " %=%
IF /I "%CreateDir%"=="y" GOTO CREATE_DIRECTORY
GOTO END

:CREATE_DIRECTORY
MD "%SourceDir%\Classes%FolderName%"
GOTO CREATE_CLASS

:CLASSNAME_NOT_SPECIFIED
ECHO.
CALL :echoColor red "Error: the name of the class must be provided."
GOTO DISPLAY_USAGE

:CLASS_EXISTS
ECHO.
CALL :echoColor red "Error: The class already exists.  Please specify a new class name."
GOTO END

:META_EXISTS
ECHO.
CALL :echoColor red "Error: The meta file already exists."
GOTO END

:TEST_EXISTS
ECHO.
CALL :echoColor red "Error: The test class file already exists."
GOTO END

:INVALID_ARG_VALUE
ECHO.
CALL :echoColor red "Error: Invalid argument value or value not provided.  Argument values cannot begin with a slash '/'.
GOTO END

REM *******************************************************************************************************************
REM Routines
REM *******************************************************************************************************************

:CREATE_META_FILE
REM Check if file exists
FOR %%b IN ("%1") DO IF EXIST %%~sb GOTO META_EXISTS

CD "%SourceDir%\Classes\meta"
copy /y nul %1

(
	ECHO ^<?xml version="1.0" encoding="UTF-8"?^>
	ECHO ^<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata"^>
    ECHO 	^<apiVersion^>%Version%^</apiVersion^>
    ECHO 	^<status^>Active^</status^>
	ECHO ^</ApexClass^>
) >%1

GOTO :EOF


:DISPLAY_USAGE
@ECHO ...
ECHO Usage:
ECHO /n: required - the name of the class to create.
ECHO /s: optional - Determines if the test class should be created.  
ECHO %tab%%tab%Valid Values [0,1,2].  **the string, 'Test' will be appended to the className parameter (/n) provided.
ECHO %tab%%tab%%tab%0 - (default) do not create test class. 
ECHO %tab%%tab%%tab%1 - create test class 
ECHO %tab%%tab%%tab%2 - create only the test class, also allows the directory under $root/classes/tests to be specified using /f.
ECHO /f: optional - The direcotry path inside of $root/classes where the class file will be created.
ECHO %tab%%tab%Leading and trailing slashes will be automatically added.
ECHO %tab%%tab%Pass empty quotes to use the defualt directory.
ECHO %tab%%tab%sample creating a TestServices class: tests\testServices
ECHO /v: optional - the api version to use in the meta file.
ECHO /c: optional - denotes a controller class and adds MC_ControllerBase items.
ECHO %tab%%tab%Valid Values [0,1]
ECHO %tab%%tab%%tab%0 - (default) do not include MC_ControllerBase extension
ECHO %tab%%tab%%tab%1 - Include MC_ControllerBase extension
ECHO.
ECHO Example call including test class
ECHO %tab%createClass /n yourClassName /s 1
ECHO.
ECHO.
ECHO Example call including test and MC_ControllerBase extension
ECHO %tab%createClass /n yourClassName /s 1 /c 1
ECHO.
ECHO.
GOTO :END


REM *******************************************************************************************************************
REM Successful completion
REM *******************************************************************************************************************
:COMPLETE
ECHO.
ECHO.
CALL :echoColor Green "Class Creation Complete"
GOTO END

:END
ECHO.
CD "%ExecutingDir%"
EXIT /b 0


:echoColor
powershell -Command Write-Host "%2" -foregroundcolor %1