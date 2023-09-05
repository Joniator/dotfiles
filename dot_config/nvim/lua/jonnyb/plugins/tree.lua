return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('nvim-tree').setup({})

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.keymap.set("n", "<leader>fE", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
  end,
  opts = true,
}
