local dap_setup, dap = pcall(require, "dap")
if not dap_setup then
	print("nvim-dap not found!")
	return
end

local dapui_setup, dapui = pcall(require, "dapui")
if not dapui_setup then
	print("nvim-dap-ui not found!")
	return
end

local neodev_setup, neodev = pcall(require, "neodev")
if not neodev_setup then
	print("neodev not found!")
	return
end

local dapjs_setup, dapjs = pcall(require, "dap-vscode-js")
if not dapjs_setup then
	print("dap-vscode-js not found!")
	return
end


dapui.setup()

neodev.setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
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

-- Python
dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = os.getenv("HOME") .. "/.config/dap/debugpy/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
		--
		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/env/bin/python") == 1 then
				return cwd .. "/env/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
}

dapjs.setup({
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    debugger_path = os.getenv("HOME") .. "/.config/dap/vscode-js-debug"
})

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
dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

local dap_launch = require("tjmadonna.plugins.dap.dap-launch")
dap_launch.DapLaunchLoad(false)

vim.api.nvim_create_user_command("DapLaunchCreate", function()
	dap_launch.DapLaunchCreate()
end, {})

vim.api.nvim_create_user_command("DapLaunchLoad", function()
	dap_launch.DapLaunchLoad(true)
  vim.inspect(dap.configurations)
end, {})
