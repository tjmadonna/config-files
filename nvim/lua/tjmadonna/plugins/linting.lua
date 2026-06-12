return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  ft = "javascript,typescript,typescriptreact,javascriptreact,go,python",
  config = function()
    local lint = require("lint")
    local tools = require("tjmadonna.utils.tools")

    lint.linters_by_ft = {
      go = { "golangcilint" },
      javascript = tools.get_tools("javascript_linters", { "eslint_d" }),
      javascriptreact = tools.get_tools("javascriptreact_linters", { "eslint_d" }),
      svelte = tools.get_tools("svelte_linters", { "eslint_d" }),
      python = tools.get_tools("python_linters", { "ruff", "flake8" }),
      typescript = tools.get_tools("typescript_linters", { "eslint_d" }),
      typescriptreact = tools.get_tools("typescriptreact_linters", { "eslint_d" }),
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- commands
    vim.api.nvim_create_user_command("LintReload", function()
      vim.cmd("Lazy reload nvim-lint")
    end, {})

    vim.api.nvim_create_user_command("LintList", function()
      local filetype = vim.bo.filetype
      local linters = lint.linters_by_ft[filetype]
      if linters == nil then
        print("No current linters for '" .. filetype .. "'")
        return
      end

      local linters_str = table.concat(linters, ", ")
      print("Current linters for '" .. filetype .. "': " .. linters_str)
    end, {})

    -- set keymaps
    vim.keymap.set("n", "<Leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
