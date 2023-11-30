#!/bin/sh

curl -L https://github.com/jenkins-x/jx/releases/download/v3.10.112/jx-linux-amd64.tar.gz | tar xzv
chmod +x jx 
sudo mv jx /usr/local/bin
