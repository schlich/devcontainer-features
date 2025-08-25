#!/bin/bash

set -e

source dev-container-features-test-lib

echo "$(npx playwright install --list)"

check "Multiple browsers" bash -c '[[ $(npx playwright install --list) == *firefox* ]]'
check "Multiple browsers" bash -c '[[ $(npx playwright install --list) == *chromium* ]]'

reportResults
