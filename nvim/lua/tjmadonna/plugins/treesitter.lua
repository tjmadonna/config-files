local treesitter_setup, treesitter = pcall(require, "nvim-treesitter")
if not treesitter_setup then
  print("treesitter not found!")
  return
end

local configs_setup, configs = pcall(require, "nvim-treesitter.configs")
if not configs_setup then
  print("treesitter configs not found!")
  return
end

configs.setup({
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  additional_vim_regex_highlighting = false,
  ensure_installed = {
    "lua",
  },
})
