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
  automatic_installation = true,
})

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = false, -- disable virtual text
  signs = {
    active = signs,     -- show signs
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

-- enable keybinds only for when lsp server available
local keymap = vim.keymap
local on_attach = function(client, bufnr)
  print(client.name .. " LSP started")
  local opts = { noremap = true, silent = true, buffer = bufnr }
  keymap.set("n", "gd", vim.lsp.buf.definition, opts)               -- show definition, references
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts)              -- show declaration
  keymap.set("n", "K", vim.lsp.buf.hover, opts)                     -- show hover
  keymap.set("n", "gi", vim.lsp.buf.implementation, opts)           -- show implementation
  keymap.set("n", "gl", vim.diagnostic.open_float, opts)            -- show errors in popup
  keymap.set("n", "ga", vim.lsp.buf.code_action, opts)              -- show code actions
  keymap.set("n", "gr", vim.lsp.buf.references, opts)               -- show references

  keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)           -- format buffer with leader
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format()' ]]) -- format buffer with :Format

  require("illuminate").on_attach(client)
end

-- used to enable autocompletion (assign to every lsp server config)
local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true
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
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte"
      },
    })
  end,

  ["pyright"] = function()
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
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
