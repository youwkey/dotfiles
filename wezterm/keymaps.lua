local wezterm = require("wezterm")
local M = {}

function M.apply(config)
    config.keys = {
        -- 新しいタブ
        {
            key = "t",
            mods = "CMD",
            action = wezterm.action.SpawnTab("CurrentPaneDomain"),
        },

        -- タブを閉じる
        {
            key = "w",
            mods = "CMD",
            action = wezterm.action.CloseCurrentTab({ confirm = true }),
        },

        -- 水平分割（左右）
        {
            key = "d",
            mods = "CMD",
            action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },

        -- 垂直分割（上下）
        {
            key = "D",
            mods = "CMD|SHIFT",
            action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        -- ペイン移動
        {
            key = "h",
            mods = "CMD",
            action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
            key = "l",
            mods = "CMD",
            action = wezterm.action.ActivatePaneDirection("Right"),
        },
        {
            key = "k",
            mods = "CMD",
            action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
            key = "j",
            mods = "CMD",
            action = wezterm.action.ActivatePaneDirection("Down"),
        },

        -- ペイン閉じる
        {
            key = "w",
            mods = "CMD|SHIFT",
            action = wezterm.action.CloseCurrentPane({ confirm = true }),
        },

        -- タブ切り替え (CMD + 1〜9)
        {
            key = "1",
            mods = "CMD",
            action = wezterm.action.ActivateTab(0),
        },
        {
            key = "2",
            mods = "CMD",
            action = wezterm.action.ActivateTab(1),
        },
        {
            key = "3",
            mods = "CMD",
            action = wezterm.action.ActivateTab(2),
        },
        {
            key = "4",
            mods = "CMD",
            action = wezterm.action.ActivateTab(3),
        },
        {
            key = "5",
            mods = "CMD",
            action = wezterm.action.ActivateTab(4),
        },
        {
            key = "6",
            mods = "CMD",
            action = wezterm.action.ActivateTab(5),
        },
        {
            key = "7",
            mods = "CMD",
            action = wezterm.action.ActivateTab(6),
        },
        {
            key = "8",
            mods = "CMD",
            action = wezterm.action.ActivateTab(7),
        },
        {
            key = "9",
            mods = "CMD",
            action = wezterm.action.ActivateTab(8),
        },

        -- テーマ切り替え
        {
            key = "t",
            mods = "CMD|SHIFT",
            action = wezterm.action.EmitEvent("toggle-theme"),
        },
    }
end

return M
