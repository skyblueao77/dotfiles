#!/usr/bin/env bash

set -euo pipefail

echo "Updating APT package index..."
sudo apt update

packages=(
    bat
    build-essential
    ca-certificates
    cmake
    curl
    eza
    fd-find
    fish
    fzf
    git
    git-lfs
    gnupg
    jq
    make
    ninja-build
    ripgrep
    rsync
    sqlite3
    tree
    unzip
    wget
    zip
    zoxide
)

echo "Installing development packages..."
sudo apt install -y "${packages[@]}"

echo "Initializing Git LFS..."
git lfs install

echo
echo "Base development packages installed."