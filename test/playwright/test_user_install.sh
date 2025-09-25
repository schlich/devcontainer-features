#!/bin/bash

set -e

source dev-container-features-test-lib

# Test that browsers are installed in the non-root user's home directory
check "Browser cache exists in vscode home" test -d "/home/vscode/.cache/ms-playwright"
check "Browser cache not in root" ! test -d "/root/.cache/ms-playwright"

reportResults