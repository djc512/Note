#!/bin/bash
OUT_DIR=./out

export PATH=$PATH:/home/ubuntu/AtHome/androidndk/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
PLATFORM=/home/ubuntu/AtHome/androidndk/android-ndk-r10e/platforms/android-9/arch-arm

./configure --arch=arm --target-os=android --cross-prefix=arm-linux-androideabi- --enable-cross-compile --enable-shared  --enable-pic --prefix=$OUT_DIR --disable-debug --disable-network --disable-programs --disable-doc --disable-encoders --disable-avfilter --disable-decoders --disable-hwaccels --disable-muxers --disable-demuxers --disable-parsers --disable-bsfs --disable-protocols --disable-indevs --disable-outdevs --disable-devices --disable-filters --disable-everything --enable-decoder=h264 --enable-decoder=hevc --enable-decoder=aac --enable-memalign-hack --sysroot=$PLATFORM --extra-cflags="-march=armv7-a -mfpu=neon -mfloat-abi=softfp -mvectorize-with-neon-quad" --extra-ldflags="-Wl,--fix-cortex-a8" --nm=arm-linux-androideabi-nm 


make clean
make -j$(nproc) 
make install

echo to remove not used *.o files

rm libavcodec/log2_tab.o
rm libswresample/log2_tab.o
rm libswscale/log2_tab.o
rm libavcodec/reverse.o

arm-linux-androideabi-gcc --sysroot=$PLATFORM -shared -Wl,--no-undefined -lc -lm -ldl libavutil/*.o libavutil/arm/*.o libavcodec/*.o libavcodec/arm/*.o libswresample/*.o libswresample/arm/*.o libswscale/*.o libswscale/arm/*.o compat/*.o -o $OUT_DIR/libffmpeg.so

echo to strip unneeded
arm-linux-androideabi-strip --strip-unneeded $OUT_DIR/libffmpeg.so

echo finished

