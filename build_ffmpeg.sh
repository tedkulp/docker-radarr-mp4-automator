#!/bin/sh

cd /tmp

mkdir build

cd build

# Update (again for some reason)
apt-get update

# Install the deps for building the deb version of ffmpeg
apt-get build-dep -y ffmpeg

# Download the dev and build tools
apt-get install -y build-essential fakeroot devscripts

# Download the ffmpeg source files, patches and debian specific stuff
apt-get source ffmpeg

cd ffmpeg-3.4.6

# Add in our patch to add the three flags for nonfree, nvenc and libdfk-aac
patch debian/rules < /rules.patch

# Do the build (this could take a LONG time)
debuild -us -uc -i -I

cd ..

# Install the debs (except extra and docs...  we don't have the depgs for them anyway)
find *.deb | grep -v "\-extra" | grep -v "\-doc" | xargs dpkg -i

cd ..

# Cleanup -- the imagine is huge if we don't
rm -fr build
