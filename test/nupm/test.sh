#!/bin/bash
set -e 


source dev-container-features-test-lib

check "nupm installed" nu -c "use /usr/local/share/nupm/nupm/; nupm -h"

reportResults