local null_ls = require("null-ls")
null_ls.setup()

require("mason-null-ls").setup({
	ensure_installed = {
		"golangci_lint",
		"prettierd",
		"stylua",
	},
	automatic_installation = false,
	handlers = {
		function(source_name, methods)
			require("mason-null-ls").default_setup(source_name, methods)
		end,
	},
})
