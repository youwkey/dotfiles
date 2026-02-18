local wezterm = require("wezterm")
local M = {}

function M.setup()
    wezterm.on("update-right-status", function(window, pane)
        local active = window:active_workspace()
        local workspaces = wezterm.mux.get_workspace_names()

        local items = {}
        for i, name in ipairs(workspaces) do
            if name == active then
                table.insert(items, { Foreground = { AnsiColor = "Green" } })
            else
                table.insert(items, { Foreground = { AnsiColor = "Grey" } })
            end
            table.insert(items, { Text = " " .. i .. ": " .. name .. " " })
        end

        window:set_right_status(wezterm.format(items))
    end)

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
