#!/bin/bin/env zsh

if ! command -v nvim > /dev/null 2>&1; then
  TEMP_DEB="$(mktemp nvim-XXXXXX.deb)" && \
  wget -O "$TEMP_DEB" "https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.deb" && \
  sudo apt-get install -y "$TEMP_DEB" && \
  rm -f "$TEMP_DEB" || echo "Failed to install nvim"
fi
