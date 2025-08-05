def chezmoi_ssh [] {
    let dotfiles_url = "ssh://git@codeberg.org/JonnyB/dotfiles.git"
    chezmoi git remote set-url origin $dotfiles_url
}
