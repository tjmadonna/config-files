return {
	"nvim-neotest/neotest",
	ft = "python",
	dependencies = {
		{ "nvim-neotest/nvim-nio", lazy = true },
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "antoinemadec/FixCursorHold.nvim", lazy = true },
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
		{ "nvim-neotest/neotest-python", lazy = true },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "--log-level", "DEBUG" },
					runner = "pytest",
					python = "./venv/bin/python",
					is_test_file = function(file_path)
						-- Check if the file is a test file.
						return file_path:match("test_.*%.py$") ~= nil
					end,
				}),
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run the nearest test" })
		keymap.set(
			"n",
			"<leader>td",
			"<cmd>require('neotest').run.run({strategy = 'dap'})<cr>",
			{ desc = "Debug the nearest test" }
		)
		keymap.set(
			"n",
			"<leader>tu",
			"<cmd>lua require('neotest').summary.toggle()<cr>",
			{ desc = "Toggle the test summary panel" }
		)
		keymap.set(
			"n",
			"<leader>tp",
			"<cmd>lua require('neotest').output_panel.toggle()<cr>",
			{ desc = "Toggle the test output panel" }
		)
	end,
}
