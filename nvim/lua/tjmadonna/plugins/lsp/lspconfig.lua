local function organize_imports(client_name)
  if client_name == "basedpyright" then
    local tools = require("tjmadonna.utils.tools")
    local formatters = tools.get_tools("python_formatters", { "ruff_fix", "isort" })
    if vim.tbl_contains(formatters, "ruff_fix") then
      require("conform").format({ formatters = { "ruff_fix" }, async = false, timeout_ms = 1000 })
    elseif vim.tbl_contains(formatters, "isort") then
      require("conform").format({ formatters = { "isort" }, async = false, timeout_ms = 1000 })
    end
  else
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" }, diagnostics = vim.diagnostic.get(0) },
      apply = true,
    })
  end
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    -- Diagnostic signs
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    -- Global LSP config (applies to all servers)
    vim.lsp.config("*", {
      capabilities = cmp_nvim_lsp.default_capabilities(),
    })

    -- Keymaps and per-client setup on attach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local opts = { noremap = true, silent = true, buffer = ev.buf }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<Cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show diagnostics in popup"
        keymap.set("n", "gl", vim.diagnostic.open_float, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "gL", "<Cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gI", "<Cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gT", "<Cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        if client and vim.tbl_contains({ "basedpyright", "ts_ls", "svelte" }, client.name) then
          if vim.fn.exists(":OrganizeImports") == 0 then
            vim.api.nvim_create_user_command("OrganizeImports", function()
              organize_imports(client.name)
            end, { desc = "Organize Imports" })
          end
        end
      end,
    })

    vim.api.nvim_create_user_command("LspList", function()
      for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        print(c.name, c.id)
      end
    end, { desc = "List active LSP clients" })

    -- Server specific configs in after/lsp files

    -- Enable all servers
    vim.lsp.enable({
      "basedpyright",
      "clangd",
      "cssls",
      "emmet_ls",
      "gopls",
      "html",
      "jsonls",
      "lua_ls",
      "svelte",
      "tailwindcss",
      "ts_ls",
    })
  end,
}
