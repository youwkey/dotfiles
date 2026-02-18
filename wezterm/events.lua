local wezterm = require("wezterm")
local M = {}

function M.setup()
    wezterm.on("toggle-theme", function(window, pane)
        local overrides = window:get_config_overrides() or {}

        local themes = {
            "Tokyo Night",
            "Solarized Light (Gogh)",
        }

        local current = overrides.color_scheme or "Tokyo Night"
        local index = 1

        for i, theme in ipairs(themes) do
            if theme == current then
                index = i
                break
            end
        end

        local next_index = index % #themes + 1
        overrides.color_scheme = themes[next_index]

        window:set_config_overrides(overrides)
    end)
end

return M
