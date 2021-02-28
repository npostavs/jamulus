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
clang=/opt/android/android-ndk/toolchains/llvm/prebuilt/linux-x86_64/bin/clang
./configure --build=x86_64-linux --host=armv7a-linux-anrdoideabi21 CC=$clang CFLAGS='-target armv7a-linux-androideabi21' || cat config.log
echo .
echo .
echo .
echo .
cat config.h
echo .
echo .
echo .
echo .
./configure --build=x86_64-linux --host=aarch64-linux-anrdoideabi21 CC=$clang CFLAGS='-target aarch64-linux-android21' || cat config.log
echo .
echo .
echo .
echo .
cat config.h
echo .
echo .
echo .
echo .

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
