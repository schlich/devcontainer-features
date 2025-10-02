#!/bin/bash

set -e

source dev-container-features-test-lib

# Test that Playwright is installed
check "Playwright is available" npx playwright --version

# Check that browsers are installed in user's home directory (not root)
CURRENT_USER=$(whoami)
USER_HOME=$(eval echo ~${CURRENT_USER})

# Verify browser cache exists in the user's home directory
check "Browser cache in user home" test -d "${USER_HOME}/.cache/ms-playwright"

# Verify the cache directory is owned by the current user
check "Browser cache owned by user" bash -c "[ \"\$(stat -c '%U' ${USER_HOME}/.cache/ms-playwright)\" = \"${CURRENT_USER}\" ]"

# Verify browsers are not installed in root directory (if we're not root)
if [ "${CURRENT_USER}" != "root" ]; then
    check "Browser cache not in root" bash -c "! test -d /root/.cache/ms-playwright || [ \"\$(ls -A /root/.cache/ms-playwright 2>/dev/null | wc -l)\" = \"0\" ]"
fi

# Test that browsers can be listed (validates installation)
check "Can list browsers" npx playwright install --list

# Verify the user can run playwright commands without permission issues
check "User can run playwright" bash -c 'npx playwright --help | grep -q "Usage"'

reportResults