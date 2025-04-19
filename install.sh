#! /usr/bin/env sh

cd /usr/local
eval "$(curl -fsLS get.chezmoi.io)"

curl -s https://ohmyposh.dev/install.sh | bash -s

chezmoi init git@codeberg.org:JonnyB/dotfiles.git

