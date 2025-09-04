#!/bin/bash

set -e

source dev-container-features-test-lib

check "binary in path" which starship

reportResults
