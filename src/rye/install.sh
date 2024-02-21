#!/bin/sh
set -e

curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" RYE_HOME="/usr/local/share/rye" bash
