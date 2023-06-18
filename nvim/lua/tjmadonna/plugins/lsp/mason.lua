local mason = require("mason")

local mason_lspconfig = require("mason-lspconfig")

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"cssls",
		"emmet_ls",
		"gopls",
		"html",
		"lua_ls",
		"pyright",
		"tsserver",
	},
	automatic_installation = true,
})
