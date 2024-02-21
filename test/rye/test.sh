#!/bin/bash

set -e

source dev-container-features-test-lib

check "print rye version" bash -c "rye --version"

reportResults