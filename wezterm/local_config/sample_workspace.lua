-- ワークスペース定義のサンプル
-- このファイルをコピーして自分のプロジェクト用に編集する
-- 例: cp sample_workspace.lua myproject.lua
--
-- ■ 設定項目
--   enabled: true/false  有効無効フラグ（省略で有効）
--   name:    string      InputSelector に表示される名前
--   cwd:     string      ワークスペースの作業ディレクトリ
--   tabs:    table       タブ・ペイン定義（省略でシェル1つ）
--
-- ■ tabs 内の各タブ
--   title:  string   タブ名（省略で "tab"）
--   cwd:    string   タブの作業ディレクトリ（省略でワークスペースの cwd）
--   panes:  table    ペイン定義の配列
--
-- ■ panes 内の各ペイン
--   split: "Right" | "Bottom"   分割方向（2番目以降のペインで必須）
--   size:  0.0〜1.0             分割比率（デフォルト: 0.5）
--   cwd:   string               個別の作業ディレクトリ（省略でタブの cwd）
--   args:  {"cmd", "arg", ...}  起動コマンド（省略でシェル）
--
-- ■ cwd のフォールバック順
--   ワークスペース cwd ← タブ cwd ← ペイン cwd
local wezterm = require("wezterm")

return {
    enabled = false,
    name = "home",
    cwd = wezterm.home_dir,
    tabs = {
        -- タブ1: エディタ + サイドペイン
        {
            title = "editor",
            panes = {
                {},                                -- メインペイン（シェル）
                { split = "Right", size = 0.35 },  -- 右に35%分割
            },
        },
        -- タブ2: 上下分割
        {
            title = "logs",
            panes = {
                {},                                  -- 上ペイン
                { split = "Bottom", size = 0.5 },    -- 下に50%分割
            },
        },
        -- タブ3: コマンド自動実行
        {
            title = "server",
            panes = {
                { args = { "echo", "hello" } },      -- 起動時にコマンド実行
            },
        },
        -- タブ4: シンプル（ペイン定義省略）
        {
            title = "misc",
        },
    },
}
