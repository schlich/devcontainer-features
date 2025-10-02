#!/bin/bash

set -e

# Install Playwright browsers
# If _REMOTE_USER is set and not root, install as that user
# Otherwise install as root (test scenarios)
if [ -n "${_REMOTE_USER}" ] && [ "${_REMOTE_USER}" != "root" ] && id -u "${_REMOTE_USER}" > /dev/null 2>&1; then
    su "${_REMOTE_USER}" -c "npx playwright install --with-deps ${BROWSERS}"
else
    npx playwright install --with-deps ${BROWSERS}
fi
