function nmap(key, action) 
	vim.keymap.set("n", key, action)
end

nmap("<leader>fb", vim.cmd.Ex)

