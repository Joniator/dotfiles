return {
  "mbbill/undotree",
  lazy = false,
  config = function()
    vim.keymap.set('n', "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle Undotree" })
  end,
}
