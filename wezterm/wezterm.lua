local wezterm = require("wezterm")

local config = {}

-- モジュール読み込み
require("appearance").apply(config)
require("keymaps").apply(config)
require("events").setup()
-- require("workspaces").apply(config)

return config
