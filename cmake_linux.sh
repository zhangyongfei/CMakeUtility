#!/bin/sh

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
cmake -DPRJOUTPUT=%PrjOutput% -DANDROID=false -DIOS=false -DCMAKE_TOOLCHAIN_FILE=${ToolsDir}/CMakeUtility/CMakeUtility.cmake -DTOOLS_DIR=${ToolsDir}/CMakeUtility ..
if [ "$?" != "0" ]; then
    exit $?
fi

make

