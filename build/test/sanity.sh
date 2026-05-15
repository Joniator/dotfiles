#!/usr/bin/env bash
# Sanity checks run inside a test container after dotfiles installation.
set -euo pipefail

PASS=0
FAIL=0

check() {
    local name="$1"; shift
    if "$@" &>/dev/null; then
        printf "  ✓ %s\n" "$name"
        ((PASS++)) || true
    else
        printf "  ✗ %s\n" "$name"
        ((FAIL++)) || true
    fi
}

echo "=== Tools ==="
check "zsh"         zsh --version
check "nu"          nu --version
check "chezmoi"     chezmoi --version
check "fzf"         fzf --version
check "rg"          rg --version
check "fd"          fd --version
check "eza"         eza --version
check "zoxide"      zoxide --version
check "oh-my-posh"  oh-my-posh --version

echo ""
echo "=== Dotfiles applied ==="
check "zshenv"              test -f "$HOME/.zshenv"
check "zsh util.zsh"        test -f "$HOME/.config/zsh/config/executable_util.zsh"
check "zsh alias.zsh"       test -f "$HOME/.config/zsh/config/executable_alias.zsh"
check "nu config.nu"        test -f "$HOME/.config/nushell/config.nu"
check "nu alias.nu"         test -f "$HOME/.config/nushell/autoload/alias.nu"
check "nu oc.nu"            test -f "$HOME/.config/nushell/autoload/oc.nu"

echo ""
echo "=== Shell sanity ==="
check "zsh runs"            zsh -c "echo ok"
check "zsh sources util"    zsh -c "source \$HOME/.config/zsh/config/executable_util.zsh && executable_exists ls"
check "nu runs"             nu -c "echo ok"
check "nu config loads"     nu -c ""
check "nu oc project def"   nu -c "scope commands | where name == 'oc project' | is-not-empty"

echo ""
printf "Results: %d passed, %d failed\n" "$PASS" "$FAIL"
[[ $FAIL -eq 0 ]]
