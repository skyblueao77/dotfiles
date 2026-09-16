#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo " WSL Development Environment Bootstrap"
echo "========================================"
echo

run_step() {
    local name="$1"
    local script="$2"

    echo
    echo "----------------------------------------"
    echo " $name"
    echo "----------------------------------------"

    "$SCRIPT_DIR/$script"

    echo
    echo "OK: $name"
}

run_step "Installing base packages" "packages.sh"
run_step "Setting up Node.js LTS" "setup-node.sh"
run_step "Setting up development runtimes" "setup-runtimes.sh"
run_step "Setting up dotfile links" "setup-links.sh"

echo
echo "========================================"
echo " Bootstrap complete"
echo "========================================"
echo
echo "Next steps:"
echo "  1. Restart the shell:"
echo "     exec fish"
echo
echo "  2. Verify GitHub SSH:"
echo "     ssh -T git@github.com"
echo
echo "  3. Verify Git configuration:"
echo "     git config --global --list"
