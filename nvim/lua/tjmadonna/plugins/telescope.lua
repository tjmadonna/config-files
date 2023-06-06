local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  print("telescope not found!")
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  print("telescope actions not found!")
  return
end

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
