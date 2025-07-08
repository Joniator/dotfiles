#! /usr/bin/env bash

curl -fsSL https://apt.fury.io/nushell/gpg.key | sudo gpg --dearmor --batch --yes -o /etc/apt/trusted.gpg.d/fury-nushell.gpg
echo "deb https://apt.fury.io/nushell/ /" | sudo tee /etc/apt/sources.list.d/fury.list
sudo apt update
sudo apt install nushell

nu install.nu
