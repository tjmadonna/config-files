return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local gruvbox = require("gruvbox")
    local config = gruvbox.config
    local colors = gruvbox.palette

    gruvbox.setup({
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
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = colors.light1, bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "NvimTreeNormalFloat", { bg = colors.dark0_hard })
    vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = colors.dark1 })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = colors.light1 })

    vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = colors.neutral_blue })
    vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = colors.neutral_blue })

    -- copilot
    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#888888", ctermfg = 8 })

    -- dap
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = colors.bright_red })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = colors.bright_blue })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = colors.bright_green })

    -- load the colorscheme
    vim.cmd("colorscheme gruvbox")
  end,
}
