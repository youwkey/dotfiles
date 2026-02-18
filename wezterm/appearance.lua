local wezterm = require("wezterm")

local M = {}

function M.apply(config)
    -- フォント
    config.font = wezterm.font_with_fallback({
        { family = "UDEV Gothic", weight = "Medium" },
        { family = "JetBrains Mono", weight = "Medium" },
        { family = "PT Mono", weight = "Medium" },
        { family = "MesloLGS NF", weight = "Medium" },
    })
    config.font_size = 28
    config.line_height = 1.05
    config.freetype_load_target = "Light"
    config.freetype_render_target = "HorizontalLcd"

    -- カラースキーマ
    config.color_scheme = "Tokyo Night"

    -- 背景
    config.window_background_opacity = 0.85
    config.macos_window_background_blur = 10

    -- タブ
    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = true
    config.use_fancy_tab_bar = false
    config.tab_bar_at_bottom = false
    config.window_decorations = "RESIZE"
    config.show_new_tab_button_in_tab_bar = false

    -- ウィンドウ
    config.window_padding = {
        left = 20,
        right = 20,
        top = 10,
        bottom = 10,
    }

    -- カーソル
    config.default_cursor_style = "SteadyBar"
    config.cursor_thickness = 4
    config.cursor_blink_rate = 0

    -- スクロール
    config.enable_scroll_bar = false

    -- 初期サイズ
    config.initial_cols = 160
    config.initial_rows = 45

    -- FPS
    config.max_fps = 120
end

return M
