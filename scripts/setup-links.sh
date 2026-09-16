#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

echo "Setting up dotfiles..."

mkdir -p "$HOME/.config/fish"
mkdir -p "$HOME/.ssh"
mkdir -p "$BACKUP_DIR"

link_file() {
    source_file="$1"
    target_file="$2"

    # Already linked correctly
    if [ -L "$target_file" ] && [ "$(readlink -f "$target_file")" = "$(readlink -f "$source_file")" ]; then
        echo "OK: $target_file"
        return
    fi

    # Back up an existing file, directory, or symlink
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        backup_name="$(echo "$target_file" | sed "s|$HOME/||" | tr '/' '_')"
        echo "Backup: $target_file -> $BACKUP_DIR/$backup_name"
        mv "$target_file" "$BACKUP_DIR/$backup_name"
    fi

    ln -s "$source_file" "$target_file"
    echo "Linked: $target_file -> $source_file"
}

link_file "$DOTFILES/fish/config.fish" "$HOME/.config/fish/config.fish"
link_file "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
if [ -f "$DOTFILES/git/gitconfig.local" ]; then
    link_file "$DOTFILES/git/gitconfig.local" "$HOME/.gitconfig.local"
fi
link_file "$DOTFILES/ssh/config" "$HOME/.ssh/config"
link_file "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

echo
echo "Dotfiles setup complete."