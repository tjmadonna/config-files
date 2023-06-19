local dap = require("dap")
local dap_mason = require("mason-nvim-dap")
local dapui = require("dapui")
local neodev = require("neodev")
local dapjs = require("dap-vscode-js")

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
			size = 40,
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

neodev.setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

dap_mason.setup({
	ensure_installed = {
		"delve",
		"python",
	},
	automatic_installation = false,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

-- Load .vscode/launch.json
vim.cmd([[ command! LoadDapConfig execute "lua require('dap.ext.vscode').load_launchjs(nil, {})" ]])

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "󰜴", texthl = "", linehl = "", numhl = "" })

dapjs.setup({
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
	debugger_path = os.getenv("HOME") .. "/.config/dap/vscode-js-debug",
})

local dap_launch = require("tjmadonna.plugins.dap.dap-launch")
dap_launch.DapLaunchLoad(false)

vim.api.nvim_create_user_command("DapLaunchCreate", function()
	dap_launch.DapLaunchCreate()
end, {})

vim.api.nvim_create_user_command("DapLaunchLoad", function()
	dap_launch.DapLaunchLoad(true)
	vim.inspect(dap.configurations)
end, {})

vim.api.nvim_create_user_command("DapScopes", function()
	dapui.float_element("scopes", { enter = true })
end, {})

vim.api.nvim_create_user_command("DapStacks", function()
	dapui.float_element("stacks", { enter = true })
end, {})

vim.api.nvim_create_user_command("DapBreakpoints", function()
	dapui.float_element("breakpoints", { enter = true })
end, {})

-- Python
-- dap.adapters.python = function(cb, config)
-- 	if config.request == "attach" then
-- 		---@diagnostic disable-next-line: undefined-field
-- 		local port = (config.connect or config).port
-- 		---@diagnostic disable-next-line: undefined-field
-- 		local host = (config.connect or config).host or "127.0.0.1"
-- 		cb({
-- 			type = "server",
-- 			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
-- 			host = host,
-- 			options = {
-- 				source_filetype = "python",
-- 			},
-- 		})
-- 	else
-- 		cb({
-- 			type = "executable",
-- 			command = os.getenv("HOME") .. "/.config/dap/debugpy/bin/python",
-- 			args = { "-m", "debugpy.adapter" },
-- 			options = {
-- 				source_filetype = "python",
-- 			},
-- 		})
-- 	end
-- end
--
-- dap.configurations.python = {
-- 	{
-- 		-- The first three options are required by nvim-dap
-- 		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
-- 		request = "launch",
-- 		name = "Launch file",
--
-- 		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
-- 		--
-- 		program = "${file}", -- This configuration will launch the current file if used.
-- 		pythonPath = function()
-- 			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- 			local cwd = vim.fn.getcwd()
-- 			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
-- 				return cwd .. "/venv/bin/python"
-- 			elseif vim.fn.executable(cwd .. "/env/bin/python") == 1 then
-- 				return cwd .. "/env/bin/python"
-- 			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
-- 				return cwd .. "/.venv/bin/python"
-- 			else
-- 				return "/usr/bin/python"
-- 			end
-- 		end,
-- 	},
-- }

-- for _, language in ipairs({ "typescript", "javascript" }) do
--   dap.configurations[language] = {
--     {
--       type = "pwa-chrome",
--       request = "launch",
--       name = "Launch Chrome against localhost",
--       url = "http://localhost:3000",
--       webRoot = "${workspaceFolder}/src",
--       cwd = "${workspaceFolder}/src"
--     },
--   }
-- end

-- Go
-- dap.adapters.go = {
-- 	type = "server",
-- 	port = "${port}",
-- 	executable = {
-- 		command = "dlv",
-- 		args = { "dap", "-l", "127.0.0.1:${port}" },
-- 	},
-- }
