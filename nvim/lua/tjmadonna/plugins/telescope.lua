local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = "  ",
    selection_caret = "  ",
    path_display = { "smart" },
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
