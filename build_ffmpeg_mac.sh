#!/bin/bash
set -e

if [[ $# -lt 1 ]]
then
    echo "Syntax: $0 <ffmpeg_directory>" >&2
    exit 1
fi

FFMPEG_DIRECTORY="$1"

configure_ffmpeg_mac() {
    args=(
        --extra-cflags="-O2 -fPIC" \
        --disable-shared
        --enable-static
        --disable-programs
        --disable-doc
        --disable-swscale
        --disable-postproc
        --disable-avfilter
        --disable-avdevice
        --disable-network
        --disable-everything
        --enable-swresample
        --enable-decoder=h264
        --enable-decoder=hevc
        --enable-decoder=av1
        --enable-decoder=pcm_s16le
        --enable-decoder=opus
        --enable-decoder=aac
        --enable-decoder=png
        --enable-protocol=file
        --enable-demuxer=image2
        --enable-parser=png
        --enable-zlib
        --enable-muxer=matroska
        --enable-muxer=mp4
        --disable-vulkan
    )
    "$FFMPEG_DIRECTORY"/configure "${args[@]}"
}

cd "$FFMPEG_DIRECTORY"
make clean
configure_ffmpeg_mac
make -j
