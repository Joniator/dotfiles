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

## CachyOS installer

`curl -o- https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup/install.sh | bash`

## Docker

### Run

`docker run --rm -it joniator/dotfiles`


### Build

`./build/docker.nu`
