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

-- Refresh nvim tree on git changes
local tree_group = api.nvim_create_augroup("NvimTreeGitGroup", { clear = true })
api.nvim_create_autocmd("FugitiveChanged", {
  group = tree_group,
})
