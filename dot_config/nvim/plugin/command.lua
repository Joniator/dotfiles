local create = vim.api.nvim_create_user_command

create("Wo", function()
	vim.cmd("w<CR>Oil<CR>")
end, {
	desc = "Save and go to file browser",
})

create("Cd", function()
	vim.cmd("cd %:h")
end, {
	desc = "Change directory to current file",
})
