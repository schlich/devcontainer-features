#!/bin/sh
set -e

apt-get update
apt-get upgrade -y
apt-get install curl -y

curl -sSf https://rye-up.com/get | bash

echo "source '$RYE_HOME/.rye/env'" >> $HOME/.bashrc