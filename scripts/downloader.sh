#!/usr/bin/env bash

# Chris Shirley
# Based on the build direction at https://trac.ffmpeg.org/wiki/CompilationGuide/Cento

source "scripts/ansi_lib.sh"

ansi_yellow
echo "FFMPEG Sources download and build location: $FFMPEG_SOURCES"
ansi_none

cd "$FFMPEG_SOURCES" || exit
curl -O -L https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2
curl -O -L https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
git clone --depth 1 https://github.com/mstorsjo/fdk-aac
curl -O -L https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
curl -O -L https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz
curl -O -L https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
