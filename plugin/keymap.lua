local map = vim.keymap.set

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

  -- Move Lines
  {
    "<A-j>",
    "<cmd>m .+1<cr>==",
    desc = "Move down",
  },
  {
    "<A-k>",
    "<cmd>m .-2<cr>==",
    desc = "Move up",
  },
  {
    "<A-j>",
    "<esc><cmd>m .+1<cr>==gi",
    desc = "Move down",
  },
  {
    "<A-k>",
    "<esc><cmd>m .-2<cr>==gi",
    desc = "Move up",
  },
  {
    "<A-j>",
    ":m '>+1<cr>gv=gv",
    desc = "Move down",
  },
  {
    "<A-k>",
    ":m '<-2<cr>gv=gv",
    desc = "Move up",
  },
})
