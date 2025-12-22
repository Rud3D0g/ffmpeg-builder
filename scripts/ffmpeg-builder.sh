#!/usr/bin/env bash
set -e

# Chris Shirley
# Based on the build direction at https://trac.ffmpeg.org/wiki/CompilationGuide/Cento

source "scripts/ansi_lib.sh"

ansi_yellow
echo "FFMPEG Sources download and build location: $FFMPEG_SOURCES"
echo "FFMPEG Binaries location: $FFMPEG_BUILD"
echo "FFMPEG bin location: $FFMPEG_BIN"
ansi_none

cd "$FFMPEG_SOURCES" || exit
tar xzvf ffmpeg-$FFMPEG_VERSION.tar.gz
cd ffmpeg-$FFMPEG_VERSION || exit
./configure \
  --prefix="$FFMPEG_BUILD" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$FFMPEG_BUILD/include -I/usr/local/cuda/include" \
  --extra-ldflags="-L$FFMPEG_BUILD/lib -L/usr/local/cuda/lib64" \
  --extra-libs=-lpthread \
  --extra-libs=-lm \
  --bindir="$FFMPEG_BIN" \
  --enable-gpl \
  --enable-libfdk_aac \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-nonfree \
  --enable-static \
  --enable-cuda-nvcc \
  --enable-libnpp \
  --enable-nvenc
make
make install

ansi_magenta
echo "******************************************************************"
echo "* BINARIES BUILT TO LOCATION: $FFMPEG_BIN"
echo "******************************************************************"
ansi_none
