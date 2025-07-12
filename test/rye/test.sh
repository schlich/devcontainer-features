#!/bin/bash

set -e

source dev-container-features-test-lib


check "env script exists" test -f /usr/local/lib/rye/env
check "rye version on bash" rye --version
check "Installs dependency in virtual environment" rye init . && rye add pytest && rye run pytest --version

reportResults