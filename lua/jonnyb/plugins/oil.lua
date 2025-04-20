return {
  {
    "stevearc/oil.nvim",
    lazy = false,
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
