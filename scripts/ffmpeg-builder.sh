#!/usr/bin/env bash

# Chris Shirley
# Based on the build direction at https://trac.ffmpeg.org/wiki/CompilationGuide/Cento

source "scripts/ansi_lib.sh"

ansi_yellow
echo "FFMPEG Sources download and build location: $FFMPEG_SOURCES"
echo "FFMPEG Binaries location: $FFMPEG_BUILD"
echo "FFMPEG bin location: $FFMPEG_BIN"
ansi_none

cd "$FFMPEG_SOURCES" || exit
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg || exit
./configure \
  --prefix="$FFMPEG_BUILD" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$FFMPEG_BUILD/include" \
  --extra-ldflags="-L$FFMPEG_BUILD/lib" \
  --extra-libs=-lpthread \
  --extra-libs=-lm \
  --bindir="$FFMPEG_BIN" \
  --enable-gpl \
  --enable-libfdk_aac \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-nonfree \
  --enable-static
make
make install

ansi_magenta
echo "******************************************************************"
echo "* BINARIES BUILT TO LOCATION: $FFMPEG_BIN"
echo "******************************************************************"
ansi_none
