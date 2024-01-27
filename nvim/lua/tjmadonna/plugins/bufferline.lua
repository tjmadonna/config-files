local colors = {
  dark0_hard = "#1d2021",
  dark1 = "#3c3836",
  dark2 = "#504945",
  dark3 = "#665c54",
  dark4 = "#7c6f64",
  red = "#fb4934",
  neutral_red = "#cc241d",
  faded_red = "#9d0006",
  green = "#b8bb26",
  aqua = "#8ec07c",
  yellow = "#d79921",
  white = "#ffffff",
  text = "#ebdbb2",
}

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      highlights = {
        fill = {
          bg = colors.dark1,
        },
        background = {
          bg = colors.dark1,
        },
        close_button = {
          bg = colors.dark1,
        },
        close_button_visible = {
          bg = colors.dark1,
        },
        close_button_selected = {
          bg = colors.dark0_hard,
        },
        buffer_visible = {
          bg = colors.dark1,
        },
        buffer_selected = {
          bg = colors.dark0_hard,
        },
        numbers = {
          bg = colors.dark1,
        },
        numbers_visible = {
          bg = colors.dark1,
        },
        numbers_selected = {
          bg = colors.dark0_hard,
        },
        separator = {
          bg = colors.dark1,
        },
        separator_selected = {
          bg = colors.dark1,
        },
        separator_visible = {
          bg = colors.dark1,
        },
        offset_separator = {
          bg = colors.dark1,
        },
        duplicate_selected = {
          bg = colors.dark0_hard,
          fg = colors.text,
        },
        duplicate_visible = {
          bg = colors.dark1,
        },
        duplicate = {
          bg = colors.dark1,
        },
        indicator_visible = {
          bg = colors.dark1,
        },
        indicator_selected = {
          bg = colors.dark0_hard,
        },
        modified = {
          bg = colors.dark1,
        },
        modified_visible = {
          bg = colors.dark1,
        },
        modified_selected = {
          bg = colors.dark0_hard,
        },
      },
      options = {
        numbers = "ordinal",
        themable = true,
        show_buffer_icons = false,
        separator_style = { "", "" },
        indicator = {
          icon = "",
          style = "",
        },
      },
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>bp", "<Cmd>BufferLineCyclePrev<CR>")
    keymap.set("n", "<leader>bn", "<Cmd>BufferLineCycleNext<CR>")
    keymap.set("n", "<leader>bd", "<Cmd>bd<CR>")
    keymap.set("n", "<leader>be", "<Cmd>%bd|e#<CR>")
    keymap.set("n", "<leader>ba", "<Cmd>bufdo bd<CR>")
    keymap.set("n", "<leader>b.", "<Cmd>BufferLineMoveNext<CR>")
    keymap.set("n", "<leader>b,", "<Cmd>BufferLineMovePrev<CR>")

    keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
    keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
    keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
    keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
    keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
    keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
    keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
    keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
    keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
  end,
}
