return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    autotag = { enable = true },
    ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "yaml",
      "html",
      "css",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    auto_install = true,
  }
}
