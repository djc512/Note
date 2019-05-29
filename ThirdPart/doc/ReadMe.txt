1. openssl编译
1.1 编译linux库
1.1.1 如果是为本机编译，则直接运行config脚本文件，再执行make。
1.1.2 如果是交叉编译，则只能运行Configure脚本文件，建议参数是“linux-elf no-asm”，之后修改Makefile中的交叉编译工具链，再执行make。

1.2 编译windows库
1.2.1 打开visual studio 2008的command prompt控制台界面（如果编译不过，需要完善%INCLUDE%、%LIB%等编译相关系统变量的配置），cd到openssl的
主目录下（Configure文件当前目录）
1.2.2 执行perl Configure no-shared no-asm VC-WIN32
1.2.3 执行ms\do_ms
1.2.4 执行nmake -f ms\nt.mak
1.2.5 成功后，主目录下的inc32目录下包含后续使用的openssl头文件目录，out32目录下有相关的库文件libeay32.lib和ssleay32.lib

1.3 编译android库
1.3.1 执行Configure --openssldir=release no-asm no-shared android，生成Makefile
1.3.2 编辑修改Makefile文件，修改PLATFORM=android，修改CC、AR和RANLIB定义为对应的NDK文件路径,或者拷贝本文档当前目录下的openssl_android中的对应的Makefile并调整文件名
1.3.3 执行make，成功后当前目录下的include目录下包含后续使用的openssl头文件目录，当前目录下有相关的库文件libssl.a及libcrypto.a
1.3.4 各个平台配置参数:
        armeabi, Configure --openssldir=release no-asm no-shared android
        armv7a, Configure --openssldir=release no-shared android-armv7
        armv64, Configure --openssldir=release no-asm no-shared linux-aarch64
        x86, Configure --openssldir=release no-asm no-shared android-x86
        x86_64, Configure --openssldir=release no-asm no-shared linux-x86_64
        mips, Configure --openssldir=release no-asm no-shared android-mips
        mips64, Configure --openssldir=release no-asm no-shared linux64-mips64

2. ffmpeg编译
2.1 编译linux库

2.2 编译windows库
2.2.1 32位

2.2.2 64位
详见ffmpeg-build-x86_64.txt

2.3 编译android库
详见ffmpeg-build-android.sh

3. x264编译
3.1 编译linux库

3.2 编译windows库
3.2.1 32位
download & install msys2
pacman -S base-devel mingw-w64-i686-toolchain
pacman -S base-devel mingw-w64-x86_64-toolchain
./configure --host=i686-pc-mingw32 --enable-shared --enable-win32thread --extra-ldflags=-Wl,--output-def=libx264.def
lib /machine:x86 /def:libx264.def

3.2.2 64位

3.3 编译android库
详见本文档当前目录下的x264_android目录中对应的脚本