local w = require('wezterm')
local act = wezterm.action
local config = {}

config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12.0
config.animation_fps = 30

-- Change mouse scroll amount
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(-3),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'NONE',
    action = act.ScrollByLine(3),
  },
}

config.keys = {
  -- Pane Operations
	{ key = "\"",       mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
	{ key = "%",        mods = "CTRL|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
	{ key = "w",        mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
}
for _, v in ipairs(require('smart-splits')) do
	table.insert(config.keys, v)
end

return config
