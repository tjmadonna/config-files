local template_configs = {
  {
    name = "Chrome",
    config = {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch and debug in Chrome",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      skipFiles = { "<node_internals>/**/*.js" },
      sourceMaps = true,
      userDataDir = true,
    },
  },
  {
    name = "Go",
    config = {
      name = "Debug Go App",
      type = "go",
      request = "launch",
      cwd = "${workspaceFolder}",
      program = "${workspaceFolder}/app",
    },
  },
  {
    name = "Python",
    config = {
      type = "python",
      program = "main.py",
      request = "launch",
      cwd = "${workspaceFolder}/src",
      console = "integratedTerminal",
      justMyCode = true,
      name = "Python",
      args = {},
      pythonPath = "${workspaceFolder}/venv/bin/python",
    },
  },
}

local function _write_to_launch_file(launch)
  local encoded = vim.json.encode(launch)
  local f = io.open("./.vscode/launch.json", "w")
  if not f then
    print("launch could not be created")
    return false
  end
  f:write(encoded)
  f:close()
  return true
end

local function _read_from_launch_file()
  local f = io.open("./.vscode/launch.json", "r")
  if not f then
    print("launch.json does not exist")
    return
  end

  local config = vim.json.decode(f:read("*all"), { luanil = { object = true, array = true } })
  f:close()
  return config
end

vim.api.nvim_create_user_command("DapLaunchCreate", function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "Dap Configurations",
      finder = finders.new_table({
        results = template_configs,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name,
            ordinal = entry.name,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()

          -- check if .vscode/ directory exists in current directory
          if vim.fn.isdirectory("./.vscode") == 0 then
            vim.fn.mkdir(".vscode")
          end

          -- check if launch.json exists in .vscode/ directory
          if vim.fn.filereadable("./.vscode/launch.json") == 1 then
            local launch = _read_from_launch_file()
            if not launch then
              print("launch.json could not be read")
              return
            end
            table.insert(launch.configurations, selection.value.config)
            local result = _write_to_launch_file(launch)
            if not result then
              print("could not add configuration to launch.json")
              return
            end
          else
            local launch = {
              version = "0.2.0",
              configurations = {
                selection.value.config,
              },
            }
            local result = _write_to_launch_file(launch)
            if not result then
              print("launch could not be created")
              return
            end
            return
          end
        end)
        return true
      end,
    })
    :find()
end, {})

local type_to_filetypes = {
  ["pwa-chrome"] = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  ["go"] = { "go" },
  ["python"] = { "python" },
}

-- load dap configuration from .vscode/launch.json, if exist
vim.api.nvim_create_user_command("DapLaunchLoad", function()
  if vim.fn.filereadable("./.vscode/launch.json") == 1 then
    if pcall(require("dap.ext.vscode").load_launchjs, nil, type_to_filetypes) then
      print("launch.json loaded")
    else
      print("launch.json could not be loaded")
    end
  else
    print("launch.json does not exist")
  end
end, {})

return {
  "mfussenegger/nvim-dap",
  ft = "javascript,typescript,typescriptreact,javascriptreact,go,python",
  dependencies = {
    { "rcarriga/nvim-dap-ui", lazy = true },
    { "mxsdev/nvim-dap-vscode-js", ft = "javascript,typescript,typescriptreact,javascriptreact" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dapjs = require("dap-vscode-js")

    -- python
    dap.adapters.python = {
      type = "executable",
      command = "debugpy-adapter",
      options = {
        source_filetype = "python",
      },
    }

    -- go
    dap.adapters.go = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }

    -- js
    dapjs.setup({
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      debugger_path = vim.fn.stdpath("data") .. "/mason/packages/vscode-js-debug",
    })

    -- chrome
    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    -- dap ui setup
    dapui.setup({
      floating = {
        max_width = 0.99,
        max_height = 0.99,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.55,
            },
            {
              id = "stacks",
              size = 0.15,
            },
            {
              id = "breakpoints",
              size = 0.15,
            },
            {
              id = "watches",
              size = 0.15,
            },
          },
          position = "left",
          size = 50,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>du", function()
      dapui.toggle()
    end, { desc = "Toggle debugging UI" })
    keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>", { desc = "Start or continue debugging" })
    keymap.set("n", "<leader>dt", "<cmd>DapTerminate<cr>", { desc = "Terminate debugging" })
    keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle debug breakpoint" })

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue debug session" })
    vim.keymap.set("n", "<F6>", dap.continue, { desc = "Terminate debug session" })

    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Step into next debug statement" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Step over next debug statement" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Step out of next debug statement" })
  end,
}
