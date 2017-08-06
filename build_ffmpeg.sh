#!/bin/sh

cd /tmp

# Update (again for some reason)
apt-get update

# Download the build dependencies for FFmpeg
apt-get build-dep -y ffmpeg

# Download the source for the exact version of FFmpeg you already have installed (not as root)
apt-get source ffmpeg

# Go into the ffmpeg source you just downloaded
cd ffmpeg-2.8.11

# Find out the exact command the ffmpeg was originally built with
ffmpeg -buildconf

# Copy the single line "configuration:" and pass it to ".configure" but add "--enable-nonfree --enable-nvenc --enable-libfdk-aac" on the end
# Mine looks like this:
./configure --prefix=/usr --extra-version=1ubuntu2 --build-suffix=-ffmpeg --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --cc=cc --cxx=g++ --enable-gpl --enable-shared --disable-stripping --disable-decoder=libopenjpeg --disable-decoder=libschroedinger --enable-avresample --enable-avisynth --enable-gnutls --enable-ladspa --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme --enable-libgsm --enable-libmodplug --enable-libmp3lame --enable-libopenjpeg --enable-libopus --enable-libpulse --enable-librtmp --enable-libschroedinger --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxvid --enable-libzvbi --enable-openal --enable-opengl --enable-x11grab --enable-libdc1394 --enable-libiec61883 --enable-libzmq --enable-frei0r --enable-libx264 --enable-libopencv --enable-nonfree --enable-libfdk-aac

# Now build it
make

# And finally install it over the original
make install
