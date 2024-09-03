return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local gruvbox = require("gruvbox")
    local colors = gruvbox.palette
    colors.dark0_bg = "#17191A"

    gruvbox.setup({
      contrast = "hard",
      palette_overrides = {
        dark0_hard = colors.dark0_bg,
      },
      overrides = {
        NormalFloat = { bg = colors.dark0_bg, fg = colors.fg1 },
        WinSeparator = { fg = colors.light1 },

        DiffDelete = { bg = colors.faded_red, fg = colors.bg0 },
        DiffAdd = { bg = colors.faded_green, fg = colors.bg0 },
        DiffChange = { bg = colors.faded_aqua, fg = colors.bg0 },
        DiffText = { bg = colors.bright_aqua, fg = colors.bg0 },

        GitSignsAdd = { link = "DiffAdd" },
        GitSignsChange = { link = "DiffChange" },
        GitSignsDelete = { link = "DiffDelete" },

        SignColumn = { bg = colors.dark0_bg },

        DiagnosticError = { bg = colors.dark1 },
        DiagnosticSignError = { bg = colors.dark1 },
        DiagnosticSignHint = { bg = colors.dark1 },
        DiagnosticSignInfo = { bg = colors.dark1 },
        DiagnosticSignWarn = { bg = colors.dark1 },
      },
    })

    -- nvim-tree
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.light1, bg = colors.dark0_bg })
    vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = colors.dark0_bg })
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = colors.dark1 })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.light1 })

    vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = colors.neutral_blue })
    vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = colors.neutral_blue })

    -- copilot
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#888888", ctermfg = 8 })

    -- dap
    vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = colors.bright_red, ctermbg = 0 })
    vim.api.nvim_set_hl(0, "DapLogPoint", { fg = colors.bright_blue, ctermbg = 0 })
    vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.bright_green, ctermbg = 0 })

    -- load the colorscheme
    vim.cmd("colorscheme gruvbox")
  end,
}
