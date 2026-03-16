-- vi: foldmethod=marker
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.undofile = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  severity_sort = false,
  float = true,
})

-- Neovide {{{1
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.01
  vim.g.neovide_scroll_animation_length = 0.0
end

-- WhichKey {{{1
vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})
local wk = require("which-key")
wk.add({
  {
    "<leader>?",
    function()
      wk.show()
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },
  {
    "<C-[>",
    "<C-\\><C-n>",
    desc = "Exit terminal mode",
    mode = "t",
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
  {
    "<C-w><tab>",
    function()
      local buf = vim.v.count
      if buf == 0 then
        vim.cmd("tabnext")
      else
        vim.cmd("tabnext " .. buf)
      end
    end,
    desc = "File Manager",
  },

  -- Diagnostic keymaps
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

-- Treesitter {{{1
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and not kind == "delete" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      require("nvim-treesitter").install({
        "bash",
        "dockerfile",
        "git_config",
        "gitcommit",
        "go",
        "gotmpl",
        "ini",
        "java",
        "lua",
        "markdown",
        "nu",
        "powershell",
        "sql",
        "python",
        "query",
        "vim",
        "vimdoc",
        "yaml",
      })
      vim.cmd("TSUpdate")
    end
  end,
})
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/nvim-treesitter/nvim-treesitter",
})
require("nvim-treesitter").setup()
require("treesitter-context").setup({
  min_window_height = 30,
  max_lines = 5,
  multiline_threshold = 1,
  mode = "topline",
})
local treesitter_select = require("nvim-treesitter-textobjects.select").select_textobject
wk.add({
  {
    "if",
    function()
      treesitter_select("@function.inner", "textobjects")
    end,
    desc = "Inner Function",
    mode = "xo",
  },
  {
    "af",
    function()
      treesitter_select("@function.outer", "textobjects")
    end,
    desc = "Around Function ",
    mode = "xo",
  },
  {
    "ic",
    function()
      treesitter_select("@class.inner", "textobjects")
    end,
    desc = "Inner Class ",
    mode = "xo",
  },
  {
    "ac",
    function()
      treesitter_select("@class.outer", "textobjects")
    end,
    desc = "Around Class",
    mode = "xo",
  },
})

-- Mini.nvim {{{1
vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
})
require("mini.align").setup()
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup({
  highlight_duration = 5000,
})
require("mini.tabline").setup()

-- Fidget {{{1
vim.pack.add({
  "https://github.com/j-hui/fidget.nvim",
})
require("fidget").setup()

-- fzf-lua {{{1
vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})
---@type fzf-lua.Config|{}
local fzf = require("fzf-lua")
local fzf_config = {
  { "telescope" },
}
fzf.setup(fzf_config)
fzf.register_ui_select()
wk.add({
  {
    "<leader>s",
    group = "Search",
  },
  {
    "<leader>ss",
    FzfLua.files,
    desc = "Files",
  },
  {
    "<leader>sh",
    FzfLua.helptags,
    desc = "Help",
  },
  {
    "<leader>sk",
    FzfLua.keymaps,
    desc = "Keymaps",
  },
  {
    "<leader>sg",
    FzfLua.lgrep_curbuf,
    desc = "Grep Buffer",
  },
  {
    "<leader>sG",
    FzfLua.live_grep,
    desc = "Grep CWD",
  },
  {
    "<leader>sg",
    FzfLua.grep_visual,
    desc = "Grep",
    mode = "v",
  },
  {
    "<leader>sd",
    FzfLua.diagnostics_workspace,
    desc = "Diagnostics",
  },
  {
    "<leader>sr",
    FzfLua.resume,
    desc = "Resume",
  },
  {
    "<leader><leader>",
    FzfLua.buffers,
    desc = "Buffers",
  },
})

-- Grug Far {{{1
vim.pack.add({
  "https://github.com/MagicDuck/grug-far.nvim",
})
local grug = require("grug-far")
grug.setup({})
wk.add({
  {
    "<leader>r",
    grug.open,
    desc = "Find and Replace",
  },
})

-- Emojis {{{1
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/Allaman/emoji.nvim",
  "https://github.com/2KAbhishek/nerdy.nvim",
})
require("nerdy").setup()
require("emoji").setup({
  plugin_path = vim.fn.stdpath("data") .. "/site/pack/core/opt",
})
require("which-key").add({
  {
    "<leader>se",
    group = "Emojis",
  },
  {
    "<leader>see",
    "<cmd>Emoji<CR>",
    desc = "Emojis",
  },
  {
    "<leader>sek",
    "<cmd>Emoji kaomoji<CR>",
    desc = "Kaomojis",
  },
  {
    "<leader>sen",
    "<cmd>Nerdy<CR>",
    desc = "NerdIcons",
  },
})

-- Dial {{{1
vim.pack.add({
  "https://github.com/monaqa/dial.nvim",
})
local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%d.%m.%Y"],
    augend.constant.alias.de_weekday_full,
    augend.constant.alias.de_weekday,
    augend.constant.alias.en_weekday_full,
    augend.constant.alias.en_weekday,
    augend.constant.alias.bool,
    augend.constant.alias.Bool,
  },
})
wk.add({
  {
    "<C-a>",
    function()
      require("dial.map").manipulate("increment", "normal")
    end,
  },
  {
    "<C-x>",
    function()
      require("dial.map").manipulate("decrement", "normal")
    end,
  },
  {
    "g<C-a>",
    function()
      require("dial.map").manipulate("increment", "gnormal")
    end,
  },
  {
    "g<C-x>",
    function()
      require("dial.map").manipulate("decrement", "gnormal")
    end,
  },
  {
    "<C-a>",
    function()
      require("dial.map").manipulate("increment", "visual")
    end,
    mode = "x",
  },
  {
    "<C-x>",
    function()
      require("dial.map").manipulate("decrement", "visual")
    end,
    mode = "x",
  },
  {
    "g<C-a>",
    function()
      require("dial.map").manipulate("increment", "gvisual")
    end,
    mode = "x",
  },
  {
    "g<C-x>",
    function()
      require("dial.map").manipulate("decrement", "gvisual")
    end,
    mode = "x",
  },
})

-- Bufferline {{{1
vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim",
})
require("bufferline").setup({
  options = {
    show_buffer_icons = true,
    separator_style = "slope",
  },
})

-- Lualine {{{1
vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})
require("lualine").setup({})

-- Indent Blankline {{{1
vim.pack.add({
  "https://github.com/lukas-reineke/indent-blankline.nvim",
})
require("ibl").setup()

-- Dropbar {{{1
vim.pack.add({
  "https://github.com/Bekaboo/dropbar.nvim",
})

-- Rainbow Delimiter {{{1
vim.pack.add({
  "https://github.com/HiPhish/rainbow-delimiters.nvim",
})

-- Colorizer {{{1
vim.pack.add({
  "https://github.com/catgoose/nvim-colorizer.lua",
})
require("colorizer").setup({
  options = { parsers = { css = true } },
})

-- TODO Comments {{{1
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/todo-comments.nvim",
})
require("todo-comments").setup()

-- Markview {{{1
vim.pack.add({
  "https://github.com/OXY2DEV/markview.nvim",
})
require("markview").setup({
  preview = {
    icon_provider = "mini",
  },
})

-- Fyler {{{1
vim.pack.add({
  "https://github.com/A7Lavinraj/fyler.nvim",
})
require("fyler").setup({
  views = {
    finder = {
      default_explorer = true,
      win = {
        win_opts = {
          cursorline = true,
          number = true,
          relativenumber = true,
        },
      },
      mappings = {
        -- ['q'] = 'CloseView',
        -- ['<CR>'] = 'Select',
        -- ['<C-t>'] = 'SelectTab',
        -- ['|'] = 'SelectVSplit',
        ["-"] = "GotoParent",
        -- ['~'] = 'GotoCwd',
        -- ['.'] = 'GotoNode',
        -- ['#'] = 'CollapseAll',
        -- ['<BS>'] = 'CollapseNode',
      },
    },
  },
})
wk.add({
  { "<leader>-", "<cmd>Fyler<CR>", desc = "Open Fyler" },
  { "<leader>_", "<cmd>Fyler kind=split_left_most<CR>", desc = "Open Fyler Split" },
})

-- Git {{{1
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/lewis6991/gitsigns.nvim",
})
wk.add({
  {
    "<leader>g",
    group = "Git",
  },
  {
    "<leader>gg",
    "<cmd>Neogit<CR>",
    desc = "Neogit",
  },
})
local gitsigns_config = {
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    require("which-key").add({
      {
        "<leader>g",
        group = "git",
        buffer = bufnr,
      },
      {
        "<leader>gh",
        group = "hunk",
        buffer = bufnr,
      },
      {
        "<leader>gb",
        group = "buffer",
        buffer = bufnr,
      },
      {
        "]g",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]g", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end,
        desc = "Next hunk",
        buffer = bufnr,
      },
      {
        "]g",
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end,
        desc = "Previous hunk",
        buffer = bufnr,
      },
      {
        "<leader>ghs",
        gitsigns.stage_hunk,
        desc = "Stage",
        buffer = bufnr,
      },
      {
        "<leader>ghr",
        gitsigns.reset_hunk,
        desc = "Reset",
        buffer = bufnr,
      },
      {
        mode = "v",
        "<leader>ghs",
        function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        buffer = bufnr,
      },
      {
        mode = "v",
        "<leader>ghr",
        function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        buffer = bufnr,
      },
      {
        "<leader>gbs",
        gitsigns.stage_buffer,
        desc = "Stage",
        buffer = bufnr,
      },
      {
        "<leader>gbr",
        gitsigns.reset_buffer,
        desc = "Reset",
        buffer = bufnr,
      },
      {
        "<leader>ghp",
        gitsigns.preview_hunk,
        desc = "Preview",
        buffer = bufnr,
      },
      {
        "<leader>ghP",
        gitsigns.preview_hunk_inline,
        desc = "Preview Inline",
        buffer = bufnr,
      },
      {
        "<leader>ghb",
        function()
          gitsigns.blame_line({ full = true })
        end,
        desc = "Blame",
      },
    })
  end,
}
require("gitsigns").setup(gitsigns_config)

-- Blink {{{1
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "blink.cmp" and kind == "update" then
      vim.cmd.packadd({ args = { name }, bang = false })
      require("blink.cmp.fuzzy.build").build()
    end
  end,
})
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
  "https://github.com/saghen/blink.compat",
  "https://github.com/Dynge/gitmoji.nvim",
})
require("gitmoji").setup({})
local blink = require("blink.cmp")
blink.setup({
  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
      "gitmoji",
      "emoji",
    },
    providers = {
      snippets = {
        opts = {
          search_paths = {
            vim.fn.stdpath("config") .. "/snippets",
          },
        },
      },
      gitmoji = {
        name = "gitmoji",
        module = "gitmoji.blink",
        opts = {
          filetypes = { "gitcommit", "jj" },
        },
      },
      emoji = {
        name = "emoji",
        module = "blink.compat.source",
        transform_items = function(_, items)
          local kind = require("blink.cmp.types").CompletionItemKind.Text
          for i = 1, #items do
            items[i].kind = kind
          end
          return items
        end,
      },
    },
  },
})
wk.add({
  {
    "<C-space>",
    function()
      blink.show()
    end,
    mode = "i",
    desc = "Show completion",
    silent = false,
  },
})

-- LSP-Config {{{1
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

-- Mason {{{1
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "mason.nvim" and kind == "install" then
      if not ev.data.active then
        vim.cmd.packadd("mason.nvim")
      end
      local mason_ensure_installed = {
        "ansible-language-server",
        "ansible-lint",
        "google-java-format",
        "helm-ls",
        "lua-language-server",
        "stylua",
      }
      require("mason").setup()
      require("mason.api.command").MasonInstall(mason_ensure_installed)
    end
  end,
})
vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})
require("mason").setup()
require("mason-lspconfig").setup({})

-- Lua LS {{{2
---@type vim.lsp.Config
local luals_config = {
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
}
vim.lsp.config("lua_ls", luals_config)
vim.lsp.enable({ "lua_ls" })

-- Conform {{{1
vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    java = { "google-java-format" },
    ansible = { "ansiblelint" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Flash {{{1
vim.pack.add({
  "https://github.com/folke/flash.nvim",
})
local flash = require("flash")
flash.setup()
wk.add({
  {
    "<leader>f",
    flash.jump,
    mode = { "n", "x", "o" },
    desc = "Flash",
  },
})

-- Zen {{{1
vim.pack.add({
  "https://github.com/folke/zen-mode.nvim",
})
local zen = require("zen-mode")
zen.setup()
wk.add({
  {
    "<leader>m",
    zen.toggle,
  },
})

-- Undo-Glow {{{1
vim.pack.add({
  "https://github.com/y3owk1n/undo-glow.nvim",
})
local glow = require("undo-glow")
glow.setup({
  animation = {
    duration = 300,
  },
})
wk.add({
  {
    "u",
    glow.undo,
    mode = "n",
    desc = "Undo with highlight",
    noremap = true,
  },
  {
    "U",
    glow.redo,
    mode = "n",
    desc = "Redo with highlight",
    noremap = true,
  },
  {
    "p",
    glow.paste_below,
    mode = "n",
    desc = "Paste below with highlight",
    noremap = true,
  },
  {
    "P",
    glow.paste_above,
    mode = "n",
    desc = "Paste above with highlight",
    noremap = true,
  },
})
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  callback = glow.yank,
})

-- Undotree {{{1
vim.pack.add({
  "https://github.com/jiaoshijie/undotree",
})
local undotree = require("undotree")
undotree.setup()
wk.add({
  {
    "<leader>u",
    undotree.toggle,
  },
})

-- Catppuccin {{{1
vim.pack.add({
  "https://github.com/catppuccin/nvim",
  "https://github.com/HiPhish/rainbow-delimiters.nvim",
  "https://github.com/catgoose/nvim-colorizer.lua",
  "https://github.com/Bekaboo/dropbar.nvim",
})
require("catppuccin").setup({
  transparent_background = true,
  integrations = {
    blink_cmp = {
      style = "bordered",
    },
    dropbar = {
      enabled = true,
      color_mode = true,
    },
    mason = true,
    which_key = false,
  },
})
vim.cmd.colorscheme("catppuccin-mocha")
