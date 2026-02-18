local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local M = {}

-- tab_id → カスタムタイトルのマッピング
local tab_titles = {}

-- 切り替え後にレイアウトを適用するためのキュー
local pending_layouts = {}

-- local_config/*.lua を読み込み、name をキーにした設定マップを返す
local function load_workspace_configs()
    local config_dir = wezterm.config_dir .. "/local_config"
    local configs = {}

    local ok, files = pcall(wezterm.glob, config_dir .. "/*.lua")
    if not ok then
        return configs
    end

    for _, file in ipairs(files) do
        local loaded, ws = pcall(dofile, file)
        if loaded and ws and ws.name and ws.cwd and ws.enabled ~= false then
            configs[ws.name] = ws
        end
    end

    return configs
end

-- ワークスペースが既に存在するか
local function workspace_exists(name)
    for _, n in ipairs(mux.get_workspace_names()) do
        if n == name then
            return true
        end
    end
    return false
end

-- タブ定義の最初のペインの cwd を解決
local function resolve_first_pane_cwd(ws, tab_def)
    local tab_cwd = tab_def.cwd or ws.cwd
    if tab_def.panes and tab_def.panes[1] and tab_def.panes[1].cwd then
        return tab_def.panes[1].cwd
    end
    return tab_cwd
end

-- tabs 定義からレイアウトを構築
local function setup_layout(ws, mux_window)
    local tabs = ws.tabs
    if not tabs then
        return
    end

    for i, tab_def in ipairs(tabs) do
        local tab_cwd = tab_def.cwd or ws.cwd
        local tab, pane
        if i == 1 then
            tab = mux_window:tabs()[1]
            pane = tab:panes()[1]
        else
            tab, pane, _ = mux_window:spawn_tab({ cwd = resolve_first_pane_cwd(ws, tab_def) })
        end

        local title = i .. ": " .. (tab_def.title or "tab") .. " "
        tab_titles[tab:tab_id()] = title

        if tab_def.panes then
            for j, pane_def in ipairs(tab_def.panes) do
                if j == 1 then
                    if pane_def.args then
                        pane:send_text(table.concat(pane_def.args, " ") .. "\n")
                    end
                else
                    local split_opts = {
                        direction = pane_def.split or "Right",
                        cwd = pane_def.cwd or tab_cwd,
                        size = pane_def.size or 0.5,
                    }
                    local new_pane = pane:split(split_opts)
                    if pane_def.args then
                        new_pane:send_text(table.concat(pane_def.args, " ") .. "\n")
                    end
                end
            end
        end
    end
end

function M.apply(config)
    -- カスタムタブタイトル
    wezterm.on("format-tab-title", function(tab)
        local title = tab_titles[tab.tab_id]
        if title then
            return title
        end
    end)

    -- SwitchToWorkspace 完了後にレイアウトを適用
    wezterm.on("update-right-status", function(window)
        local ws_name = window:active_workspace()
        local ws = pending_layouts[ws_name]
        if ws then
            pending_layouts[ws_name] = nil
            local mux_window = window:mux_window()
            setup_layout(ws, mux_window)
            -- 最初のタブにフォーカス
            window:perform_action(act.ActivateTab(0), mux_window:tabs()[1]:panes()[1])
        end
    end)

    table.insert(config.keys, {
        key = "p",
        mods = "CMD",
        action = wezterm.action_callback(function(window, pane)
            local configs = load_workspace_configs()

            -- InputSelector の選択肢を構築
            local choices = {}
            local seen = {}

            for name, _ in pairs(configs) do
                table.insert(choices, { id = name, label = name })
                seen[name] = true
            end

            for _, name in ipairs(mux.get_workspace_names()) do
                if not seen[name] then
                    table.insert(choices, { id = name, label = name })
                end
            end

            if #choices == 0 then
                return
            end

            table.sort(choices, function(a, b)
                return a.label < b.label
            end)

            window:perform_action(
                act.InputSelector({
                    action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
                        if not id and not label then
                            return
                        end

                        local ws = configs[id]
                        local is_new = ws and not workspace_exists(id)

                        -- tabs 定義があり未作成ならレイアウト適用をキューに入れる
                        if is_new and ws.tabs then
                            pending_layouts[id] = ws
                        end

                        -- SwitchToWorkspace が未作成なら作成、既存なら切り替え
                        local switch_opts = { name = id }
                        if is_new then
                            local spawn_cwd = ws.cwd
                            if ws.tabs and ws.tabs[1] then
                                spawn_cwd = resolve_first_pane_cwd(ws, ws.tabs[1])
                            end
                            switch_opts.spawn = { cwd = spawn_cwd }
                        end
                        inner_window:perform_action(
                            act.SwitchToWorkspace(switch_opts),
                            inner_pane
                        )
                    end),
                    title = "Switch Workspace",
                    choices = choices,
                    fuzzy = true,
                    fuzzy_description = "Workspace: ",
                }),
                pane
            )
        end),
    })
end

return M
