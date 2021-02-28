#!/bin/bash -e

# autobuild_2_build: actual build process


####################
###  PARAMETERS  ###
####################

source $(dirname $(readlink -f "${BASH_SOURCE[0]}"))/../ensure_THIS_JAMULUS_PROJECT_PATH.sh

###################
###  PROCEDURE  ###
###################

cd "${THIS_JAMULUS_PROJECT_PATH}"

cd libs/opus/
export TARGET=armv7a-linux-androideabi
export API=21

export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

echo "STARTING: ./configure --host=$TARGET"
if ./configure --host=$TARGET ; then
    echo "FAILED CONFIGURE $TARGET, config.log:"
    echo .
    echo .
    echo .
    cat config.log
else
    echo "SUCCEEDED CONFIGURE $TARGET, config.h:"
    echo .
    echo .
    echo .
    cat config.h
fi
echo .
echo .
echo .
echo .

export TARGET=armv7a-linux-androideabi
export API=21

export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

echo "STARTING: ./configure --host=$TARGET"

if ./configure --host=$TARGET ; then
    echo "FAILED CONFIGURE $TARGET, config.log:"
    echo .
    echo .
    echo .
    cat config.log
else
    echo "SUCCEEDED CONFIGURE $TARGET, config.h:"
    echo .
    echo .
    echo .
    cat config.h
fi

exit 1

#$QTDIR/bin/qmake -spec android-clang CONFIG+=$CONFIG
"${QTDIR}"/bin/qmake -spec android-clang CONFIG+=release
echo .
echo .
echo .
echo .
/opt/android/android-ndk/prebuilt/linux-x86_64/bin/make
echo .
echo .
echo .
echo .
"${ANDROID_NDK_ROOT}"/prebuilt/"${ANDROID_NDK_HOST}"/bin/make INSTALL_ROOT=android-build -f Makefile install
echo .
echo .
echo .
echo .
"${QTDIR}"/bin/androiddeployqt --input $(ls *.json) --output android-build --android-platform android-30 --jdk "${JAVA_HOME}" --gradle
