#!/bin/bash

set -e

source dev-container-features-test-lib

check "get version" npx playwright --version

reportResults
