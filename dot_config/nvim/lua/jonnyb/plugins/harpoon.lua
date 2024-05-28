return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local map = vim.keymap.set
      local harpoon = require 'harpoon'
      map('n', '<leader>ha', function()
        harpoon:list():append()
      end, { desc = '[H]arpoon [A]dd' })

      map('n', '<leader>hl', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon [L]ist' })

      map('n', '<leader>hn', function()
        harpoon:list().next()
      end, { desc = '[H]arpoon [L]ist' })

      map('n', '<leader>hp', function()
        harpoon:list().prev()
      end, { desc = '[H]arpoon [L]ist' })
    end,
    opts = {},
  },
}
