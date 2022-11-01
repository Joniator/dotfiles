#!/usr/bin/env zsh

if [[ ! -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then 
  source <(curl -s "https://get.sdkman.io?rcupdate=false")
fi
  
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
