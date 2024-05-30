local w = require('wezterm')
local act = wezterm.action
local config = {}

config.animation_fps = 30
config.color_scheme = "Kanagawa (Gogh)"
config.default_cursor_style = "BlinkingBlock"
config.font_size = 12.0
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.hide_mouse_cursor_when_typing = false
config.tab_bar_at_bottom = true

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.5,
}

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

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

config.keys = {
  -- Pane Operations
	{ key = "\"",       mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
	{ key = "%",        mods = "CTRL|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
	{ key = "w",        mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = false } } },

  -- Session Management
  { key = "f",  mods = "ALT", action = wezterm.action { ShowLauncherArgs = { flags = 'FUZZY|WORKSPACES' } } },
  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'n',
    mods = 'ALT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
}
for _, v in ipairs(require('smart-splits')) do
	table.insert(config.keys, v)
end

return config
