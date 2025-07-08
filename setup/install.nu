#! /usr/bin/nu

const is_linux = $nu.os-info.name == "linux"
const bin_dir = "~/.local/bin"

def main [] {
    if ("~/.local/share/chezmoi" | path exists) == false {
        chezmoi_init
    }

    use ./modules/installer.nu
    use ./modules/version.nu

    installer linux_dependencies
}

def chezmoi_init [] {
    const dotfiles_url = if ("~/.ssh/id_ed25519" | path exists) {
        "ssh://git@codeberg.org/JonnyB/dotfiles.git" 
    } else {
        "https://codeberg.org/JonnyB/dotfiles.git" 
    }
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $dotfiles_url
}

