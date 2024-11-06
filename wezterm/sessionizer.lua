local wezterm = require("wezterm")
local config = require("sessionizer-config")
local act = wezterm.action

local M = {}

local fd = "/opt/homebrew/bin/fd"
local root_path = os.getenv("HOME") .. "/Development/"
local exclude_dirs = config.excluded_search_dirs

M.toggle = function(window, pane)
  local projects = {}

  local fd_args = {
    fd,
    "-HI",
    "-td",
    "^.git$",
    "--max-depth=3",
  }

  for _, dir in ipairs(exclude_dirs) do
    table.insert(fd_args, "--exclude")
    table.insert(fd_args, dir)
  end

  table.insert(fd_args, root_path)

  local success, stdout, stderr = wezterm.run_child_process(fd_args)

  if not success then
    wezterm.log_error("Failed to run fd: " .. stderr)
    return
  end

  for line in stdout:gmatch("([^\n]*)\n?") do
    local project = line:gsub("/.git/$", "")
    local label = project
    local id = project:gsub(".*/", "")
    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(win, _, id, label)
        if id and label then
          win:perform_action(act.SwitchToWorkspace({ name = id, spawn = { cwd = label, label = id } }), pane)
        end
      end),
      fuzzy = true,
      title = "Select project",
      choices = projects,
    }),
    pane
  )
end

return M
