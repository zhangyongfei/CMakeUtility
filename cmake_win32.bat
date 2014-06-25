@echo off

SET CurDir=%CD%
SET PrjDir=%1
SET ToolsDir=%~dp0%

if not "%PrjDir%" == "" goto chechprjdir
SET PrjDir=%CurDir%

:chechprjdir
if exist %PrjDir% goto buildstart
echo.
echo Error: %PrjDir% not exist, build failure.
echo.
goto end

:buildstart
if exist %PrjDir%\build goto cmakeprj
md %PrjDir%\build

:cmakeprj
cd %PrjDir%\build
SET ToolsDir=%ToolsDir:\=/%
cmake -DCMAKE_TOOLCHAIN_FILE=%ToolsDir%CMakeUtility/CMakeUtility.cmake -DTOOLS_DIR=%ToolsDir%CMakeUtility .. && goto makeprj
cd %CurDir%
goto end

:makeprj
set FolderName=%PrjDir%\build
for /f "delims=\" %%a in ('dir /b /a-d /o-d "%FolderName%\*.sln"') do (
  start %PrjDir%\build\%%a
)
:end


