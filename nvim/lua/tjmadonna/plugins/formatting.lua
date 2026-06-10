return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local python_utils = require("tjmadonna.utils.python")

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        go = { "gofmt" },
        graphql = { "prettier" },
        hbs = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        less = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = python_utils.has_ruff_config() and { "ruff_fix", "ruff_format" } or { "isort", "black" },
        scss = { "prettier" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
      },
    })

    conform.formatters.isort = {
      prepend_args = function()
        local pyproject = python_utils.find_pyproject()
        if pyproject and python_utils.has_isort_config(pyproject) then
          return {}
        end
        return { "--profile", "black", "--line-length", "100" }
      end,
    }

    conform.formatters.black = {
      prepend_args = function()
        local pyproject = python_utils.find_pyproject()
        if pyproject and python_utils.has_black_config(pyproject) then
          return {}
        end
        return { "--line-length", "100" }
      end,
    }

    -- commands
    vim.api.nvim_create_user_command("Format", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, {})

    -- set keymaps
    vim.keymap.set({ "n", "v" }, "<Leader>lf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
