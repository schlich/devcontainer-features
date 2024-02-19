#!/bin/sh
set -e

apt-get update
apt-get upgrade -y
apt-get install curl -y

curl -sSf https://rye-up.com/get | bash