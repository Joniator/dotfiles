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
			"xiyaowong/telescope-emoji.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<c-r>"] = "delete_buffer" },
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable telescope extensions, if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "http")
			pcall(require("telescope").load_extension, "emoji")
			pcall(require("telescope").load_extenseion, "project_picker")

			local builtin = require("telescope.builtin")
			local map = vim.keymap.set
			local find_files = function()
				builtin.find_files({ hidden = true })
			end
			local live_grep = function()
				builtin.live_grep({ additional_args = { "--hidden" } })
			end
			map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			map("n", "<leader>sf", find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			map("n", "<leader>sg", live_grep, { desc = "[S]earch by [G]rep" })
			map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			map("n", "<leader>sE", require("telescope").extensions.emoji.emoji, { desc = "[S]earch [E]moji" })
			map("n", "<leader>sH", require("telescope").extensions.http.list, { desc = "[S]earch [H]ttp" })
			map("n", "<leader>sp", function()
				require("telescope").extensions.project_picker.project_picker("C:\\dev")
			end, { desc = "[S]earch [p]rojects" })

			map("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			map("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your neovim configuration files
			map("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
