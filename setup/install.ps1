Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop install extras/carapace-bin
scoop install main/chezmoi
scoop install main/nu
scoop install main/oh-my-posh
scoop install main/zoxide
scoop install versions/neovim-nightly
