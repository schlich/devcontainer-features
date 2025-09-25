#!/bin/bash

set -e

# Determine the appropriate non-root user
USERNAME="${USERNAME:-"${_REMOTE_USER:-"automatic"}"}"

if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    if [ -n "${_REMOTE_USER}" ] && [ "${_REMOTE_USER}" != "root" ]; then
        USERNAME="${_REMOTE_USER}"
    else
        USERNAME=""
        POSSIBLE_USERS=("vscode" "node" "codespace" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
        for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
            if [ -n "${CURRENT_USER}" ] && id -u ${CURRENT_USER} > /dev/null 2>&1; then
                USERNAME=${CURRENT_USER}
                break
            fi
        done
        if [ "${USERNAME}" = "" ]; then
            USERNAME=root
        fi
    fi
elif [ "${USERNAME}" = "none" ]; then
    USERNAME=root
fi

# Verify the user exists, if not, fall back to root
if [ "${USERNAME}" != "root" ] && ! id -u ${USERNAME} > /dev/null 2>&1; then
    echo "Warning: User ${USERNAME} does not exist, falling back to root."
    USERNAME=root
fi

# Install Playwright browsers as the determined user
if [ "${USERNAME}" = "root" ]; then
    npx playwright install --with-deps ${BROWSERS}
else
    su ${USERNAME} -c "npx playwright install --with-deps ${BROWSERS}"
fi
