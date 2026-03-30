#!/bin/bash

set -e

# Source nvm so npx is available during feature installation
# (containerEnv PATH additions from the node feature don't apply to install scripts)
export NVM_DIR="${NVM_DIR:-/usr/local/share/nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Playwright browsers
# If _REMOTE_USER is set and not root, install as that user
# Otherwise install as root (test scenarios)
if [ -n "${_REMOTE_USER}" ] && [ "${_REMOTE_USER}" != "root" ] && id -u "${_REMOTE_USER}" > /dev/null 2>&1; then
    su "${_REMOTE_USER}" -c "export NVM_DIR=\"${NVM_DIR}\"; [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"; npx playwright install --with-deps ${BROWSERS}"
else
    npx playwright install --with-deps ${BROWSERS}
fi
