return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local colors = {
      black = "#282828",
      white = "#ebdbb2",
      red = "#fb4934",
      green = "#b8bb26",
      blue = "#83a598",
      yellow = "#fe8019",
      gray = "#a89984",
      darkgray = "#3c3836",
      lightgray = "#504945",
      inactivegray = "#7c6f64",
    }

    lualine.setup({
      options = {
        theme = "gruvbox_dark",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "buffers",
            icons_enabled = false,
            mode = 2,
            use_mode_colors = false,
            buffers_color = {
              active = function()
                local mode_names = {
                  n = "lualine_a_normal",
                  i = "lualine_a_insert",
                  v = "lualine_a_visual",
                  V = "lualine_a_visual",
                  c = "lualine_a_command",
                  R = "lualine_a_replace",
                }
                local mode = vim.api.nvim_get_mode().mode
                return mode_names[mode]
              end,
              inactive = function()
                local mode_names = {
                  n = { bg = colors.darkgray, fg = colors.white },
                  i = { bg = colors.lightgray, fg = colors.white },
                  v = { bg = colors.inactivegray, fg = colors.black },
                  V = { bg = colors.inactivegray, fg = colors.black },
                  c = { bg = colors.inactivegray, fg = colors.black },
                  R = { bg = colors.darkgray, fg = colors.white },
                }
                local mode = vim.api.nvim_get_mode().mode
                return mode_names[mode]
              end,
            },
            hide_filename_extension = false,
            show_filename_only = true,
            symbols = {
              alternate_file = "",
            },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "branch" },
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
