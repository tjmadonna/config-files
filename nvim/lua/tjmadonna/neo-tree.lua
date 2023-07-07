vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local symbols = {
  -- Change type
  added     = "",
  modified  = "",
  deleted   = "",
  renamed   = "",
  -- Status type
  untracked = "U",
  ignored   = "",
  unstaged  = "M",
  staged    = "S",
  conflict  = "C",
}

-- NeoTreeGitAdded           File name when the git status is added.
-- NeoTreeGitConflict        File name when the git status is conflict.
-- NeoTreeGitDeleted         File name when the git status is deleted.
-- NeoTreeGitIgnored         File name when the git status is ignored.
-- NeoTreeGitModified        File name when the git status is modified.

-- NeoTreeGitUnstaged        Used for git unstaged symbol.
-- NeoTreeGitUntracked       File name when the git status is untracked.
-- NeoTreeGitStaged          Used for git staged symbol.

vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = "#525565" }) -- filename

-- vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = colors.git.add }) -- filename
-- vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = colors.git.add }) -- filename
-- vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = colors.git.add }) -- filename
-- vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { fg = colors.git.add }) -- filename
-- vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg=colors.blue }) -- filename
--
-- vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = colors.blue }) -- symbol
-- vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = colors.green }) -- symbol
-- vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = colors.yellow }) -- symbol

vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#a9b1d6" })
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#a9b1d6" })

-- untracked = "A",
-- ignored   = "I",
-- unstaged  = "M",
-- staged    = "M",
-- conflict  = "C",


-- NeoTreeGitConflict
-- NeoTreeGitDeleted
-- NeoTreeGitIgnored
-- NeoTreeGitUnstaged
-- NeoTreeGitUntracked
-- NeoTreeGitStaged

-- NeoTreeGitAdded
-- NeoTreeGitModified


require("neo-tree").setup({
  hide_root_node = true,
  sort_case_insensitive = true,
  filesystem = {
    filtered_items = {
      show_hidden_count = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        "node_modules",
        ".DS_Store",
        "env",
        "venv",
        ".git",
      },
      hide_by_pattern = {
      },
    },
  },
  window = {
    width = 30,
  },
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      default = "-",
    },
    modified = {
      symbol = "M",
      highlight = "NeoTreeModified",
    },
    git_status = {
      symbols = symbols,
    },
  },
})
