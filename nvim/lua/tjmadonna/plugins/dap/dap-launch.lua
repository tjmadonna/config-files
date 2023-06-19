local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local template_configs = {
	{
		name = "Chrome",
		config = {
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome against localhost",
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}/src",
			cwd = "${workspaceFolder}/src",
		},
	},
	{
		name = "Go",
		config = {
			name = "Debug Go App",
			type = "go",
			request = "launch",
			program = "${workspaceFolder}/app",
		},
	},
	{
		name = "Python",
		config = {
			name = "Python",
			type = "python",
			request = "launch",
			program = "${file}",
			console = "integratedTerminal",
			justMyCode = true,
		},
	},
	{
		name = "Python: Flask",
		config = {
			name = "Python: Flask",
			type = "python",
			request = "launch",
			module = "flask",
			env = {
				FLASK_APP = "app.py",
				FLASK_DEBUG = "1",
			},
			args = {
				"run",
				"--no-debugger",
				"--no-reload",
			},
			jinja = true,
			justMyCode = true,
		},
	},
}

local type_to_filetypes = {
	["pwa-chrome"] = { "javascript", "typescript" },
	["go"] = { "go" },
	["python"] = { "python" },
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

function M.DapLaunchCreate(opts)
	opts = opts or {}

	pickers
		.new(opts, {
			prompt_title = "colors",
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
			sorter = conf.generic_sorter(opts),
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
end

function M.DapLaunchLoad(show_error)
	local show = show_error or true

	if vim.fn.filereadable("./.vscode/launch.json") == 1 then
		require("dap.ext.vscode").load_launchjs(nil, type_to_filetypes)
	else
		if show then
			print("launch.json does not exist")
		end
	end
end

return M
