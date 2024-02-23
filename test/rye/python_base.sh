#!/bin/bash

set -e

source dev-container-features-test-lib

echo "rye --version"

check "Uses uv" bash -c "rye --version | grep -q 'uv enabled: true'"

reportResults