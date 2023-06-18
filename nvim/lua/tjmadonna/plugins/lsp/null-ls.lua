local null_ls = require("null-ls")

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
