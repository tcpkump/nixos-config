local w = require('wezterm')
local config = {}

config.color_scheme = "Kanagawa (Gogh)"
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 12.0

config.keys = {}
for _, v in ipairs(require('smart-splits')) do
	table.insert(config.keys, v)
end

return config
