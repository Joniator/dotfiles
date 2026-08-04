# flow nvim <cmd> — neovim maintenance helpers.

use ~/.config/flow/lib/ui.nu
use ~/.config/flow/lib/util.nu

# Headless Lazy sync + re-add the updated lockfile to chezmoi.
export def update [] {
    util require nvim chezmoi
    nvim --headless "+Lazy! sync" +qa
    chezmoi add ~/.config/nvim/lazy-lock.json
    ui success "nvim plugins synced"
}
