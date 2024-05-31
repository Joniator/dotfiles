return {
  { 'NvChad/nvim-colorizer.lua', opts = {
    user_default_options = {
      css = true,
      tailwind = true,
    },
  } },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'macchiato',
    },
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
