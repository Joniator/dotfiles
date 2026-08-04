# AGENTS.md — flow subtree

Rules for working on `flow` (this directory + `~/.local/bin/flow` +
`~/.local/bin/flow.cmd`). These override / extend the repo-root `AGENTS.md`
only within this subtree.

## What `flow` is

A single-entry-point dev workflow helper written in nushell, styled with
[gum] + [glow], callable identically from bash, zsh, nushell, cmd, and
PowerShell. Read `README.md` in this directory before editing.

## Golden rules

1. **`~/.local/bin/flow` is a table of contents, nothing else.**
   It contains only `use` statements and one-line `def "main <group> <cmd>"`
   dispatchers. No logic. If you find yourself writing an `if` there,
   move it to `cmd/<group>.nu`.

2. **Never call `gum`, `glow`, or `mods` directly from `cmd/*.nu`.**
   All styling and prompt primitives go through `lib/ui.nu`. If a widget
   you need isn't there yet, add it to `ui.nu` first, then use it.
   Restyling the whole tool must remain a one-file change.

3. **Every command starts with `util require ...`** listing external
   binaries it depends on (`git`, `oc`, `gum`, `mods`, ...). This turns
   missing-dep failures into styled errors instead of nushell backtraces.

4. **Prefer nushell structured data over text parsing.**
   `oc get x -o json | from json | ...` beats `awk`/`sed` on `oc get x`.
   Same for `gh`, `kubectl`, `git for-each-ref --format` with tabular
   output.

5. **Keep it cross-platform.**
   - No hardcoded `/tmp`, `~/`, or `\\` path separators — use `path join`.
   - No POSIX-only externals (`sed`, `awk`, `grep`) unless there is truly
     no nushell equivalent; even then, gate with `util has`.
   - Anything Windows-specific goes behind `if $nu.os-info.name == "windows"`.

## Adding a subcommand — checklist

When asked to add `flow <group> <cmd>`:

1. Implement it as `export def <cmd> [] { ... }` in `cmd/<group>.nu`
   (create the file if the group is new).
2. Add exactly one dispatcher line in `~/.local/bin/flow`:
   ```nushell
   def "main <group> <cmd>" [args?] { <group>cmd <cmd> $args }
   ```
3. Mirror the entry in `~/.config/carapace/specs/flow.yaml` under the
   right `commands:` node (name + one-line description). Add
   `completion.positional` if the command takes dynamic arguments
   (project names, branch names, pod names, ...).
4. Update this directory's `README.md` command table.
5. Do **not** touch the repo-root `README.md` for individual commands —
   only for structural changes (new group, new dependency).

## Adding a new group (e.g. `flow k8s ...`)

1. Create `cmd/k8s.nu` with `export def`s.
2. Add `use ~/.config/flow/cmd/k8s.nu as k8scmd` at the top of
   `~/.local/bin/flow` (keep alphabetical).
3. Add a `- name: k8s` block in `flow.yaml`.
4. Update `README.md` layout section + `ui help` in `lib/ui.nu`.

## Adding a new UI primitive

Only if it's genuinely reusable across ≥ 2 commands. Otherwise inline
the `gum` call... no, actually, don't — add it to `ui.nu` with a TODO
noting it's currently used once. The one-file-restyle rule is worth
more than avoiding a small over-engineering charge.

## Dependencies

New external dependencies for `flow` must be added to **all** installer
scripts in the same commit (`setup/lib/ubuntu.sh`,
`setup/lib/cachyos.sh`, `setup/lib/windows.ps1`). See the repo-root
`AGENTS.md` "Adding Install Dependencies" section for the pattern.

## Testing

There is no test suite. Before committing, run each modified command
against a real repo / cluster if possible. At minimum verify:

- `flow` (bare) still prints usage.
- `flow <group> <newcmd>` runs without a nu parse/runtime error.
- `flow <group> <TAB>` completes in nu **and** bash (via carapace).

## Do not

- Add a `flow update` / `flow init` command that mutates the user's
  system. Those belong in `setup/` or in nushell's `util update`.
- Add persistent state under `~/.config/flow/`. If a command needs
  state (cache, tokens), put it under `$env.XDG_CACHE_HOME/flow/` or
  `$env.XDG_STATE_HOME/flow/`.
- Introduce a second runtime (python, deno, node). The whole point is
  one language. If you *truly* need a full-screen TUI for one command,
  discuss before adding it — see the repo-root discussion for the
  Deno+Ink escape hatch.

[gum]: https://github.com/charmbracelet/gum
[glow]: https://github.com/charmbracelet/glow
