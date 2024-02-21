#!/bin/bash

set -e

source dev-container-features-test-lib
npm init -y
check "cypress version" npx cypress --version

reportResults