return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Alt hjkl movement in visual mode
      require("mini.move").setup()

      -- Split/Join lists with gS
      require("mini.splitjoin").setup()

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Align text
      -- - ga=  - Align equal signs in selection
      require("mini.align").setup()

      require("mini.sessions").setup()
    end,
  },
}
