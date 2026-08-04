# Dotfiles

## Per-machine configuration

The chezmoi config template (`.chezmoi.yaml.tmpl`) uses `promptStringOnce` to ask for machine-specific values on first run. Answers are stored in `~/.config/chezmoi/chezmoi.yaml` and never asked again.

| Variable | Description | Example values |
|---|---|---|
| `defaultShell` | Preferred shell for this machine | `zsh`, `bash`, `nu` |

To reset a prompted value and be asked again, edit `~/.config/chezmoi/chezmoi.yaml` and remove the relevant key from the `data` section, or run `chezmoi init` again.

## Local secrets

Create `~/.env.secret` for credentials and keys that should never be committed. This file is not managed by chezmoi and is automatically loaded by bash, zsh, and nushell on startup.

Entries can be plain `KEY=value` pairs (no `export` needed) — bash/zsh use `set -a` while sourcing so assignments are auto-exported, and nushell parses the file and loads it via `load-env`. Surrounding single or double quotes on values are stripped in all shells.

```sh
# ~/.env.secret
GITHUB_TOKEN=ghp_...
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY="..."
```

## Nushell startup

Nushell uses two startup files under `dot_config/nushell/`:

- `env.nu` — runs first, before `config.nu`. Sets `XDG_CONFIG_HOME`, `XDG_CACHE_HOME`, `XDG_STATE_HOME`, `XDG_DATA_HOME` so other tools that respect XDG see consistent paths from the first launch.
- `config.nu` — interactive config (banner, edit mode), PATH additions, `.env.secret` loading.

### Vendor autoload dir

Generated init files (`oh-my-posh.nu`, `mise.nu`, `carapace.nu`, `zoxide.nu`, `atuin.nu`) are written by `util update` to `$nu.vendor-autoload-dirs | last` — the user-writable entry in nushell's built-in vendor autoload list. On Windows this is `%APPDATA%\nushell\vendor\autoload\`, on Linux typically `~/.config/nushell/vendor/autoload/`.

Do **not** write generated files under `$nu.data-dir/vendor/autoload` — on Windows `$nu.vendor-autoload-dirs` is hardcoded to `%ProgramData%` and `%APPDATA%` and does not follow `XDG_DATA_HOME`, so files written there would be silently ignored on every startup.

Run `util update` once after a fresh install (or after moving machines) to (re)generate the init files at the correct location.

## CachyOS installer

`curl -o- https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup/install.sh | bash`

## Windows installer

From PowerShell:

```powershell
iwr -useb https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup/install.ps1 | iex
```

Installs the same toolchain as Linux via scoop (preferred, per-user, no admin) with a winget fallback for anything scoop can't provide. See `setup/lib/windows.ps1`.

## flow

`flow` is a single-entry-point dev workflow helper written in nushell, styled with gum/glow. Callable identically from bash, zsh, nu, and Windows (`flow` on Unix via shebang, `flow.cmd` wrapper on Windows). See [`dot_config/flow/README.md`](dot_config/flow/README.md) for the layout and how to add commands.

## Docker

### Run

`docker run --rm -it joniator/dotfiles`


### Build

`./build/docker.nu`
