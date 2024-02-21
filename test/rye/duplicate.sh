#!/bin/bash

set -e

source dev-container-features-test-lib

source "$HOME/.rye/env"
check "print rye version" bash -c "rye --version"

reportResults