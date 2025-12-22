FROM nvcr.io/nvidia/cuda:12.9.1-cudnn-devel-ubi9

ENV FFMPEG_SOURCES="/root/ffmpeg_sources"
ENV FFMPEG_BUILD="/root/ffmpeg_build"
ENV FFMPEG_BIN="/root/bin"
ENV PATH="$FFMPEG_BIN:$PATH"
ENV PKG_CONFIG_PATH="$FFMPEG_BUILD/lib/pkgconfig:/usr/local/lib/pkgconfig"
ENV FFMPEG_VERSION="8.0.1"
RUN dnf -y update
RUN dnf install -y autoconf automake diffutils bzip2 bzip2-devel \
    cmake freetype-devel gcc gcc-c++ git libtool make pkgconfig zlib-devel

COPY scripts scripts
RUN chmod +x scripts
RUN mkdir -p $FFMPEG_SOURCES
RUN scripts/downloader.sh
RUN if [ $? -ne 0 ]; then echo "FFmpeg build process failed"; exit 1; fi
RUN scripts/prereq-builder.sh
RUN if [ $? -ne 0 ]; then echo "FFmpeg build process failed"; exit 1; fi
RUN scripts/ffmpeg-builder.sh
RUN if [ $? -ne 0 ]; then echo "FFmpeg build process failed"; exit 1; fi
