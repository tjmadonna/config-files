local colors = {
  dark0_hard = "#1d2021",
  dark1 = "#3c3836",
  dark2 = "#504945",
  dark3 = "#665c54",
  dark4 = "#7c6f64",
  red = "#fb4934",
  neutral_blue = "#458588",
  neutral_red = "#cc241d",
  faded_red = "#9d0006",
  green = "#b8bb26",
  aqua = "#8ec07c",
  yellow = "#d79921",
  white = "#ffffff",
  text = "#ebdbb2",
}

return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local config = require("gruvbox").config
    require("gruvbox").setup({
      contrast = "hard",
      overrides = {
        DiffAdd = { fg = colors.green, bg = colors.dark0_hard, reverse = config.inverse },
        DiffChange = { fg = colors.aqua, bg = colors.dark0_hard, reverse = config.inverse },
        DiffDelete = { fg = colors.red, bg = colors.dark0_hard, reverse = config.inverse },
        DiffText = { fg = colors.yellow, bg = colors.dark0_hard, reverse = config.inverse },
        SignColumn = { bg = colors.dark0_hard },
      },
    })

    -- lsp
    vim.api.nvim_set_hl(0, "DiagnosticError", { bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = colors.dark0_hard })

    -- gitsigns
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.aqua, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = colors.neutral_red, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = colors.faded_red, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = colors.white, bg = colors.dark0_hard })

    -- nvim-tree
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.text, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = colors.dark1 })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.text })

    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=colors.neutral_blue ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=colors.neutral_blue ]])

    -- copilot
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#888888", ctermfg = 8 })

    -- load the colorscheme
    vim.cmd("colorscheme gruvbox")
  end,
}
