@echo off
setlocal EnableDelayedExpansion
SET UG_VERSION=NX12



CALL C:\ProgramData\NX_BASE\%UG_VERSION%\%UG_VERSION%_STANDARD_VARIABLES.BAT

set UGII_UGMGR_HTTP_URL=http://sednt1806:8484/tc
set UGII_UGMGR_COMMUNICATION=HTTP
set ORIG_HOME=%HOME%
SET RMISERVER=RMISERVER
REM SET UGII_JVM_OPTIONS=-XX:MaxPermSize=384M -Xms1024M -Xmx2048M -agentlib:jdwp=transport=dt_socket,address=8001,server=y,suspend=n

SET HOME=C:\ProgramData\YAPP
set FMS_HOME=%~dp0\fms
SET PATH=!UGII_BASE_DIR!\NXBIN;%FMS_HOME%\lib;%PATH%
SET PATH=%PATH%;%ORIG_HOME%\bin\PortableGit\bin
SET PATH=%PATH%;%ORIG_HOME%\bin\nvim-win64\nvim-win64\bin
SET PATH=%PATH%;%ORIG_HOME%\bin\ripgrep-13.0.0-x86_64-pc-windows-gnu\ripgrep-13.0.0-x86_64-pc-windows-gnu
SET PATH=%PATH%;%ORIG_HOME%\bin\winlibs-x86_64-posix-seh-gcc-12.1.0-mingw-w64ucrt-10.0.0-r3\mingw64\bin

REM start C:\Users\yh6032\HOME\bin\nvim-win64\nvim-win64\bin\nvim.exe
start nvim.exe
