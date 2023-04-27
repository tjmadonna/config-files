vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local user_Fugitive = vim.api.nvim_create_augroup("user_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
	group = user_Fugitive,
	pattern = "*",
	callback = function()
		-- if vim.bo.ft ~= "fugitive" then
		--     return
		-- end

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>P", "<cmd>Git push<cr>", opts)

		-- rebase always
		vim.keymap.set("n", "<leader>p", "<cmd>Git pull --rebase<cr>", opts)
	end,
})
