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

        -- ペインを閉じる（最後のペインならタブも閉じる）
        {
            key = "w",
            mods = "CMD",
            action = wezterm.action.CloseCurrentPane({ confirm = true }),
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

    -- ワークスペース切り替え (CMD+SHIFT + 1〜9)
    for i = 1, 9 do
        table.insert(config.keys, {
            key = "phys:" .. tostring(i),
            mods = "CMD|SHIFT",
            action = wezterm.action_callback(function(window, pane)
                local workspaces = wezterm.mux.get_workspace_names()
                if i <= #workspaces then
                    window:perform_action(
                        wezterm.action.SwitchToWorkspace({ name = workspaces[i] }),
                        pane
                    )
                end
            end),
        })
    end

    -- ワークスペースを閉じる (CMD+SHIFT+W)
    table.insert(config.keys, {
        key = "w",
        mods = "CMD|SHIFT",
        action = wezterm.action_callback(function(window, pane)
            local close = wezterm.action.CloseCurrentTab({ confirm = false })
            local actions = {}
            for _ = 1, #window:mux_window():tabs() do
                table.insert(actions, close)
            end
            window:perform_action(wezterm.action.Multiple(actions), pane)
        end),
    })
end

return M
