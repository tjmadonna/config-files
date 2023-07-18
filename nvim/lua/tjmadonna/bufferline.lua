local colors = require("tjmadonna.gruvbox")

local function title()
  local cwd = vim.fn.getcwd(0)
  local dir = vim.fn.split(cwd, "/")
  return vim.fn.toupper(dir[#dir])
end

require("bufferline").setup({
  highlights = {
    fill = {
      bg = colors.dark1,
    },
    background = {
      bg = colors.dark1,
      -- fg = colors.text,
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
      -- fg = colors.text,
    },
    buffer_selected = {
      bg = colors.dark0_hard,
    },
    numbers = {
      bg = colors.dark1,
      -- fg = colors.text,
    },
    numbers_visible = {
      bg = colors.dark1,
    },
    numbers_selected = {
      bg = colors.dark0_hard,
    },
    separator = {
      bg = colors.dark0_hard,
    },
    offset_separator = {
      bg = colors.dark0_hard,
    },


    -- separator_selected = {
    --   bg = "#FF0000",
    -- },
    -- separator_visible = {
    --   bg = "#00FF00",
    -- },
    -- tab = {
    --   bg = "#00FF00",
    -- },
    -- tab_selected = {
    --   bg = "#00FF00",
    -- },
    -- tab_separator = {
    --   bg = "#FF0000",
    -- },
    -- tab_separator_selected = {
    --   bg = "#00FF00",
    -- },
    -- tab_close = {
    --   bg = "#0000FF",
    -- },
    -- pick_selected = {
    --   bg = "#FF0000",
    -- },
    -- pick_visible = {
    --   bg = "#00FF00",
    -- },
    -- pick = {
    --   bg = "#0000FF",
    -- },
  },
  options = {
    numbers = "ordinal",
    themable = true,
    show_buffer_icons = false,
    separator_style = {"", ""},
    indicator = {
      icon = "",
      style = "",
    },
  },
})
