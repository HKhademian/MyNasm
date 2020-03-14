@echo off

SET curdir=%CD%
SET basedir=%~dp0
SET bindir=%basedir%\bin\

SET fileName=%~1
SET fileName=%fileName:/=\%
SET fileName=%fileName:.asm=%

IF NOT EXIST "%fileName%.asm" GOTO SrcNotFound

REM parse asm app to obj
DEL "%fileName%.obj" >nul 2>&1
"%bindir%\nasm.exe" -f win32 "%fileName%.asm" -o "%fileName%.obj"

IF NOT EXIST "%fileName%.obj" GOTO ObjNotFound

REM link dependecies to app
DEL "%fileName%.exe" >nul 2>&1
"%bindir%\GoLink.exe" /console /entry main /fo "%fileName%.exe" /ni "%fileName%.obj" "%bindir%\libw.obj" kernel32.dll  ucrtbase.dll

REM [UN]COMMENT TO delete .obj file
DEL "%fileName%.obj" >nul 2>&1

IF NOT EXIST "%fileName%.exe" GOTO ExeNotFound

REM run the app
"%fileName%.exe"

REM [UN]COMMENT TO delete exe file
DEL "%fileName%.exe" >nul 2>&1
GOTO End

:SrcNotFound
	ECHO src file not found
	GOTO End

:ObjNotFound
	ECHO cannot create object file
	GOTO End

:ExeNotFound
	ECHO cannot create excutable file
	GOTO End

:End
	REM back to caller dir
	CD /D %curdir%
