@echo off

if not "%NDK_ROOT%" == "" goto start
echo Error:NDK_ROOT environment variable not set, build failure.
goto end

:start
SET ANDROID_NDK=%NDK_ROOT%
SET ANDROID_ABI=armeabi-v7a
SET ANDROID_NATIVE_API_LEVEL=android-9

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
if exist %PrjDir%\androidbuild goto cmakeprj
md %PrjDir%\androidbuild

:cmakeprj
cd %PrjDir%\androidbuild
SET ToolsDir=%ToolsDir:\=/%
cmake -G"MinGW Makefiles" -DANDROID=true -DCMAKE_TOOLCHAIN_FILE=%ToolsDir%android-cmake/android.toolchain.cmake -DTOOLS_DIR=%ToolsDir%CMakeUtility -DCMAKE_MAKE_PROGRAM="%ANDROID_NDK%\prebuilt\windows\bin\make.exe" -DANDROID_ABI=%ANDROID_ABI% -DANDROID_NATIVE_API_LEVEL=%ANDROID_NATIVE_API_LEVEL% .. && goto makeprj
goto end

:makeprj
"%ANDROID_NDK%\prebuilt\windows\bin\make.exe"
cd %CurDir%

:end