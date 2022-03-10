@echo off
rem This file is generated from build2.pbat, all edits will be lost
rem path must not contain spaces
set LLVM_INSTALL_DIR=%~dp0libclang
set PATH=C:\windows\system32;C:\windows;C:\Program Files\7-Zip;%~dp0mingw64\bin;%~dp0cmake-3.22.0-windows-x86_64\bin;C:\Strawberry\perl\bin;%~dp0Qt-5.15.2-mingw64\bin;%~dp0libclang\bin;%~dp0mysql-8.0.25-winx64\lib;%~dp0mysql-8.0.25-winx64\bin;%~dp0postgresql-14.2\bin

if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL goto curl_not_found_begin

if exist "C:\Git\usr\bin\patch.exe" set PATCH=C:\Git\usr\bin\patch.exe
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH goto patch_not_found_begin
goto download_begin

:curl_not_found_begin
echo curl_not_found
exit /b

:patch_not_found_begin
echo patch_not_found
exit /b

:download_begin
pushd %~dp0
if not exist "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z" "%CURL%" -L -o "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z" https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z
if not exist "qtbase-everywhere-src-5.15.2.zip" "%CURL%" -L -o "qtbase-everywhere-src-5.15.2.zip" https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtbase-everywhere-src-5.15.2.zip
popd

pushd %~dp0
if not exist "mingw64" 7z x -y "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z"
if not exist "qtbase-everywhere-src-5.15.2" 7z x -y "qtbase-everywhere-src-5.15.2.zip"
popd

pushd %~dp0
if "%SKIP_BASE%" neq "1" (
pushd qtbase-everywhere-src-5.15.2
del /f config.cache
call configure -prefix %~dp0Qt-5.15.2-mingw64 -opensource -confirm-license -shared -plugin-sql-odbc -plugin-sql-mysql -plugin-sql-psql -platform win32-g++ -opengl desktop -release -nomake tests MYSQL_PREFIX=%~dp0mysql-8.0.25-winx64 MYSQL_INCDIR=%~dp0mysql-8.0.25-winx64\include MYSQL_LIBDIR=%~dp0mysql-8.0.25-winx64\lib PSQL_INCDIR=%~dp0postgresql-14.2\include PSQL_LIBDIR=%~dp0postgresql-14.2\bin
mingw32-make -j4
mingw32-make install
popd
)
del /f Qt-5.15.2-mingw64.zip
if not exist "Qt-5.15.2-mingw64.zip" 7z a -y "Qt-5.15.2-mingw64.zip" "Qt-5.15.2-mingw64"
popd
exit /b

start %~dp0QtCreator-6.0.2-mingw64\bin\qtcreator.exe


