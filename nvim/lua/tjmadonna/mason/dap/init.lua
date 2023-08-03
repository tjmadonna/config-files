require("tjmadonna.mason.dap.launch")
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

local dap_launch = require("tjmadonna.mason.dap.launch")
dap_launch.DapLaunchLoad()

vim.api.nvim_create_user_command("DapLaunchCreate", function()
	dap_launch.DapLaunchCreate()
end, {})

vim.api.nvim_create_user_command("DapLaunchLoad", function()
	dap_launch.DapLaunchLoad()
end, {})

vim.api.nvim_create_user_command("DapLaunchOpen", function()
	dap_launch.DapLaunchOpen()
end, {})

vim.api.nvim_create_user_command("DapScopesExpand", function()
	dapui.float_element("scopes", { enter = true })
end, {})

vim.api.nvim_create_user_command("DapStacksExpand", function()
	dapui.float_element("stacks", { enter = true })
end, {})

vim.api.nvim_create_user_command("DapBreakpointsExpand", function()
	dapui.float_element("breakpoints", { enter = true })
end, {})
