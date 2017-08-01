#!/bin/bash
export TMPDIR=I:/document/resourceCode/ffmpeg-3.2.5/ffmpegtemp #���ñ�������ʱ�ļ�Ŀ¼����Ȼ�ᱨ�� unable to create temporary file
# NDK��·���������Լ��İ�װλ�ý�������
NDK=I:/soft/android-ndk-r14b
# ������Ե�ƽ̨�����Ը����Լ��������������
# ����ѡ�����֧��android-14, arm�ܹ������ɵ�so���Ƿ���
# libs/armeabi�ļ����µģ������x86�ܹ���Ҫѡ��arch-x86
PLATFORM=$NDK/platforms/android-21/arch-arm64
# PLATFORM=$NDK/platforms/android-21/arch-arm
# ��������·�������ݱ����ƽ̨��ͬ����ͬ
# arm-linux-androideabi-4.9���������õ�PLATFORM��Ӧ��4.9Ϊ���ߵİ汾�ţ�
# �����Լ���װ��NDK�汾��ȷ����һ��ʹ�����µİ汾
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/windows-x86_64

INC=I:/document/resourceCode/ffmpeg-3.2.5/mylib/arm64-v8a
FF_EXTRA_CFLAGS="-O3 -DANDROID -march=armv8-a"
FF_CFLAGS="-Wall -pipe \
-ffast-math \
-fstrict-aliasing -Werror=strict-aliasing \
-Wno-psabi -Wa,--noexecstack \
-DANDROID  \
-I$INC/include -I$INC/include/fdk-aac "

CPU=armv8-a
PREFIX=./android/$CPU-vfp

build_one(){
./configure \
--prefix=$PREFIX \
--enable-cross-compile \
--disable-runtime-cpudetect \
--disable-asm \
--arch=aarch64 \
--target-os=android \
--cc=$TOOLCHAIN/bin/aarch64-linux-android-gcc \
--cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
--disable-stripping \
--nm=$TOOLCHAIN/bin/aarch64-linux-android-nm \
--sysroot=$PLATFORM \
--enable-gpl \
--enable-shared \
--disable-static \
--enable-version3 \
--enable-pthreads \
--enable-small \
--disable-vda \
--disable-iconv \
--disable-encoders \
--enable-libx264 \
--enable-neon \
--enable-yasm \
--enable-libfdk_aac \
--enable-encoder=libx264 \
--enable-encoder=libfdk_aac \
--enable-encoder=mjpeg \
--enable-encoder=png \
--enable-nonfree \
--enable-muxers \
--enable-muxer=mov \
--enable-muxer=mp4 \
--enable-muxer=aac \
--enable-muxer=h264 \
--enable-muxer=avi \
--disable-decoders \
--enable-decoder=aac \
--enable-decoder=aac_latm \
--enable-decoder=h264 \
--enable-decoder=mpeg4 \
--enable-decoder=mjpeg \
--enable-decoder=png \
--disable-demuxers \
--enable-demuxer=image2 \
--enable-demuxer=h264 \
--enable-demuxer=aac \
--enable-demuxer=avi \
--enable-demuxer=mpc \
--enable-demuxer=mov \
--disable-parsers \
--enable-parser=aac \
--enable-parser=ac3 \
--enable-parser=h264 \
--disable-protocols \
--enable-protocol=file \
--enable-zlib \
--enable-avfilter \
--disable-outdevs \
--disable-ffprobe \
--disable-ffplay \
--disable-ffmpeg \
--disable-ffserver \
--disable-debug \
--disable-ffprobe \
--disable-ffplay \
--disable-ffmpeg \
--disable-postproc \
--disable-avdevice \
--disable-symver \
--disable-stripping \
--extra-cflags="$FF_CFLAGS $FF_EXTRA_CFLAGS" \
--extra-ldflags="-Wl,-L$INC/lib"
}
build_one
make clean
make -j8
make install

