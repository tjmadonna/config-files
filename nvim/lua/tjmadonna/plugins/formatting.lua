return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local tools = require("tjmadonna.utils.tools")

    conform.setup({
      formatters_by_ft = {
        css = function()
          return tools.get_tools("css_formatters", { "prettier" })
        end,
        go = { "gofmt" },
        graphql = function()
          return tools.get_tools("graphql_formatters", { "prettier" })
        end,
        hbs = function()
          return tools.get_tools("hbs_formatters", { "prettier" })
        end,
        html = function()
          return tools.get_tools("html_formatters", { "prettier" })
        end,
        javascript = function()
          return tools.get_tools("javascript_formatters", { "prettier" })
        end,
        javascriptreact = function()
          return tools.get_tools("javascriptreact_formatters", { "prettier" })
        end,
        json = function()
          return tools.get_tools("json_formatters", { "prettier" })
        end,
        less = function()
          return tools.get_tools("less_formatters", { "prettier" })
        end,
        lua = function()
          return tools.get_tools("lua_formatters", { "stylua" })
        end,
        markdown = function()
          return tools.get_tools("markdown_formatters", { "prettier" })
        end,
        python = function()
          return tools.get_tools("python_formatters", { "ruff_fix", "ruff_format", "isort", "black" })
        end,
        scss = function()
          return tools.get_tools("scss_formatters", { "prettier" })
        end,
        svelte = function()
          return tools.get_tools("svelte_formatters", { "prettier" })
        end,
        typescript = function()
          return tools.get_tools("typescript_formatters", { "prettier" })
        end,
        typescriptreact = function()
          return tools.get_tools("typescriptreact_formatters", { "prettier" })
        end,
        yaml = function()
          return tools.get_tools("yaml_formatters", { "prettier" })
        end,
      },
    })

    -- commands
    vim.api.nvim_create_user_command("Format", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 3000,
      })
    end, {})

    -- set keymaps
    vim.keymap.set({ "n", "v" }, "<Leader>lf", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 3000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
