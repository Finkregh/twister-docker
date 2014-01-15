#!/bin/bash
git clone https://github.com/miguelfreitas/twister-core.git
cd twister-core/libtorrent
./bootstrap.sh --with-boost-libdir=/usr/lib/x86_64-linux-gnu
./configure --enable-logging --enable-debug --enable-dht
cd ../src
make -f makefile.unix
