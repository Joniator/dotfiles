# flow

Personal dev workflow helper. One `flow` command, dispatched into grouped
subcommands (`flow git ...`, `flow oc ...`, `flow review ...`). Written in
nushell, styled with [gum] + [glow], optionally augmented with [mods].

## Layout

```
~/.local/bin/
  flow            single-file nu entry point (shebang)
  flow.cmd        Windows wrapper: `nu "%~dp0flow" %*`

~/.config/flow/
  lib/
    ui.nu         gum/glow/style primitives — the only place gum flags live
    util.nu       tiny shared helpers (`abort`, `has`, `require`)
  cmd/
    chezmoi.nu    `flow chezmoi ...` — origin-to-ssh, update
    edit.nu       `flow edit ...`    — zsh, nvim, nu, mise
    git.nu        `flow git ...`     — branch, commit, wip
    net.nu        `flow net ...`     — ip
    nvim.nu       `flow nvim ...`    — update
    oc.nu         `flow oc ...`      — project, pods
    review.nu     `flow review ...`  — diff
```

The entrypoint `~/.local/bin/flow` is deliberately just a table of
`def "main <group> <cmd>"` dispatchers — one line each. All logic lives in
`cmd/*.nu`, all styling in `lib/ui.nu`.

## Cross-shell / cross-platform invocation

| Host | How it works |
|---|---|
| Linux / macOS / WSL (bash, zsh, nu) | `#!/usr/bin/env nu` shebang on `flow` |
| Windows (cmd, PowerShell, nu) | `flow.cmd` wrapper invokes `nu` on the extension-less `flow` file next to it |

Both live in `~/.local/bin/` on PATH — no per-shell integration needed.

## Adding a command

1. Add `export def foo [] { ... }` in the appropriate `cmd/<group>.nu`
   (or create a new group file).
2. Wire it in `~/.local/bin/flow`:
   ```nushell
   def "main <group> foo" [] { <group>cmd foo }
   ```
3. Use `ui` helpers for all styled output/prompts — never call `gum`
   directly from `cmd/*.nu`, so restyling stays a one-file change.

## Completions

A single [carapace](https://carapace.sh/) spec at `~/.config/carapace/specs/flow.yaml` drives completions in **every** shell that has carapace initialised (bash, zsh, nu, fish). Keep it in lockstep with the `def "main ..."` dispatchers in `~/.local/bin/flow` — whenever you add/rename a command there, mirror it in the yaml.

Dynamic completions (e.g. project names for `flow oc project`) use the spec's `completion.positional` with a shell snippet; the snippet runs on each tab so keep it fast.

## Dependencies

Installed by the setup scripts (`setup/lib/{ubuntu,cachyos}.sh` and
`setup/lib/windows.ps1`):

- **nushell** — the runtime
- **gum** — prompts, spinners, styled output
- **glow** — markdown rendering
- **mods** — optional; LLM-in-pipe for review summaries

[gum]: https://github.com/charmbracelet/gum
[glow]: https://github.com/charmbracelet/glow
[mods]: https://github.com/charmbracelet/mods
