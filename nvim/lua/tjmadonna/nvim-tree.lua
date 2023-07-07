local colors = require("tjmadonna.gruvbox")

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = colors.dark1 })
vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = colors.dark3 })

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    signcolumn = "no",
  },
  renderer = {
    root_folder_label = false,
    icons = {
      show = {
        file = true,
        folder = false,
        folder_arrow = true,
        git = true,
        modified = true,
      },
    },
  },
  filters = {
    custom = {
      "node_modules",
      ".DS_Store",
      "env",
      "venv",
      ".git",
      "obj",
    },
  },
  git = {
    ignore = false,
  },
})
