#!/bin/bash

ARCH=$1

source config.sh $ARCH
LIBS_DIR=$(cd `dirname $0`; pwd)/libs/ffmpeg-merge
echo "LIBS_DIR="$LIBS_DIR

cd ffmpeg-2.3.6

PLATFORM=$ANDROID_NDK_ROOT/platforms/$AOSP_API/$AOSP_ARCH
TOOLCHAIN=$ANDROID_NDK_ROOT/toolchains/$TOOLCHAIN_BASE-$AOSP_TOOLCHAIN_SUFFIX/prebuilt/linux-x86_64

PREFIX=$LIBS_DIR/$AOSP_ABI

##可根据自己需要配置
./configure \
--prefix=$PREFIX \
--enable-cross-compile \
--disable-runtime-cpudetect \
--disable-asm \
--arch=$AOSP_ABI \
--target-os=android \
--cc=$TOOLCHAIN/bin/$TOOLNAME_BASE-gcc \
--cross-prefix=$TOOLCHAIN/bin/$TOOLNAME_BASE- \
--disable-stripping \
--nm=$TOOLCHAIN/bin/$TOOLNAME_BASE-nm \
--sysroot=$PLATFORM \
--disable-shared \ 
--enable-static \
--enable-pic \
--disable-debug \ 
--disable-network \ 
--disable-programs \
--disable-doc \
--disable-encoders \ 
--disable-avfilter \
--disable-decoders \
--disable-hwaccels \
--disable-muxers \
--disable-demuxers \ 
--disable-parsers  \
--disable-bsfs \
--disable-protocols \ 
--disable-indevs \
--disable-outdevs \
--disable-devices \
--disable-filters \
--disable-everything \ 
--enable-decoder=h264 \
--enable-decoder=hevc \
--enable-decoder=aac \
--enable-memalign-hack \
--extra-cflags="$FF_EXTRA_CFLAGS  $FF_CFLAGS" \
--extra-ldflags=""

make clean
make -j8
make install

#合并
$TOOLCHAIN/bin/$TOOLNAME_BASE-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$PREFIX/lib -soname libffmpeg.a -shared -nostdlib -Bsymbolic --whole-archive --no-undefined -o $PREFIX/libffmpeg.a \
    libavcodec/libavcodec.a \
    libavfilter/libavfilter.a \
    libswresample/libswresample.a \
    libavformat/libavformat.a \
    libavutil/libavutil.a \
    libswscale/libswscale.a \
    libpostproc/libpostproc.a \
    libavdevice/libavdevice.a \
    -lc -lm -lz -ldl -llog --dynamic-linker=/system/bin/linker $TOOLCHAIN/lib/gcc/$TOOLNAME_BASE/4.9/libgcc.a

cd ..
