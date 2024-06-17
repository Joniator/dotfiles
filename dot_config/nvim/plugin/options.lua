local opt = vim.opt

-- Make line numbers default
opt.number = true
opt.relativenumber = true

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

opt.termguicolors = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true

local function get_titlestring()
  local ssh = ''
  if os.getenv 'SSH_CONNECTION' then
    ssh = 'ssh :: '
  end
  local user = os.getenv 'USER'
  if not user then
    user = os.getenv 'USERNAME' -- Windows fallback
  end
  return ssh .. user .. '@' .. vim.fn.hostname() .. ' :: nvim :: ' .. vim.fn.getcwd() .. ' :: %F'
end
opt.title = true
opt.titlestring = get_titlestring()
