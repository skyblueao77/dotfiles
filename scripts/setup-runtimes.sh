#!/usr/bin/env bash

set -euo pipefail

echo "Setting up development runtimes..."

# uv
if command -v uv >/dev/null 2>&1; then
    echo "OK: uv is already installed ($(uv --version))"
else
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Juliaup / Julia
if command -v juliaup >/dev/null 2>&1; then
    echo "OK: Juliaup is already installed ($(juliaup --version))"
else
    echo "Installing Juliaup..."
    curl -fsSL https://install.julialang.org | sh -s -- --yes
fi

# Starship
if command -v starship >/dev/null 2>&1; then
    echo "OK: Starship is already installed ($(starship --version | head -n 1))"
else
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
fi

echo
echo "Runtime setup complete."