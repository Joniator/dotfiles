local M = {}


local function map(mode, lhs, rhs, opts) -- Taken from LazyVim/LazyVim
  local keys = require('lazy.core.handler').handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end


-- Delete buffer
map('n', '<leader>bd', vim.cmd.bdelete, { desc = 'Delete buffer' })


-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


-- Save file
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })


-- Bufferline
do
  local bufferline = require('bufferline')
  map('n', '<S-h>', function() bufferline.cycle(-1) end, { desc = 'Prev buffer' })
  map('n', '<S-l>', function() bufferline.cycle(1) end, { desc = 'Next buffer' })
end

-- Treesitter
map({ "n", "x", "o" }, 's', function() require("flash").jump() end, { desc = "Flash" })
map({ "n", "x", "o" }, 'S', function() require("flash").treesitter() end, { desc = "Flash Treesitter" })


-- Telescope
do
  local builtin = require('telescope.builtin')
  map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  map('n', '<leader>fg', builtin.live_grep, { desc = 'Find grep' })
  map('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  map('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
  map('n', '<leader>fr', builtin.oldfiles, { desc = 'Find help' })
  map('n', '<leader>fc', builtin.oldfiles, { desc = 'Find commands' })
end


-- NeoTree
do
  local neotree = require('neo-tree.command')
  map('n', "<leader>fe",
    function()
      neotree.execute({ toggle = true, dir = vim.loop.cwd() })
    end,
    { desc = "Explorer NeoTree (cwd)" })
end


-- LSP
map('n', '<leader>d', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  -- Enable completion triggered by <c-x><c-o>
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local buf = ev.buf
    map('n', 'gD', vim.lsp.buf.declaration, { buffer = buf, desc = 'Go to declaration' })
    map('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'Go to definition' })
    map('n', 'K', vim.lsp.buf.hover, { buffer = buf, desc = 'Hover info' })
    map('n', 'gi', vim.lsp.buf.implementation, { buffer = buf, desc = 'Implementation' })
    map('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = buf, desc = 'Show signature' })
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = buf, desc = 'Add workspace folder' })
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = buf, desc = 'Remove workspace folder' })
    map('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = buf, desc = 'List workspace folders' })
    map('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = buf, desc = 'Type definition' })
    map('n', '<leader>rn', vim.lsp.buf.rename, { buffer = buf, desc = 'Renamce' })
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = buf, desc = 'Code Action' })
    map('n', 'gr', vim.lsp.buf.references, { buffer = buf, desc = 'Go to references' })
    map('n', '<leader>cf', function()
      vim.lsp.buf.format { async = true }
    end, { buffer = buf, desc = 'Format file' })
  end,
})

-- Gitsigns
function M.gitsigns(bufnr)
  local gitsigns = require('gitsigns')
  map({ "n", "v" }, '<leader>ghs', gitsigns.stage_hunk, { desc = "Stage hunk" })
  map({ "n", "v" }, '<leader>ghr', gitsigns.reset_hunk, { desc = "Reset hunk" })
  map('n', '<leader>ghn', gitsigns.next_hunk, { buffer = bufnr, desc = 'Next Hunk' })
  map('n', '<leader>ghN', gitsigns.prev_hunk, { buffer = bufnr, desc = 'Previous Hunk' })
  map('n', '<leader>ghp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' })
end

return M
