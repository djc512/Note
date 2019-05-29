NDK=/home/ubuntu/AtHome/androidndk/android-ndk-r12b
SYSROOT=$NDK/platforms/android-21/arch-arm64/
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64

#export CC="$TOOLCHAIN/bin/aarch64-linux-android-gcc"

OUTDIR=release

function build_one
{
./configure \
--enable-pic \
--enable-strip \
--enable-shared \
--cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
--sysroot=$SYSROOT \
--host=aarch64-linux \
--prefix=$OUTDIR

#--extra-ldflags="-Wl,-soname,libx264.so" \

make clean
mkdir $OUTDIR
sed -i 's/SONAME=libx264.so.148/SONAME=libx264.so/g' config.mak
make
make install

rm x264_arm64 -rf
rm $OUTDIR/bin -rf
mv $OUTDIR x264_arm64

}
build_one

