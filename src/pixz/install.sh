#!/usr/bin/sh

wget -qO- https://github.com/vasi/pixz/releases/download/v1.0.7/pixz-1.0.7.tar.gz | tar xz
cd pixz-1.0.7
./configure
make
make install