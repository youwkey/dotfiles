#==================================================================================================
# Export
#==================================================================================================
# ls時の色を設定
export CLICOLOR=true
export LSCOLORS='gxfxcxdxbxegedabagacad'
# コマンド履歴を保存するファイルを指定
export HISTFILE=~/.zsh_history
# メモリに保存する履歴の件数
export HISTSIZE=1000
# ファイルに保存する履歴の件数
export SAVEHIST=1000000
# 文字コードにUTF-8を指定
export LANG=ja_JP.UTF-8
# XDG Base Directory用の設定
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
# zsh-autosuggestionsの設定
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
# FZFデフォルトコマンド
export FZF_DEFAULT_COMMAND='rg --files'
# FZFデフォルトオプション
export FZF_DEFAULT_OPTS='--height 50% --reverse'
# FZFカスタムオプション
export X_FZF_HOME=$(brew --prefix fzf)
export X_FZF_BIND_SCROLL='ctrl-j:preview-down,ctrl-k:preview-up'
export X_FZF_BIND_SCROLL_PAGE='ctrl-f:preview-page-down,ctrl-b:preview-page-up'
export X_FZF_BIND="${X_FZF_BIND_SCROLL},${X_FZF_BIND_SCROLL_PAGE}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind '${X_FZF_BIND}'"
# GHQディレクトリを設定
export GHQ_ROOT=$HOME/devspace/ghq
type go > /dev/null && export PATH=$(go env GOPATH)/bin:$PATH
# Claude用
export PATH="$HOME/.local/bin:$PATH"
