local wezterm = require("wezterm")
local catppuccin = require("catppuccin")
local sessionizer = require("sessionizer")

local config = wezterm.config_builder()

-- Color constants
local bgColor = "#0e0e0e"
local fgColor = catppuccin.text
local tabBarBgColor = catppuccin.lavender
local tabBarFgColor = bgColor

-- Events
wezterm.on("maximize-window", function(window, _)
  local screen = wezterm.gui.screens()
  local window_dims = window:get_dimensions()
  if window_dims.pixel_width >= screen.active.width then
    window:restore()
  else
    window:maximize()
  end
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  if tab.is_active then
    return {
      { Text = "     " .. tab.active_pane.title .. "  *  " },
    }
  end

  return {
    { Text = "     " .. tab.active_pane.title .. "      " },
  }
end)

wezterm.on("update-status", function(window, pane)
  window:set_left_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Background = { Color = bgColor } },
    { Foreground = { Color = fgColor } },
    { Text = window:active_workspace() .. "     " },
  }))
end)

-- Font
config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
config.font_size = 16

-- Tab bar
config.enable_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 20
config.use_fancy_tab_bar = false

-- Colors
config.color_scheme = "Catppuccin Mocha"
config.colors = {
  background = bgColor,
  tab_bar = {
    background = bgColor,
    active_tab = {
      bg_color = tabBarBgColor,
      fg_color = tabBarFgColor,
    },
    inactive_tab = {
      bg_color = bgColor,
      fg_color = fgColor,
    }
  }
}

config.leader = { key = "a", mods = "CTRL" }
config.keys = {
  { key = "m", mods = "CTRL",     action = wezterm.action.DisableDefaultAssignment },
  { key = "m", mods = "CMD|CTRL", action = wezterm.action.EmitEvent("maximize-window") },
  { key = "f", mods = "CTRL",     action = wezterm.action_callback(sessionizer.toggle) },
  { key = "c", mods = "LEADER",   action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
  { key = "x", mods = "LEADER",   action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
  { key = "p", mods = "LEADER",   action = wezterm.action.ActivateTabRelative(-1) },
  { key = "n", mods = "LEADER",   action = wezterm.action.ActivateTabRelative(1) },
  { key = "1", mods = "LEADER",   action = wezterm.action({ ActivateTab = 0 }) },
  { key = "2", mods = "LEADER",   action = wezterm.action({ ActivateTab = 1 }) },
  { key = "3", mods = "LEADER",   action = wezterm.action({ ActivateTab = 2 }) },
  { key = "4", mods = "LEADER",   action = wezterm.action({ ActivateTab = 3 }) },
  { key = "5", mods = "LEADER",   action = wezterm.action({ ActivateTab = 4 }) },
  { key = "6", mods = "LEADER",   action = wezterm.action({ ActivateTab = 5 }) },
  { key = "7", mods = "LEADER",   action = wezterm.action({ ActivateTab = 6 }) },
  { key = "8", mods = "LEADER",   action = wezterm.action({ ActivateTab = 7 }) },
  { key = "9", mods = "LEADER",   action = wezterm.action({ ActivateTab = 8 }) },
  { key = "0", mods = "LEADER",   action = wezterm.action({ ActivateTab = 9 }) },
}

config.window_frame = {
  font_size = 14.0,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
