#!/bin/sh
set -e

if rye --version; then
  echo "$(rye --version)"
else
  if python; then
    curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" RYE_TOOLCHAIN="$(which python)"  bash
  else
    curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
  fi
fi


/usr/local/lib/rye/shims/rye config --set-bool behavior.use-uv=${UV}
