return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local lualine = require("lualine")
		local custom_gruvbox = require("lualine.themes.gruvbox_dark")

		local dark0 = "#3c3836"
		custom_gruvbox.normal.c.bg = dark0
		custom_gruvbox.insert.c.bg = dark0
		custom_gruvbox.visual.c.bg = dark0
		custom_gruvbox.replace.c.bg = dark0
		custom_gruvbox.command.c.bg = dark0
		custom_gruvbox.inactive.c.bg = dark0

		lualine.setup({
			options = {
				theme = custom_gruvbox,
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
