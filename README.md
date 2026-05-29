# Dotfiles

## Local secrets

Create `~/.env.secret` for credentials and keys that should never be committed. This file is not managed by chezmoi and is automatically loaded by bash, zsh, and nushell on startup.

```sh
# ~/.env.secret
export GITHUB_TOKEN=ghp_...
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
```

## CachyOS installer

`curl -o- https://codeberg.org/JonnyB/dotfiles/raw/branch/main/setup/install.sh | bash`

## Docker

### Run

`docker run --rm -it joniator/dotfiles`


### Build

`./build/docker.nu`
