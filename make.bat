@echo off

SET curdir=%CD%
SET basedir=%~dp0
SET srcdir=%basedir%\src\
SET outdir=%basedir%\out\
SET bindir=%basedir%\bin\

SET fileName=%~1
SET fileName=%fileName:/=\%
SET fileName=%fileName:.asm=%

mkdir %srcdir% >nul 2>&1
mkdir %outdir% >nul 2>&1
mkdir %bindir% >nul 2>&1

IF NOT EXIST "%srcdir%\%fileName%.asm" GOTO SrcNotFound

REM go to src dir to help nasm assembler find it's include src files
CD /D %srcdir%

REM parse asm app to obj
DEL "%outdir%\%fileName%.obj" >nul 2>&1
"%bindir%\nasm.exe" -f win32 "%srcdir%\%fileName%.asm" -o "%outdir%\%fileName%.obj"

IF NOT EXIST "%outdir%\%fileName%.obj" GOTO ObjNotFound

REM link dependecies to app
DEL "%outdir%\%fileName%.exe" >nul 2>&1
"%bindir%\GoLink.exe" /console /entry _main /fo "%outdir%\%fileName%.exe" /ni "%outdir%\%fileName%.obj" "%bindir%\libw.obj" kernel32.dll  ucrtbase.dll

REM [UN]COMMENT TO delete .obj file
DEL "%outdir%\%fileName%.obj"

REM run the app
"%outdir%\%fileName%.exe"

REM [UN]COMMENT TO delete exe file
DEL "%outdir%\%fileName%.exe"
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
