#!/bin/sh

set -eu

if [ "$#" -eq 0 ]
then
	BUILD_TYPE=Debug
else
	BUILD_TYPE=$1
	shift
fi

: "${DEVKITPRO:?Set DEVKITPRO to the devkitPro installation directory}"

BUILD_DIR=Switch_$BUILD_TYPE

echo "Usage: ./cmake_switch.sh [Configuration] [additional CMake arguments]"
echo "Possible configurations: Debug (default), Release, Distribution"
echo "Generating Makefile for build type \"$BUILD_TYPE\" in folder \"$BUILD_DIR\""

cmake -S . -B "$BUILD_DIR" -G "Unix Makefiles" \
	-DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
	-DCMAKE_TOOLCHAIN_FILE="$DEVKITPRO/cmake/Switch.cmake" \
	-DTARGET_UNIT_TESTS=OFF \
	-DTARGET_HELLO_WORLD=ON \
	-DTARGET_PERFORMANCE_TEST=OFF \
	-DTARGET_SAMPLES=OFF \
	-DTARGET_VIEWER=OFF \
	-DINTERPROCEDURAL_OPTIMIZATION=OFF \
	-DJPH_USE_DX12=OFF \
	-DJPH_USE_VK=OFF \
	-DJPH_USE_MTL=OFF \
	-DJPH_USE_CPU_COMPUTE=OFF \
	"$@"

echo "Compile by running \"cmake --build $BUILD_DIR --target HelloWorld -j $(nproc)\""
