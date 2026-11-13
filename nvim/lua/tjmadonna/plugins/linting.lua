return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "go", "python" },
  config = function()
    local lint = require("lint")
    local tools = require("tjmadonna.utils.tools")

    -- All linters that may be used per filetype.
    -- Which ones actually run is decided by vim.g.tools.linters.
    local candidates = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "ruff", "flake8" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    lint.linters_by_ft = {
      go = { "golangcilint" },
    }

    for ft, c in pairs(candidates) do
      lint.linters_by_ft[ft] = tools.get_tools("linters", ft, c)
    end

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
