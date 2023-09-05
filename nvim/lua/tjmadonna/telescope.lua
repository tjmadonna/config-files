local telescope = require("telescope")
local settings = require("tjmadonna.shared-settings")

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = "  ",
		selection_caret = "  ",
		path_display = { "smart" },
		file_ignore_patterns = settings.ignored_patterns,
	},

	mappings = {
		i = {
			["<C-c>"] = actions.close,
		},
		n = {
			["<C-c>"] = actions.close,
		},
	},
})
