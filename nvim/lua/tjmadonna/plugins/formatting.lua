return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        go = { "gofmt" },
        graphql = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
      },
    })

    local function find_pyproject()
      local path = vim.fn.findfile("pyproject.toml", ".;")
      if path == "" then
        return nil
      end
      return vim.fn.fnamemodify(tostring(path), ":p")
    end

    local function has_isort_config(pyproject_path)
      local file = io.open(pyproject_path, "r")
      if not file then
        return false
      end
      local content = file:read("*a")
      file:close()
      return content:find("%[tool%.isort%]") ~= nil
    end

    local function has_black_config(pyproject_path)
      local file = io.open(pyproject_path, "r")
      if not file then
        return false
      end
      local content = file:read("*a")
      file:close()
      return content:find("%[tool%.black%]") ~= nil
    end

    conform.formatters.isort = {
      prepend_args = function()
        local pyproject = find_pyproject()
        if pyproject and has_isort_config(pyproject) then
          return {}
        end
        return { "--profile", "black", "--line-length", "100" }
      end,
    }

    conform.formatters.black = {
      prepend_args = function()
        local pyproject = find_pyproject()
        if pyproject and has_black_config(pyproject) then
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
