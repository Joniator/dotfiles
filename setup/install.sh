#! /usr/bin/env bash
set -x

. /etc/os-release

case "$ID" in
	cachyos)
		paru --noconfirm -S git nushell
		;;
	ubuntu)
		sudo apt-get update
		sudo apt-get install -y gpg git
		curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor --batch --yes -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
		echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
		sudo apt-get update
		sudo apt-get install -y nushell
		;;
esac
