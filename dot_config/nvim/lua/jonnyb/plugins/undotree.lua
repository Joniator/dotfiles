return {
  "mbbill/undotree",
  keys = {
    {
      "<leader>t",
      group = "toggles",
      desc = "Toggles",
    },
    {
      "<leader>tu",
      "<CMD>UndotreeToggle<CR>",
    },
  },
  config = function()
    local path = "C:/Program Files/Git/usr/bin/diff.exe"
    if vim.fn.executable(path) then
      vim.g.undotree_DiffCommand = path
    end
  end,
}
