local function get_ticket_number_async(callback)
  vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }, function(obj)
    local branch = obj.stdout and obj.stdout:match("[^\r\n]+")
    if not branch then
      callback("")
      return
    end
    local ticket = branch:match("([A-Z]+%-%d+)")
    if ticket then
      callback(ticket)
    else
      callback("")
    end
  end)
end

get_ticket_number_async(function(prefix)
  vim.schedule(function()
    if prefix ~= "" then
      local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] or ""
      local new = prefix .. ": " .. line
      vim.api.nvim_buf_set_lines(0, 0, 0, false, { new })
      vim.api.nvim_win_set_cursor(0, { 1, #new + 1 })
    end
  end)
end)
