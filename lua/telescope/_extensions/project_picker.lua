local telescope = require("telescope")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local plenary_scandir = require("plenary.scandir")

local function change_directory(selected_dir)
	vim.cmd("cd " .. selected_dir)
	print("Changed directory to: " .. selected_dir)
end

local function project_picker(opts)
	opts = opts or {}
	local path = opts.path or vim.fn.expand("%:p:h") -- Default to current file's directory
	-- local dirs = plenary_scandir.scan_dir(path, { only_dirs = true, hidden = true })
	local dirs = {}
	for _, entry in
		ipairs(vim.fn.readdir(path, function(name)
			return vim.fn.isdirectory(path .. "/" .. name) == 1
		end))
	do
		table.insert(dirs, path .. "/" .. entry)
	end
	for i in dirs do
		print(i)
	end
	pickers
		.new(opts, {
			prompt_title = "Select Directory",
			finder = finders.new_table({
				results = dirs,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						change_directory(selection[1])
					end
				end)
				return true
			end,
		})
		:find()
end

return telescope.register_extension({
	exports = {
		project_picker = project_picker,
	},
})
