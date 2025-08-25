#!/bin/bash

set -e

source dev-container-features-test-lib

check "Chromium missing" bash -c '[[ $(npx playwright install --list) != *chromium* ]]'

reportResults
