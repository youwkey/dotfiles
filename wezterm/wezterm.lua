local wezterm = require("wezterm")

local config = {}

-- モジュール読み込み
require("appearance").apply(config)
require("keymaps").apply(config)
require("workspaces").apply(config)

require("events").setup()

return config
