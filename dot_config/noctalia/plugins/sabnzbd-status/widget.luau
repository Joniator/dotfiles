--!nonstrict
-- Bar widget entry: purely reactive. Renders whatever the poller service
-- (service.luau) last published to shared plugin state; does no polling of
-- its own. Click opens the SABnzbd web UI in the default browser.

-- Nothing worth showing: SABnzbd unreachable, or reachable with an empty,
-- unpaused queue. The pill hides itself in both cases; it reappears as soon
-- as there is something to report (queued/downloading/paused).
local function isIdleOrOffline(status)
  if not status or not status.online then
    return true
  end

  return not status.paused and (status.jobCount or 0) == 0
end

-- Only reached when isIdleOrOffline() is false, i.e. status.online is true.
local function colorFor(status)
  return status.paused and "warning" or "primary"
end

local function speedText(status)
  if status.paused then
    return noctalia.tr("widget.paused")
  end

  return string.format("%.1f MB/s", status.speedKBps / 1024)
end

local function tooltipFor(status)
  local state = status.paused and noctalia.tr("widget.paused") or noctalia.tr("widget.downloading")
  return noctalia.tr("widget.tooltip", {
    state = state,
    percent = tostring(math.floor((status.percent or 0) * 100 + 0.5)),
    jobs = tostring(status.jobCount or 0),
    mbleft = string.format("%.0f", status.mbLeft or 0),
    timeleft = status.timeLeft ~= "" and status.timeLeft or "-",
  })
end

local function render(status)
  if isIdleOrOffline(status) then
    barWidget.setVisible(false)
    return
  end

  barWidget.setVisible(true)

  -- Glyph + speed text + a small colored progress bar; full breakdown
  -- (percent, jobs, ETA) lives in the tooltip.
  local container = barWidget.isVertical() and ui.column or ui.row
  local glyph = status.paused and "pause" or "download"

  barWidget.render(container({ gap = 4, align = "center" }, {
    ui.glyph({ name = glyph, size = 14 }),
    ui.label({ text = speedText(status) }),
    ui.progress({
      progress = status.percent or 0,
      fill = colorFor(status),
      track = "surface_variant/0.4",
      radius = 3,
      width = 28,
      height = 6,
    }),
  }))

  barWidget.setTooltip(tooltipFor(status))
end

-- Render immediately with whatever the service already published (handles
-- widget reload while the service keeps running), then stay reactive.
render(noctalia.state.get("status"))

noctalia.state.watch("status", function(status)
  render(status)
end)

function onClick()
  local scheme = noctalia.getConfig("https") and "https" or "http"
  local host = noctalia.getConfig("host") or "localhost"
  local port = tonumber(noctalia.getConfig("port")) or 8080
  noctalia.runAsync(string.format("xdg-open %s://%s:%d", scheme, host, port))
end
