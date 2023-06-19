local lspconfig = require("lspconfig")

local cmp_nvim_lsp = require("cmp_nvim_lsp")

require("mason-lspconfig").setup({
	ensure_installed = {
		"cssls",
		"emmet_ls",
		"gopls",
		"html",
		"jsonls",
		"lua_ls",
		"pyright",
		"tsserver",
	},
	automatic_installation = false,
})

local keymap = vim.keymap
-- enable keybinds only for when lsp server available
local on_attach = function(_, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }
	keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show definition, references
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- show declaration
	keymap.set("n", "gh", vim.lsp.buf.hover, opts) -- show hover

	keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts) -- format buffer with leader
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]]) -- format buffer with :Format
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name)
		-- default handler
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,

	["emmet_ls"] = function()
		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})
	end,

	["lua_ls"] = function()
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
	end,
})

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
