@echo off
rem This file is generated from build.pbat, all edits will be lost
rem path must not contain spaces
if %~dp0 equ foo echo 1
set PATH=C:\windows\system32;C:\windows;C:\Program Files\7-Zip;%~dp0mingw64\bin;C:\Strawberry\perl\bin;%~dp0Qt-5.15.2-mingw64\bin;%~dp0postgresql-14\bin;C:\mysql\lib;C:\Miniconda\python;C:\Miniconda\Scripts;%PATH%
pip install mugideploy

if exist "C:\Program Files\Git\mingw64\bin\curl.exe" set CURL=C:\Program Files\Git\mingw64\bin\curl.exe
if exist "C:\Windows\System32\curl.exe" set CURL=C:\Windows\System32\curl.exe
if not defined CURL goto curl_not_found_begin
goto download_begin

if exist "C:\Git\usr\bin\patch.exe" set PATCH=C:\Git\usr\bin\patch.exe
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH goto patch_not_found_begin
exit /b

:curl_not_found_begin
echo curl_not_found
exit /b

:patch_not_found_begin
echo patch_not_found
exit /b

:download_begin
pushd %~dp0
if not exist "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z" "%CURL%" -L -o "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z" https://storage.googleapis.com/qt-binaries/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z
if not exist "qtbase-everywhere-src-5.15.2.zip" "%CURL%" -L -o "qtbase-everywhere-src-5.15.2.zip" https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/qtbase-everywhere-src-5.15.2.zip
xcopy /s /q /y /i "C:\Program Files\PostgreSQL\14\bin" postgresql-14\bin
xcopy /s /q /y /i "C:\Program Files\PostgreSQL\14\include" postgresql-14\include
popd

pushd %~dp0
if not exist "mingw64" 7z x -y "x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z"
7z x -y "qtbase-everywhere-src-5.15.2.zip"
popd

pushd %~dp0
if "%SKIP_BASE%" neq "1" (
pushd qtbase-everywhere-src-5.15.2
del /f config.cache
call configure -prefix %~dp0Qt-5.15.2-mingw64 -opensource -confirm-license -shared -plugin-sql-odbc -plugin-sql-psql -plugin-sql-mysql -platform win32-g++ -opengl desktop -release -nomake tests -nomake examples MYSQL_PREFIX=C:\mysql MYSQL_INCDIR=C:\mysql\include MYSQL_LIBDIR=C:\mysql\lib PSQL_INCDIR=%~dp0postgresql-14\include PSQL_LIBDIR=%~dp0postgresql-14\bin
type qtbase-everywhere-src-5.15.2\config.log
mingw32-make -j2
mingw32-make install
popd
)
if not exist "Qt-5.15.2-mingw64.zip" 7z a -y "Qt-5.15.2-mingw64.zip" "Qt-5.15.2-mingw64"
mugideploy collect --dest qsqlmysql-mingw64 --skip Qt5Core.dll Qt5Sql.dll qt.conf --bin Qt-5.15.2-mingw64\plugins\sqldrivers\qsqlmysql.dll --no-vcredist
mugideploy collect --dest qsqlpsql-mingw64 --skip Qt5Core.dll Qt5Sql.dll qt.conf --bin Qt-5.15.2-mingw64\plugins\sqldrivers\qsqlpsql.dll --no-vcredist
if not exist "qsqlmysql-mingw64.zip" 7z a -y "qsqlmysql-mingw64.zip" "qsqlmysql-mingw64"
if not exist "qsqlpsql-mingw64.zip" 7z a -y "qsqlpsql-mingw64.zip" "qsqlpsql-mingw64"
popd


