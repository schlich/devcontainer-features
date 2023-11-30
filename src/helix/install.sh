#!/bin/sh

curl -LO https://github.com/helix-editor/helix/releases/download/23.05/helix-23.05-x86_64-linux.tar.xz
tar xf helix-23.05-x86_64-linux.tar.xz
chmod +x helix-23.05-x86_64-linux/hx
mv helix-23.05-x86_64-linux/hx /usr/local/bin
