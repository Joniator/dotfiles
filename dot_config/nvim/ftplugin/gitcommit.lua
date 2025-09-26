local function get_ticket_number()
  local git_output = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  if not git_output then
    return ""
  end
  local branch = git_output:read("*l")
  git_output:close()
  if not branch then
    return ""
  end

  local ticket = branch:match("([A-Z]+%-%d+)")
  if ticket then
    return ticket .. ": "
  end
  return ""
end

local prefix = get_ticket_number()
print(prefix)
if prefix ~= "" then
  if vim.api.nvim_get_current_line() == "" then
    vim.api.nvim_buf_set_lines(0, 0, 1, false, { prefix })
    vim.api.nvim_win_set_cursor(0, { 1, 999 })
  end
end
