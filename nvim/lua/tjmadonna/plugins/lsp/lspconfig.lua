local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	print("lspconfig not found!")
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	print("cmp_nvim_lsp not found!")
	return
end

local keymap = vim.keymap

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show definition, references
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- show declaration
	keymap.set("n", "gh", vim.lsp.buf.hover, opts) -- show hover

	keymap.set("n", "<leader>l", vim.lsp.buf.format, opts) -- format buffer with leader
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]]) -- format buffer with :Format
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure css server
lspconfig["gopls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure python server
lspconfig["pyright"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
lspconfig["tsserver"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure lua server
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	-- custom settings for lua
	settings = {
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
