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

$SUDO apt update
$SUDO apt install -y pipx
pipx install --include-deps ansible
pipx ensurepath
