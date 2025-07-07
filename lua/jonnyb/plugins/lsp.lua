return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local function lspmap(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          lspmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          lspmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          lspmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          lspmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          lspmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
          lspmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
          lspmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          lspmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
          lspmap("K", vim.lsp.buf.hover, "Hover Documentation")
          lspmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = {
          "jdtls",
        },
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {},
      },
    },
  },
}
