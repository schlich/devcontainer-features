#!/bin/bash

set -e

# Install system dependencies only
# Browser installation is handled by postCreateCommand to run as the user
npx playwright install-deps ${BROWSERS}
