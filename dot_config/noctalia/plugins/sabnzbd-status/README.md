# sabnzbd-status (Noctalia plugin)

Bar widget + background service showing a SABnzbd download queue's speed
and overall progress (a small colored bar, via `barWidget.render` +
`ui.progress`), with percent/job count/ETA on hover. Click the widget to
open the SABnzbd web UI. The pill auto-hides (`barWidget.setVisible(false)`)
whenever SABnzbd is unreachable or its queue is empty and unpaused, and
reappears as soon as there's something to report.

## Layout

- `plugin.toml` - manifest: identity, plugin-level settings, entry declarations
- `service.luau` - `[[service]]` entry: polls the SABnzbd JSON API on an interval,
  publishes `status` via `noctalia.state.set`
- `widget.luau` - `[[widget]]` entry: renders whatever `service.luau` last published
- `translations/en.json` - UI strings (settings labels/descriptions, widget text)

## Settings (Settings -> Plugins -> gear icon)

| Key                     | Default     | Notes                                   |
| ----------------------- | ----------- | ---------------------------------------- |
| `host`                  | `localhost` | SABnzbd host                             |
| `port`                  | `8080`      | SABnzbd web UI port                      |
| `https`                 | `false`     | Use HTTPS                                |
| `api_key`               | `""`        | Config -> General -> API Key in SABnzbd  |
| `poll_interval_seconds` | `5`         | How often the service polls the queue    |

## Dev setup

This plugin lives in `~/.config/noctalia/plugins/sabnzbd-status/` (chezmoi-managed)
and is loaded as a custom `path` source, registered once:

```sh
noctalia msg plugins source add dev path ~/.config/noctalia/plugins
noctalia msg plugins enable joniator/sabnzbd-status
```

`.luau` edits hot-reload automatically; `plugin.toml` changes need a config reload
(`noctalia msg config reload` or restart). Add the bar widget from
Settings -> Bar -> Add widget (or configure by hand with
`type = "joniator/sabnzbd-status:status"`), and test IPC with:

```sh
noctalia msg plugin joniator/sabnzbd-status:poller all refresh
```

## TODO / ideas

- Add a `[[panel]]` entry listing individual queue slots (per-file progress).
- Surface SABnzbd warnings/errors as `noctalia.notifyError`.
