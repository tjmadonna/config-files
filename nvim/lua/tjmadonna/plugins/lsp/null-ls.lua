local null_ls_setup, null_ls = pcall(require, "null-ls")
if not null_ls_setup then
	print("null-ls not found!")
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.autopep8,
		formatting.prettierd.with({
			{
				"css",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"jsonc",
				"markdown",
				"scss",
				"typescript",
				"typescriptreact",
				"yaml",
			},
		}),
		formatting.stylua,
		diagnostics.golangci_lint,
	},
})
