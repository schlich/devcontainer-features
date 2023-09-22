#!/bin/sh

curl -L https://github.com/helmfile/helmfile/releases/download/v0.157.0/helmfile_0.157.0_linux_amd64.tar.gz | tar xz
chmod +x helmfile 
sudo mv helmfile /usr/local/bin
