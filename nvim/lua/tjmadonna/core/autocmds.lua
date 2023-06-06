local api = vim.api

-- set spaces to 2 for specific file types
api.nvim_create_autocmd("FileType", {
	pattern = {
		"html",
		"css",
		"json",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"lua",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
	end,
})
