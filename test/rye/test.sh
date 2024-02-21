#!/bin/bash

set -e

source dev-container-features-test-lib

check "env script exists" bash -c "test -f /usr/local/share/rye/env"
check "rye version" bash -c "rye --version"
check "rye version" zsh -c "rye --version"
check "Uses uv" bash -c "rye --version | grep -q 'uv enabled: true'"

reportResults