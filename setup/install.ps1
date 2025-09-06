Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop install git main/nu mise

mise exec chezmoi -- chezmoi init --apply https://codeberg.org/JonnyB/dotfiles.git
