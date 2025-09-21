return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function(_, opts) end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      { "DrKJeff16/wezterm-types", lazy = true },
    },
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = {
          "jdtls",
        },
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
    },
  },
}
