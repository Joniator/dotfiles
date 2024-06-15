# Dotfiles

Managed with [chezmoi](https://chezmoi.io/).

# Installation

```sh
# Don't decrypt secrets, works on non-interactive terminals and does not need a password to work
curl -fsLS https://joniator.github.io/dotfiles/install.sh | sh -s -- --mode=checkout

# Trying to decrypt secrets, needs interactive terminal and password
curl -fsLS https://joniator.github.io/dotfiles/install.sh | sh -s -- --mode=decrypt
```

## License

MIT
