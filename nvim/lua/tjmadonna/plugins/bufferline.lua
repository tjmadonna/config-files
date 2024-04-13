return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")
    local colors = require("gruvbox").palette

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
          fg = colors.light1,
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
