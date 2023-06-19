local colors = {
  blue   = "#7aa2f7",
  green  = "#9ece6a",
  purple = "#9d7cd8",
  cyan   = "#7dcfff",
  red1   = "#f7768e",
  red2   = "#c53b53",
  yellow = "#ffc777",
  fg     = "#a9b1d6",
  bg     = "#16161e",
  gray1  = "#828997",
  gray2  = "#2c323c",
  gray3  = "#3e4452",
}

local tokyonight = {
  normal = {
    a = { fg = colors.bg, bg = colors.green, gui = 'bold' },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  command = { a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' } },
  insert = { a = { fg = colors.bg, bg = colors.blue, gui = 'bold' } },
  visual = { a = { fg = colors.bg, bg = colors.purple, gui = 'bold' } },
  terminal = { a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' } },
  replace = { a = { fg = colors.bg, bg = colors.red1, gui = 'bold' } },
  inactive = {
    a = { fg = colors.gray1, bg = colors.bg, gui = 'bold' },
    b = { fg = colors.gray1, bg = colors.bg },
    c = { fg = colors.gray1, bg = colors.gray2 },
  },
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = tokyonight,
    component_separators = "|",
    section_separators = "",
  },
})
