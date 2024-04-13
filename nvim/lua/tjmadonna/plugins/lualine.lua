return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")

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
            show_modified_status = true,
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
