NDK=/home/ubuntu/AtHome/androidndk/android-ndk-r12b
SYSROOT=$NDK/platforms/android-21/arch-x86_64/
TOOLCHAIN=$NDK/toolchains/x86_64-4.9/prebuilt/linux-x86_64

CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-

OUTDIR=release

function build_one
{
./configure \
--enable-pic \
--enable-strip \
--enable-shared \
--cross-prefix=$CROSS_PREFIX \
--sysroot=$SYSROOT \
--host=x86_64-linux \
--prefix=$OUTDIR \
--extra-cflags=""
#--disable-asm

make clean
mkdir $OUTDIR
sed -i 's/SONAME=libx264.so.148/SONAME=libx264.so/g' config.mak

make
make install

rm x264_x86_64  -rf
rm $OUTDIR/bin -rf
mv $OUTDIR x264_x86_64 

#$CC -lm -lz -shared --sysroot=$SYSROOT -Wl,--no-undefined *.o common/*.o common/arm/*.o encoder/*.o filters/*.o filters/video/*.o  input/*.o output/*.o -o ./release/lib/libx264.so

#cp ./build/libx264.so ./build/libx264-debug.so
#$TOOLCHAIN/bin/arm-linux-androideabi-strip --strip-unneeded ./release/lib/libx264

}
build_one

