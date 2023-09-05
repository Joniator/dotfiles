return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()         
    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        separator_style = 'slant',
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
      },
    })
    vim.keymap.set('n', '<S-h>', function() bufferline.cycle(-1) end, { desc = 'Prev buffer' })
    vim.keymap.set('n', '<S-l>', function() bufferline.cycle(1) end, { desc = 'Next buffer' })
  end,
}
