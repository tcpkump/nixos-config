local w = require('wezterm')
local act = wezterm.action
local config = {}

config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12.0
config.animation_fps = 30
config.tab_bar_at_bottom = true
config.default_cursor_style = "BlinkingBlock"

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
