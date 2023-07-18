local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "  ",
    selection_caret = "  ",
    path_display = { "smart" },
    file_ignore_patterns = {
      "env",
      "venv",
      "node_modules",
      ".git",
      ".DS_Store",
    },
  },

  mappings = {
    i = {
      ["<C-c>"] = actions.close,
    },
    n = {
      ["<C-c>"] = actions.close,
    },
  },
})
