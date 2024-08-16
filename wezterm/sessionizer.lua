local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local fd = "/opt/homebrew/bin/fd"
local rootPath = os.getenv("HOME") .. "/Development/"

M.toggle = function(window, pane)
  local projects = {}

  local success, stdout, stderr = wezterm.run_child_process({
    fd,
    "-HI",
    "-td",
    "^.git$",
    "--max-depth=3",
    rootPath,
  })

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
