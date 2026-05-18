return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    local background = "#0e0e0e"
    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "mocha",
      term_colors = true,
      transparent_background = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = background,
          mantle = background,
          crust = background,
        },
      },
      integrations = {
        cmp = true,
        dap_ui = true,
        gitsigns = true,
        neotest = false,
        nvimtree = false,
        treesitter = true,
        notify = false,
        telescope = {
          enabled = true,
        },
        lualine = {},
      },
    })

    -- load the colorscheme
    vim.cmd("colorscheme catppuccin")
  end,
}
