#!/bin/bash

set -e

source dev-container-features-test-lib

check "env script exists" bash -c "test -f /usr/local/share/rye/env"
check "rye version on bash" bash -c "rye --version"


reportResults