@echo off

SET curdir=%CD%
SET basedir=%~dp0
SET curdir=%CD%
SET bindir=%basedir%\bin\

SET fileName=%~1
SET fileName=%fileName:/=\%
SET fileName=%fileName:.asm=%

mkdir %srcdir% >nul 2>&1
mkdir %outdir% >nul 2>&1
mkdir %bindir% >nul 2>&1

IF NOT EXIST "%fileName%.asm" GOTO SrcNotFound

REM parse asm app to obj
DEL "%fileName%.obj" >nul 2>&1
"%bindir%\nasm.exe" -f win32 "%fileName%.asm" -o "%fileName%.obj"

IF NOT EXIST "%fileName%.obj" GOTO ObjNotFound

REM link dependecies to app
DEL "%fileName%.exe" >nul 2>&1
"%bindir%\GoLink.exe" /console /entry _main /fo "%fileName%.exe" /ni "%fileName%.obj" "%bindir%\libw.obj" kernel32.dll  ucrtbase.dll

REM [UN]COMMENT TO delete .obj file
REM DEL "%outdir%\%fileName%.obj"

REM run the app
"%fileName%.exe"

REM [UN]COMMENT TO delete exe file
REM DEL "%outdir%\%fileName%.exe"
GOTO End

:SrcNotFound
ECHO "src file not found"
ECHO %srcdir%
GOTO End

:ObjNotFound
ECHO "cannot create object file"
GOTO End

:End
REM back to caller dir
CD /D %curdir%