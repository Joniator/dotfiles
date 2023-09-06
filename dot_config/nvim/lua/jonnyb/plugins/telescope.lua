return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local actions = require("telescope.actions")
    local extensions = require('telescope').extensions

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    telescope.load_extension("http")
    vim.api.nvim_create_user_command("HttpCodes", extensions.http.list, {})

    telescope.load_extension('emoji')
    vim.api.nvim_create_user_command("Emojis", extensions.emoji.emoji, {})

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fF', builtin.oldfiles, { desc = 'Find commands' })
    vim.keymap.set('n', '<leader>fn', extensions.notify.notify, { desc = 'Find notifications' })
  end,
}