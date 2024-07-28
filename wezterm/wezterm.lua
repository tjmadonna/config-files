local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font = wezterm.font("JetBrainsMonoNL Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.color_scheme = "Catppuccin Mocha"
config.colors = {
	background = "#0e0e0e",
}

config.keys = {
	{ key = "m", mods = "CMD|CTRL", action = wezterm.action.ToggleFullScreen },
}

return config
