local config = require("gruvbox").config
-- local colors = require("gruvbox.palette").get_base_colors(vim.o.background, config.contrast)

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

-- LSP
vim.api.nvim_set_hl(0, "DiagnosticError", { bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = colors.dark0_hard })

require("gruvbox").setup({
  contrast = "hard",
  overrides = {
    SignColumn = { bg = "#1d2021" },

    DiffDelete = { fg = colors.red, bg = colors.dark0_hard, reverse = config.inverse },
    DiffAdd = { fg = "#00FF00", bg = colors.dark0_hard, reverse = config.inverse },
    DiffChange = { fg = colors.aqua, bg = colors.dark0_hard, reverse = config.inverse },
    DiffText = { fg = colors.yellow, bg = colors.dark0_hard, reverse = config.inverse },
    -- ColorLine = { bg = "#FF0000" },
    -- ColorColumn = { bg = "#FF0000" },
  },
})
vim.cmd("colorscheme gruvbox")

return colors
