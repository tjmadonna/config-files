local colors = require("tjmadonna.gruvbox")

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = colors.green, bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = colors.aqua, bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = colors.red, bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = colors.neutral_red, bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = colors.faded_red, bg = colors.dark0_hard })
vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = colors.white, bg = colors.dark0_hard })

require("gitsigns").setup()
