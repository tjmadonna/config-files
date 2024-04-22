-- commands
vim.api.nvim_create_user_command("LintReload", function()
	vim.cmd("Lazy reload nvim-lint")
end, {})

return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		local function conditional_lint(filename, linter)
			-- disable linter if there is no config file
			local files = vim.fn.glob("./" .. filename .. "*") -- some comment
			if files == "" then
				return {}
			end
			return { linter }
		end

		local enabled_linters = {
			["eslint_d"] = conditional_lint(".eslint", "eslint_d"),
			["flake8"] = conditional_lint(".flake8", "flake8"),
			["golangci-lint"] = { "golangcilint" },
		}

		lint.linters_by_ft = {
			go = enabled_linters["golangci-lint"],
			javascript = enabled_linters["eslint_d"],
			javascriptreact = enabled_linters["eslint_d"],
			svelte = enabled_linters["eslint_d"],
			python = enabled_linters["flake8"],
			typescript = enabled_linters["eslint_d"],
			typescriptreact = enabled_linters["eslint_d"],
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- set keymaps
		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
