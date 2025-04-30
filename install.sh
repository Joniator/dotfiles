#! /usr/bin/env bash

if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    if ! command -v sudo &> /dev/null; then
        echo "❌ sudo is not installed. Please install sudo or run as root."
        exit 1
    fi
    SUDO="sudo"
fi

if [[ ! -f /etc/apt/trusted.gpg.d/fury-nushell.gpg ]]; then
    curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
    echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
    $SUDO apt update
    $SUDO apt install -y nushell
fi

sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply ssh://git@codeberg.org/JonnyB/dotfiles.git

exec nu
