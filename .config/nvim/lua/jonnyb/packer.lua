-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Highlight #AABBCC
  use 'NvChad/nvim-colorizer.lua'
  -- Dracula-theme
  use 'dracula/vim'
  -- Catppuccin-theme
  use { "catppuccin/nvim", as = "catppuccin" }
  -- Bookmarking
  use 'theprimeagen/harpoon'
  -- Undotree
  use 'mbbill/undotree'
  -- Git UI
  use 'tpope/vim-fugitive'
  -- Mason LSP Server
  use 'WhoIsSethDaniel/mason-tool-installer.nvim'
  -- Terminal
  use 'akinsho/toggleterm.nvim'
  -- Powerline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- Git signs
  use 'lewis6991/gitsigns.nvim'
  -- Explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  -- Filebrowser
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- Readme-Preview
  use 'ellisonleao/glow.nvim'
  -- LSP
  require("jonnyb/packer/lsp").install(use)
end)
