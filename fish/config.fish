if status is-interactive
    # Interactive shell settings
end

# User binaries
fish_add_path ~/.local/bin

# zoxide
if type -q zoxide
    zoxide init fish | source
end

# fzf
if type -q fzf
    fzf --fish | source
end

# eza
if type -q eza
    alias ls="eza --icons"
    alias ll="eza -l --icons --git"
    alias la="eza -la --icons --git"
    alias tree="eza --tree --icons"
end

# bat
if type -q batcat
    alias bat="batcat"
end

# Starship
if type -q starship
    starship init fish | source
end

# fd
if type -q fdfind
    alias fd="fdfind"
end