local headline = function(opts)
  local args = opts.fargs
  local width = args[1] or 100
  local char = args[2] or '#'
  local line_start = opts.line1 - 1
  local line_stop = opts.line2
  local lines = vim.api.nvim_buf_get_lines(0, line_start, line_stop, false)
  local result = {}
  for _, value in pairs(lines) do
    local trimmed = value:gsub('^%s+', '')
    if trimmed:len() == 0 then
      table.insert(result, char:rep(width))
    else
      local filler = width - trimmed:len() - 4
      local lfill = math.max(filler / 2, 3)
      local rfill = math.max(filler / 2, 3) + (width % 2 + trimmed:len() % 2) % 2
      table.insert(result, char:rep(lfill) .. '  ' .. trimmed .. '  ' .. char:rep(rfill))
    end
  end
  vim.api.nvim_buf_set_lines(0, line_start, line_stop, false, result)
end

vim.api.nvim_create_user_command('Headline', headline, {
  nargs = '*',
  range = true,
  desc = 'Replaces the selection with full line block comments, defaults, width=100 char=#',
})
