return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local custom_gruvbox = require("lualine.themes.gruvbox_dark")

    local dark0 = "#3c3836"
    custom_gruvbox.normal.c.bg = dark0
    custom_gruvbox.insert.c.bg = dark0
    custom_gruvbox.visual.c.bg = dark0
    custom_gruvbox.replace.c.bg = dark0
    custom_gruvbox.command.c.bg = dark0
    custom_gruvbox.inactive.c.bg = dark0

    lualine.setup({
      options = {
        theme = custom_gruvbox,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "branch" },
        lualine_b = { { "filename", path = 1 } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
