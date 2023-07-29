local null_ls = require("null-ls")
null_ls.setup()

local mason_null_ls = require("mason-null-ls")
mason_null_ls.setup({
  ensure_installed = {
    "flake8",
    "golangci_lint",
    "prettierd",
    "stylua",
  },
  automatic_installation = true,
  handlers = {
    function(source_name, methods)
      mason_null_ls.default_setup(source_name, methods)
    end,
  },
})
