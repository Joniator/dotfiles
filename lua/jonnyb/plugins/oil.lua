local map = vim.keymap.set
return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    cmd = "Oil",
    keys = {
      {
        "<leader>-",
        "<cmd>Oil<CR>",
        desc = "File Manager",
      },
    },
  },
}
