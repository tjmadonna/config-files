local null_ls_setup, null_ls = pcall(require, "null-ls")
if not null_ls_setup then
  print("null-ls not found!")
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostic

null_ls.setup({
  debug = false,
  sources = {
    formatting.rustfmt,
    formatting.prettier,
    formatting.stylua,
    -- formatting.black.with({ extra_args = { extra_args = { "--fast"} }}),
    -- diagnostics.eslint,
    -- diagnostics.flake8,
  },
})
