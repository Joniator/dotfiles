#! /usr/bin/env bash
set -x

. /etc/os-release

case "$ID" in
	cachyos)
		pacman -Syu --noconfirm git nushell mise
		;;
	ubuntu)
		sudo apt-get update
		sudo apt-get install -y gpg git
		curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor --batch --yes -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
		echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
		sudo apt-get update
		sudo apt-get install -y nushell
		curl https://mise.run | sh
		;;
esac

~/.local/bin/mise exec chezmoi -- chezmoi init --apply https://codeberg.org/JonnyB/dotfiles.git
~/.local/bin/mise install
