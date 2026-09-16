#!/usr/bin/env bash

set -euo pipefail

# Latest LTS major adopted by this environment.
# Update this value when a newer Node.js release becomes LTS
# and compatibility has been confirmed.
NODE_LTS_MAJOR=24

echo "Setting up Node.js ${NODE_LTS_MAJOR}.x LTS..."

if command -v node >/dev/null 2>&1; then
    CURRENT_MAJOR="$(node --version | sed 's/^v//' | cut -d. -f1)"

    if [ "$CURRENT_MAJOR" = "$NODE_LTS_MAJOR" ]; then
        echo "OK: Node.js $(node --version) is already installed."
        echo "OK: npm $(npm --version)"
        exit 0
    fi

    echo "Current Node.js: $(node --version)"
    echo "Target LTS major: ${NODE_LTS_MAJOR}.x"
fi

echo "Configuring NodeSource repository for Node.js ${NODE_LTS_MAJOR}.x..."

curl -fsSL "https://deb.nodesource.com/setup_${NODE_LTS_MAJOR}.x" | sudo -E bash -

echo "Installing Node.js..."
sudo apt install -y nodejs

echo
echo "Installed versions:"
node --version
npm --version

echo
echo "Node.js LTS setup complete."