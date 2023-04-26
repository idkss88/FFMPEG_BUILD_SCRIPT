#!/bin/bash

export NDK=/Users/admin/Library/Android/sdk/ndk-bundle
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64

function build_android
{

    ./configure \
        --prefix=$PREFIX \
        --disable-asm \
        --enable-neon  \
        --enable-hwaccels  \
        --enable-debug \
        --enable-gpl   \
        --disable-postproc \
        --disable-debug \
        --enable-small \
        --enable-jni \
        --enable-mediacodec \
        --enable-decoder=h264_mediacodec \
        --enable-decoder=hevc_mediacodec \
        --enable-decoder=mpeg4_mediacodec \
        --enable-hwaccel=h264_mediacodec \
        --enable-decoder=h264_mediacodec \
        --enable-static \
        --enable-pic \
        --enable-shared \
        --disable-doc \
        --enable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
        --disable-avdevice \
        --disable-doc \
        --disable-symver \
        --cross-prefix=$CROSS_PREFIX \
        --target-os=android \
        --arch=$ARCH \
        --cpu=$CPU \
        --cc=$CC \
        --cxx=$CXX \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        --extra-cflags="-Os  $OPTIMIZE_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS"

    make clean
    make -j16
    make install

    echo "============================ build android arm64-v8a success =========================="

}

#arm64-v8a
ARCH=arm64
CPU=armv8-a
API=30
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
PREFIX=$(pwd)/android/$CPU
OPTIMIZE_CFLAGS="-march=$CPU"

build_android
