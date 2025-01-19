#!/usr/bin/env zsh

fast-theme -q $XDG_CACHE_HOME/antidote/catppuccin/zsh-fsh/themes/catppuccin-macchiato.ini

GO_INSTALL_DIR="/usr/local/go"
if [[ -d "$GO_INSTALL_DIR" ]]; then export PATH="$GO_INSTALL_DIR/bin:$PATH"; fi

if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then source "$SDKMAN_DIR/bin/sdkman-init.sh"; fi

if [[ -d "$HOME/.cargo/env" ]]; then source "$HOME/.cargo/env"; fi

if [[ -d "$ASDF_DIR" ]]; then source "$ASDF_DIR/asdf.sh"; fi

FNM_PATH="$HOME/.local/share/fnm"
if [[ -d $FNM_PATH ]]; then export PATH="$FNM_PATH:$PATH"; eval "`fnm env`"; fi

if command -v fzf &> /dev/null; then source <(fzf --zsh); fi

if command -v atuin &> /dev/null; then bindkey "^R" atuin-search; fi

if command -v zoxide &> /dev/null; then eval "$(zoxide init --cmd cd zsh)"; fi

if command -v oh-my-posh &> /dev/null; then eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/omp/jonnyb.omp.yaml)"; fi

