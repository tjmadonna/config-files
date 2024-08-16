vim.g.copilot_ignore_node_version = "v:true"

return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = false,
				auto_refresh = false,
				keymap = {
					jump_prev = false,
					jump_next = false,
					accept = false,
					refresh = false,
					open = false,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = false,
					dismiss = false,
					accept_word = false,
					accept_line = false,
					next = false,
					prev = false,
				},
			},
			filetypes = {
				markdown = false,
				["*"] = true,
			},
		})
	end,
}
