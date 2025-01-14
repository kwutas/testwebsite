#!/bin/sh

# TODO: Support other OSes and ARCHes
# TODO: Support systems with curl but not wget
# TODO: Support systems with bsdtar but not tar

wget https://github.com/jgm/pandoc/releases/download/3.6.2/pandoc-3.6.2-linux-amd64.tar.gz -O pandoc.tar.gz
mkdir pandoc/
tar -xf pandoc.tar.gz -C pandoc/ --strip-components=1
rm pandoc.tar.gz
