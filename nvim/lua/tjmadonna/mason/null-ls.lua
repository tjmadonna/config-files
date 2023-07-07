local mason_null_ls = require("mason-null-ls")

mason_null_ls.setup({
	ensure_installed = {
		"golangci_lint",
		"prettierd",
		"stylua",
	},
	automatic_installation = false,
	handlers = {
		function(source_name, methods)
			mason_null_ls.default_setup(source_name, methods)
		end,
	},
})
