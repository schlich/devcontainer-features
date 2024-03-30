#!/bin/sh
set -e

if rye --version; then
  echo "$(rye --version)"
else
  if python; then
    curl -sSf https://rye-up.com/get | RYE_TOOLCHAIN="$(which python)"  bash
  else
    curl -sSf https://rye-up.com/get | bash
  fi
fi


/usr/local/lib/rye/shims/rye config --set-bool behavior.use-uv=${UV}
