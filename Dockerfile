FROM registry.access.redhat.com/ubi9/ubi

ENV FFMPEG_SOURCES="/root/ffmpeg_sources"
ENV FFMPEG_BUILD="/root/ffmpeg_build"
ENV FFMPEG_BIN="/root/bin"
ENV PATH="$FFMPEG_BIN:$PATH"
ENV PKG_CONFIG_PATH="$FFMPEG_BUILD/lib/pkgconfig"
RUN dnf install -y autoconf automake diffutils bzip2 bzip2-devel cmake freetype-devel gcc gcc-c++ git libtool make pkgconfig zlib-devel

COPY scripts scripts
RUN chmod +x scripts
RUN mkdir -p $FFMPEG_SOURCES
RUN scripts/downloader.sh
RUN scripts/prereq-builder.sh
RUN scripts/ffmpeg-builder.sh
