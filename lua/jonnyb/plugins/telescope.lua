return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
      "barrett-ruth/http-codes.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = { ["<c-r>"] = "delete_buffer" },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable telescope extensions, if they are installed
      local extensions = {
        "fzf",
        "ui-select",
        "http",
      }
      for key, value in ipairs(extensions) do
        pcall(require("telescope").load_extenseion, value)
      end

      local wk = require("which-key")
      wk.add({
        {
          "<leader>s",
          group = "search",
        },
        {
          "<leader>sh",
          require("telescope.builtin").help_tags,
          desc = "[S]earch [H]elp",
        },
        {
          "<leader>sk",
          require("telescope.builtin").keymaps,
          desc = "[S]earch [K]eymaps",
        },
        {
          "<leader>sf",
          require("telescope.builtin").find_files,
          desc = "[S]earch [F]iles",
        },
        {
          "<leader>ss",
          require("telescope.builtin").builtin,
          desc = "[S]earch [S]elect Telescope",
        },
        {
          "<leader>sw",
          require("telescope.builtin").grep_string,
          desc = "[S]earch current [W]ord",
        },
        {
          "<leader>sg",
          require("telescope.builtin").live_grep,
          desc = "[S]earch by [G]rep",
        },
        {
          "<leader>sd",
          require("telescope.builtin").diagnostics,
          desc = "[S]earch [D]iagnostics",
        },
        {
          "<leader>sr",
          require("telescope.builtin").resume,
          desc = "[S]earch [R]esume",
        },
        {
          "<leader><leader>",
          require("telescope.builtin").buffers,
          desc = "[ ] Find existing buffers",
        },
        {
          "<leader>s.",
          require("telescope.builtin").oldfiles,
          desc = "[S]earch Recent Files (. for repeat)",
        },
        {
          "<leader>sE",
          function()
            require("telescope.builtin").symbols({ source = { "emoji", "nerd" } })
          end,
          icon = "😀",
          desc = "[S]earch [E]moji",
        },
        {
          "<leader>sH",
          require("telescope").extensions.http.list,
          desc = "[S]earch [H]ttp",
        },
        {
          "<leader>/",
          function()
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
              winblend = 10,
              previewer = false,
            }))
          end,
          desc = "[/] Fuzzily search in current buffer",
        },
        {
          "<leader>s/",
          function()
            require("telescope.builtin").live_grep({
              grep_open_files = true,
              prompt_title = "Live Grep in Open Files",
            })
          end,
          desc = "[S]earch [/] in Open Files",
        },
        {
          "<leader>sn",
          function()
            require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
          end,
          desc = "[S]earch [N]eovim files",
        },
      })
    end,
  },
}
