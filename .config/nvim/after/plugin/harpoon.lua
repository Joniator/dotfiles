local mark = require('harpoon.mark')
local ui = require('harpoon.ui')


vim.keymap.set("n", "<leader>bn", ui.nav_next)
vim.keymap.set("n", "<leader>bp", ui.nav_prev)
vim.keymap.set("n", "<C-b>", ui.toggle_quick_menu)
