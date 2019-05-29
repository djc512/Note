NDK=/home/chrisma/opt/android-ndk-r10e
SYSROOT=$NDK/platforms/android-9/arch-arm/
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

OUTDIR=release

function build_one
{
./configure \
--enable-pic \
--enable-strip \
--enable-static \
--enable-shared \
--cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
--sysroot=$SYSROOT \
--host=arm-linux \
--prefix=$OUTDIR \
--extra-cflags="-march=armv7-a -mfloat-abi=softfp -mfpu=neon" \


mkdir $OUTDIR
make clean
sed -i 's/SONAME=libx264.so.148/SONAME=libx264.so/g' config.mak
make
make install

rm x264_armv7a -rf
rm $OUTDIR/bin -rf
mv $OUTDIR x264_armv7a

#$CC -lm -lz -shared --sysroot=$SYSROOT -Wl,--no-undefined *.o common/*.o common/arm/*.o encoder/*.o filters/*.o filters/video/*.o  input/*.o output/*.o -o ./release/lib/libx264.so

#cp ./build/libx264.so ./build/libx264-debug.so
#$TOOLCHAIN/bin/arm-linux-androideabi-strip --strip-unneeded ./release/lib/libx264

}
build_one

