#!/bin/bash

set -e

source dev-container-features-test-lib

# Test that Playwright installs correctly
check "Playwright is available" npx playwright --version

# Check that we can list browsers (this means the installation worked)
check "Can list browsers" npx playwright install --list

# Verify the feature works with basic commands
check "Basic playwright functionality" bash -c 'npx playwright --help | grep -q "Usage"'

reportResults