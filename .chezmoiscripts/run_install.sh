#! /usr/bin/env zsh

install-sdkman || echo Failed to install sdkman >&2
install-go || echo Failed to install go >&2
install-nvim || echo Failed to install nvim >&2
