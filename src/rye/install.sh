#!/bin/sh
set -e

if test -f /usr/local/lib/rye/env; then
  echo "Rye already installed!"
else
  if test -f /usr/local/bin/python; then
    curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" RYE_HOME="/usr/local/lib/rye" RYE_TOOLCHAIN="/usr/local/bin/python" bash
  else
    if test -f /usr/local/python/current/bin/python; then
        curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" RYE_HOME="/usr/local/lib/rye" RYE_TOOLCHAIN="/usr/local/python/current/bin/python" bash
    else
        curl -sSf https://rye-up.com/get | RYE_INSTALL_OPTION="--yes" RYE_HOME="/usr/local/lib/rye" bash
    fi
  fi
fi


/usr/local/lib/rye/shims/rye config --set-bool behavior.use-uv=${UV}
