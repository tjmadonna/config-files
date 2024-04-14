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
        theme = "custom_gruvbox",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            icons_enabled = false,
            mode = 2,
            use_mode_colors = false,
            hide_filename_extension = false,
            show_filename_only = true,
            symbols = {
              alternate_file = "",
            },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      sections = {
        lualine_a = { "branch" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>be", "<Cmd>%bd|e#<CR>")
    keymap.set("n", "<leader>ba", "<Cmd>bufdo bd<CR>")

    keymap.set("n", "<leader>1", "<Cmd>LualineBuffersJump 1<CR>")
    keymap.set("n", "<leader>2", "<Cmd>LualineBuffersJump 2<CR>")
    keymap.set("n", "<leader>3", "<Cmd>LualineBuffersJump 3<CR>")
    keymap.set("n", "<leader>4", "<Cmd>LualineBuffersJump 4<CR>")
    keymap.set("n", "<leader>5", "<Cmd>LualineBuffersJump 5<CR>")
    keymap.set("n", "<leader>6", "<Cmd>LualineBuffersJump 6<CR>")
    keymap.set("n", "<leader>7", "<Cmd>LualineBuffersJump 7<CR>")
    keymap.set("n", "<leader>8", "<Cmd>LualineBuffersJump 8<CR>")
    keymap.set("n", "<leader>9", "<Cmd>LualineBuffersJump 9<CR>")
  end,
}
