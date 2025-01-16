#!/bin/sh

# TODO: Support other OSes and ARCHes
# TODO: Support systems with curl but not wget
# TODO: Support systems with bsdtar but not tar

mkdir -p bin/

if [ ! -f bin/pandoc ]; then
  wget https://github.com/jgm/pandoc/releases/download/3.6.2/pandoc-3.6.2-linux-amd64.tar.gz -O pandoc.tar.gz
  tar -xf pandoc.tar.gz -C bin/ --strip-components=2 pandoc-3.6.2/bin/pandoc
  rm pandoc.tar.gz
fi

if [ ! -f bin/magick ]; then
  wget https://imagemagick.org/archive/binaries/magick -O bin/magick
  chmod u+x bin/magick
fi
