vim.g.copilot_filetypes = {
  ["*"] = true,
  ["*.md"] = false,
}

return {
  "github/copilot.vim",
  event = "InsertEnter",
}
