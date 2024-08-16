return {
	"nvim-lualine/lualine.nvim",
  lazy = false,
  priority = 999,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
        theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			tabline = {
				lualine_a = {
					{
						"buffers",
						icons_enabled = false,
						mode = 2,
						max_length = vim.o.columns,
						use_mode_colors = false,
						hide_filename_extension = false,
						show_filename_only = true,
						symbols = {
							alternate_file = "",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			sections = {
				lualine_a = { "branch" },
				lualine_b = { { "filename", path = 1 } },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
    lualine.refresh() -- prevents tabline UI glitches on startup

		local keymap = vim.keymap -- for conciseness
		for i = 1, 9 do
			keymap.set(
				"n",
				"<leader>" .. i,
				"<cmd>LualineBuffersJump " .. i .. "<cr>",
				{ desc = "Select lualine item " .. i }
			)
		end
	end,
}
