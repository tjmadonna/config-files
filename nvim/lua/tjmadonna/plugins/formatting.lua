return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local tools = require("tjmadonna.utils.tools")

    -- All formatters that may be used per filetype.
    -- Which ones actually run is decided by vim.g.tools.formatters.
    local candidates = {
      css = { "prettier" },
      graphql = { "prettier" },
      hbs = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      less = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      python = { "ruff_fix", "ruff_format", "isort", "black" },
      scss = { "prettier" },
      svelte = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      yaml = { "prettier" },
    }

    ---@type table<string, table|function>
    local formatters_by_ft = {
      go = { "gofmt" },
    }

    for ft, c in pairs(candidates) do
      formatters_by_ft[ft] = function()
        return tools.get_tools("formatters", ft, c)
      end
    end

    conform.setup({
      formatters_by_ft = formatters_by_ft,
    })

    -- commands
    vim.api.nvim_create_user_command("Format", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 3000,
      })
    end, {})

    vim.api.nvim_create_user_command("FormatList", function()
      local filetype = vim.bo.filetype
      local formatters = conform.list_formatters(0)

      if #formatters == 0 then
        -- conform falls back to the LSP when nothing is configured (lsp_fallback = true)
        local lsp_names = {}
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if client.server_capabilities.documentFormattingProvider then
            table.insert(lsp_names, client.name)
          end
        end

        if #lsp_names > 0 then
          print("No formatters for '" .. filetype .. "', LSP fallback: " .. table.concat(lsp_names, ", "))
        else
          print("No formatters for '" .. filetype .. "'")
        end
        return
      end

      local parts = {}
      for _, f in ipairs(formatters) do
        local status = f.available and "" or " (not installed)"
        table.insert(parts, f.name .. status)
      end
      print("Current formatters for '" .. filetype .. "': " .. table.concat(parts, ", "))
    end, { desc = "List active formatters for the current buffer" })

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
