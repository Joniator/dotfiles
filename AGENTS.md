# Agent Instructions

This is a [chezmoi](https://chezmoi.io) dotfiles repository. Files prefixed with `dot_` map to dotfiles (e.g., `dot_bashrc` → `~/.bashrc`, `dot_config/` → `~/.config/`).

## Adding Shell Functions

When asked to add a shell function or command, implement it in **all three shells** unless told otherwise.

### Nushell

Add to `dot_config/nushell/autoload/alias.nu` (general utilities) or a dedicated file in the same directory (e.g., `oc.nu` for OpenShift commands).

Nushell syntax:

```nushell
def "command name" [arg: string] {
    # body
}

# With tab completion
def "nu-complete-thing" [context: string] {
    ^some-cli list | lines
}

def "command with-completion" [arg: string@"nu-complete-thing"] {
    ^some-cli do $arg
}
```

### Zsh

Add functions to `dot_config/zsh/config/executable_util.zsh`. Add aliases to `dot_config/zsh/config/executable_alias.zsh`.
Try to use bash compatible syntax where possible so it can be reused.

Zsh syntax:

```zsh
function my_func() {
    local arg="$1"
    # body
}
```

### Bash

Bash sources the zsh config files directly (`dot_bashrc` sources `executable_util.zsh` and `executable_alias.zsh`), so **no separate bash file is needed** for functions — they are shared automatically.

## Adding Install Dependencies

When asked to install a new tool, add it to **all relevant platform scripts**:

| Platform | File |
|---|---|
| Ubuntu/Debian | `setup/lib/ubuntu.sh` |
| Arch/CachyOS | `setup/lib/cachyos.sh` |

### How lib scripts are loaded

`setup/install.sh` uses a `source_lib` helper that checks for a local `lib/` directory next to the script first. When run locally (e.g. `bash setup/install.sh`), local files are sourced directly so changes take effect immediately. When piped from curl (`curl ... | bash`), there is no local file so each lib script is fetched from the Codeberg raw URL instead.

### Ubuntu (`setup/lib/ubuntu.sh`)

Use `apt-get` if available, otherwise use the `install_gh_tar` helper (defined in `setup/lib/utils.sh`) for GitHub release binaries, or a vendor install script:

```bash
# apt package
$SUDO apt-get install -y <package>

# GitHub release binary (tar.gz), binary extracted to ~/.local/bin
install_gh_tar "owner/repo" "linux_${GOARCH}.tar.gz" "binary-name"

# Vendor install script
curl -sSfL https://example.com/install.sh | sh
```

### Arch/CachyOS (`setup/lib/cachyos.sh`)

Add the AUR/official package name to the `paru -Suy` call:

```bash
paru -Suy --noconfirm \
    existing-package \
    new-package       # add here, keep list sorted
```

## Repo Structure

```
dot_bash_profile           → ~/.bash_profile
dot_bashrc                 → ~/.bashrc  (sources zsh config files)
dot_zshenv                 → ~/.zshenv
dot_config/
  nushell/
    autoload/
      alias.nu             ← general nushell aliases & functions
      oc.nu                ← OpenShift-specific nushell commands
    config.nu              ← nushell startup (env, PATH)
  zsh/
    config/
      executable_alias.zsh ← aliases (shared with bash)
      executable_util.zsh  ← utility functions (shared with bash)
      executable_dm.zsh    ← `dm` dotfiles management command
      config.plugin.zsh    ← zsh plugin loader (mise, carapace, etc.)
  mise/config.toml         ← mise tool versions
  omp/jonnyb.omp.yaml      ← oh-my-posh prompt theme
  nvim/                    ← neovim config
setup/
  install.sh               ← entry point (detects distro, sources lib)
  lib/
    utils.sh               ← shared helpers (install_gh_tar, SUDO, ARCH)
    ubuntu.sh              ← Ubuntu install steps
    cachyos.sh             ← Arch/CachyOS install steps
```
