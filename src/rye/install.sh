#!/bin/sh
set -e

apt-get install curl

if test -f /usr/local/lib/rye/env; then
  echo "Rye already installed!"
else
  if python; then
    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" RYE_HOME="/usr/local/lib/rye" RYE_TOOLCHAIN="$(which python)" bash
  else
    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" RYE_HOME="/usr/local/lib/rye" bash
  fi
fi


/usr/local/lib/rye/shims/rye config --set-bool behavior.use-uv=${UV}
