#!/bin/sh

if [ -z ${NDK_ROOT} ] ; then
echo "NDK_ROOT environment variable not set, build failure."
exit 1
fi

SET ANDROID_NDK=${NDK_ROOT}
SET ANDROID_ABI=armeabi-v7a
SET ANDROID_NATIVE_API_LEVEL=android-9

CurDir=`pwd`
PrjDir=$1
ToolsDir=$(dirname $0)

if [ -z ${PrjDir} ]; then
    PrjDir=`echo ${CurDir}`
fi

[ -d ${PrjDir} ]
if [ "$?" != "0" ]; then
    echo "${PrjDir} not exist, build failure."
	exit $?
fi

[ -d ${PrjDir}/build ]
if [ "$?" != "0" ]; then
    mkdir -p ${PrjDir}/build
fi

cd ${PrjDir}/build
cmake -G"MinGW Makefiles" -DANDROID=true -DIOS=false -DCMAKE_TOOLCHAIN_FILE=%ToolsDir%android-cmake/android.toolchain.cmake -DTOOLS_DIR=%ToolsDir%CMakeUtility -DCMAKE_MAKE_PROGRAM="%ANDROID_NDK%\prebuilt\windows\bin\make.exe" -DANDROID_ABI=%ANDROID_ABI% -DANDROID_NATIVE_API_LEVEL=%ANDROID_NATIVE_API_LEVEL% ..
if [ "$?" != "0" ]; then
    exit $?
fi

make

