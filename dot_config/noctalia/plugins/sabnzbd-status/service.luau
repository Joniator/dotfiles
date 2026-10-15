--!nonstrict
-- Headless [[service]] entry (no UI). Polls the SABnzbd JSON API on the
-- configured interval and publishes the parsed queue status so the bar
-- widget (widget.luau) can render it via noctalia.state.watch("status", ...).
--
-- SABnzbd API docs: https://sabnzbd.org/wiki/advanced/api

local function baseUrl()
  local scheme = noctalia.getConfig("https") and "https" or "http"
  local host = noctalia.getConfig("host") or "localhost"
  local port = tonumber(noctalia.getConfig("port")) or 8080
  return string.format("%s://%s:%d", scheme, host, port)
end

local function poll()
  local apiKey = noctalia.getConfig("api_key") or ""
  local url = string.format(
    "%s/api?mode=queue&output=json&apikey=%s",
    baseUrl(),
    noctalia.string.urlEncode(apiKey)
  )

  noctalia.http({ url = url }, function(response)
    if not response.ok then
      noctalia.state.set("status", { online = false, error = "request_failed" })
      return
    end

    local data = noctalia.json.decode(response.body)
    if not data or not data.queue then
      noctalia.state.set("status", { online = false, error = "bad_response" })
      return
    end

    local queue = data.queue
    local totalMb = tonumber(queue.mb) or 0
    local mbLeft = tonumber(queue.mbleft) or 0
    local percent = 0
    if totalMb > 0 then
      percent = math.clamp((totalMb - mbLeft) / totalMb, 0, 1)
    end

    noctalia.state.set("status", {
      online = true,
      paused = queue.paused or false,
      speedKBps = tonumber(queue.kbpersec) or 0,
      mbLeft = mbLeft,
      percent = percent,
      timeLeft = queue.timeleft or "",
      jobCount = tonumber(queue.noofslots) or #(queue.slots or {}),
    })
  end)
end

local function applyInterval()
  local seconds = tonumber(noctalia.getConfig("poll_interval_seconds")) or 5
  noctalia.setUpdateInterval(seconds * 1000)
end

-- Fires once when the plugin/service is explicitly enabled.
function onEnable()
  applyInterval()
  poll()
end

-- Fires every update interval.
function update()
  poll()
end

-- Re-apply settings (e.g. a changed poll interval) without waiting for the
-- next natural update tick.
function onConfigChanged()
  applyInterval()
  poll()
end

-- Manual refresh, e.g.:
--   noctalia msg plugin joniator/sabnzbd-status:poller all refresh
function onIpc(event)
  if event == "refresh" then
    poll()
  end
end
