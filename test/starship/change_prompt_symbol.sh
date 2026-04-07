#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

env


check "success symbol modified" starship print-config character | grep ➜ 
check "error symbol modified" starship print-config character | grep ✗ 

reportResults
