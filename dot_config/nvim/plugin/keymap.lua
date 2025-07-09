require("which-key").add({
  {
    "<Esc><Esc>",
    "<C-\\><C-n>",
    desc = "Exit terminal mode",
  },
  {
    "<Esc>",
    "<cmd>nohlsearch<CR>",
    desc = "Disable search highlighting",
  },

  {
    "<leader>o",
    "i<cr><esc>",
    desc = "Add a linebreak at current position",
  },
  {
    "<leader>-",
    "<cmd>Oil<CR>",
    desc = "File Manager",
  },

  -- Diagnostic keymaps
  {
    "[d",
    vim.diagnostic.goto_prev,
    desc = "Go to previous [D]iagnostic message",
  },
  {
    "]d",
    vim.diagnostic.goto_next,
    desc = "Go to next [D]iagnostic message",
  },
  {
    "<leader>d",
    group = "diagnostics",
  },
  {
    "<leader>de",
    vim.diagnostic.open_float,
    desc = "Show diagnostic [E]rror messages",
  },
  {
    "<leader>dq",
    vim.diagnostic.setloclist,
    desc = "Open diagnostic [Q]uickfix list",
  },
})
