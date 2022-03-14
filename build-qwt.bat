@echo off
rem This file is generated from build-qwt.pbat, all edits will be lost
set PATH=C:\windows\system32;C:\windows;C:\Program Files\7-Zip;%~dp0mingw64\bin;%~dp0Qt-5.15.2-mingw64\bin;C:\Program Files\Git\cmd;C:\Miniconda\python;C:\Miniconda\Scripts;%PATH%

if exist "C:\Git\usr\bin\patch.exe" set PATCH=C:\Git\usr\bin\patch.exe
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH goto patch_not_found_begin
goto fetch_begin

:patch_not_found_begin
echo patch not found
exit /b

:fetch_begin
if not exist qwt-6.2.0.zip curl -L -o qwt-6.2.0.zip https://storage.googleapis.com/qt-binaries/qwt-6.2.0.zip
if not exist qwt-6.2.0 7z x -y qwt-6.2.0.zip
pushd qwt-6.2.0
"%PATCH%" -p1 < %~dp00001-install-dest.patch
popd

pushd qwt-6.2.0
qmake "CONFIG+=release" QWT_INSTALL_PREFIX=%~dp0Qwt-6.2.0-mingw64
mingw32-make -j2 release
mingw32-make install
popd

if not exist Qwt-6.2.0-mingw64.zip 7z a -y Qwt-6.2.0-mingw64.zip Qwt-6.2.0-mingw64


