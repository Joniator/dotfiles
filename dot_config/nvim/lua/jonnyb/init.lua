local globals = {
  username = os.getenv("USER") or os.getenv("USERNAME") or "",
  work = string.find(vim.fn.hostname(), "MSGN") ~= nil,
  win = vim.fn.has("win32") == 1,
  wsl = vim.fn.has("wsl") == 1,
}
return {
  globals = globals,
}
