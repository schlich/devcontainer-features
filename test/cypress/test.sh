#!/bin/bash

set -e

source dev-container-features-test-lib
check "cypress version" npm run cypress --version

reportResults