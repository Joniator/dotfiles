# flow edit <target> — open a dotfiles subtree in your editor via chezmoi.
#
# Always operates on the chezmoi source (not the deployed copy) so edits
# are safe and get re-applied on save. Replaces the old `dm edit` command.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Edit the zsh config subtree, then re-exec zsh so changes take effect.
export def zsh [] {
    util require chezmoi
    chezmoi edit --apply ~/.config/zsh
    exec zsh
}

# Edit the neovim config subtree.
export def nvim [] {
    util require chezmoi
    chezmoi edit --apply ~/.config/nvim
}

# Edit the nushell config subtree, then re-exec nu.
export def nu [] {
    util require chezmoi
    chezmoi edit --apply ~/.config/nushell
    exec nu
}

# Edit the mise config.
export def mise [] {
    util require chezmoi
    chezmoi edit --apply ~/.config/mise/config.toml
}
