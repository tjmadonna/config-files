local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("mason not found!")
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	print("mason-lspconfig not found!")
	return
end

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
