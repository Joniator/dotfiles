#! /usr/bin/env nu

if "~/.local/share/chezmoi" | path exists {
    return
}

let dotfiles_url = if ("~/.ssh/id_ed25519" | path exists) { 
    "ssh://git@codeberg.org/JonnyB/dotfiles.git"
} else {
    "https://codeberg.org/JonnyB/dotfiles.git"
}

do {
    cd ~
    mise exec chezmoi -- chezmoi init --apply $dotfiles_url
}

