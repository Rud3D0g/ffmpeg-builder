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
tar xjvf nasm-2.15.05.tar.bz2
cd nasm-2.15.05 || exit
./autogen.sh
./configure --prefix="$FFMPEG_BUILD" --bindir="$FFMPEG_BIN"
make
make install

cd "$FFMPEG_SOURCES" || exit
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0 || exit
./configure --prefix="$FFMPEG_BUILD" --bindir="$FFMPEG_BIN"
make
make install

cd "$FFMPEG_SOURCES/fdk-aac" || exit
autoreconf -fiv
./configure --prefix="$FFMPEG_BUILD" --disable-shared
make
make install

cd "$FFMPEG_SOURCES" || exit
tar xzvf lame-3.100.tar.gz
cd lame-3.100 || exit
./configure --prefix="$FFMPEG_BUILD" --bindir="$FFMPEG_BIN" --disable-shared --enable-nasm
make
make install

cd "$FFMPEG_SOURCES" || exit
tar xzvf opus-1.3.1.tar.gz
cd opus-1.3.1 || exit
./configure --prefix="$FFMPEG_BUILD" --disable-shared
make
make install
