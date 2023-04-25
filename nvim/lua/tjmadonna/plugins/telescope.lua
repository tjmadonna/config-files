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

local builtin_setup, builtin = pcall(require, "telescope.builtin")
if not builtin_setup then
  print("telescope builtin not found!")
  return
end

local themes_setup, themes = pcall(require, "telescope.themes")
if not themes_setup then
  print("telescope themes not found!")
  return
end

telescope.setup {
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
}

local keymap = vim.keymap

-- telescope
keymap.set("n", "<leader>pf", function() -- find all files without the previewer
  builtin.find_files(themes.get_dropdown({ previewer = false}))
end)

keymap.set("n", "<leader>pg", function() -- find files within git without the previewer
  builtin.git_files(themes.get_dropdown({ previewer = false}))
end)

keymap.set("n", "<leader>ps", function() -- grep with in project
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
