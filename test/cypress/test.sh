#!/bin/bash

set -e

source dev-container-features-test-lib
npm init -y
check "cypress version" npm run cypress --version

reportResults