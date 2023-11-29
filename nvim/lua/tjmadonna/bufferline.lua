local colors = require("tjmadonna.gruvbox")

require("bufferline").setup({
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
    separator_style = { "", "" },
    indicator = {
      icon = "",
      style = "",
    },
  },
})
