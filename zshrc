#===================================================================================================
# Homebrew
#===================================================================================================
if [ -e /opt/homebrew/bin/brew ]; then
  # for arm64(M1)
  eval $(/opt/homebrew/bin/brew shellenv)
fi

if [ -e /usr/local/bin/brew ]; then
  # for x86_64
  eval $(/usr/local/bin/brew shellenv)
fi

#===================================================================================================
# Zplug
#===================================================================================================
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "b4b4r07/enhancd", use:init.sh

if ! zplug check --verbose; then
  printf "Install? [y/N]:"
  if read -q ; then
    echo; zplug install
  fi
fi

zplug load #--verbose

#==================================================================================================
# Autoload & ZLE
#==================================================================================================
autoload -Uz vcs_info
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#==================================================================================================
# Alias
#==================================================================================================
alias ll="ls -l"
alias la="ls -al"
alias cat="bat"
alias lg="lazygit"
alias groot="cd-gitroot"
alias zshrc="vi ${HOME}/.zshrc"
alias dots="cd ${HOME}/.dotfiles"
alias doc="docker-compose"
alias g="fzf_ghq_open"

#==================================================================================================
# Bindkey
#==================================================================================================
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#==================================================================================================
# Functions
#==================================================================================================
function fzf_ghq_open() {
  local -r FZF_PROMPT='Open Repository> '
  local -r FZF_HEADER='<Ctrl-B>: Browse Repository'
  local -r PREVIEW='bat --color=always --number $(ghq root)/{}/README.md'
  local item=$(ghq list | fzf --prompt="${FZF_PROMPT}" --header "${FZF_HEADER}" \
    --preview "${PREVIEW}" \
    --bind 'ctrl-b:execute(open https://{})+accept')
  [[ ${item} ]] && cd $(ghq root)/${item} || :
}

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
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
# FZFカスタムオプション
export X_FZF_HOME=$(brew --prefix fzf)
export X_FZF_BIND_SCROLL='ctrl-j:preview-down,ctrl-k:preview-up'
export X_FZF_BIND_SCROLL_PAGE='ctrl-f:preview-page-down,ctrl-b:preview-page-up'
export X_FZF_BIND="${X_FZF_BIND_SCROLL},${X_FZF_BIND_SCROLL_PAGE}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind '${X_FZF_BIND}'"
# GHQディレクトリを設定
export GHQ_ROOT=$HOME/devspace/ghq
eval "$(anyenv init -)"
type go > /dev/null && export PATH=$(go env GOPATH)/bin:$PATH

#==================================================================================================
# Setopt
#==================================================================================================
# 補完候補を一覧表示
setopt auto_list
# TABで補完候補を順に切り替える
setopt auto_menu
# cd時に自動的にディレクトリスタックに追加
setopt auto_pushd
# コマンド履歴から重複行を全て削除
setopt hist_ignore_all_dups
# 直前のコマンドと重複するコマンドは記録しない
setopt hist_ignore_dups
# コマンド中の余分なスペースは削除して履歴に保存
setopt hist_reduce_blanks
# ディレクトリスタックと重複したディレクトリはスタックしない
setopt pushd_ignore_dups
# Zsh間でコマンド履歴を共有
setopt share_history
# $PROMPT変数内の変数を展開する
setopt prompt_subst

#==================================================================================================
# Prompt
#==================================================================================================
PROMPT="%F{102}%c %f"
ret_status="%(?:%F{102}❯❯❯%f :%F{001}❯❯❯%f )"

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}✔ "
zstyle ':vcs_info:git:*' unstagedstr "%F{red}✗ "
zstyle ':vcs_info:*' formats "%F{cyan}(%b)%c%u%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT=${PROMPT}${ret_status}
RPROMPT='${vcs_info_msg_0_}'

#==================================================================================================
# Load Local Run Commands
#==================================================================================================
for rc in $(rg $HOME/.dotfiles/localrc/ --files --no-ignore-vcs); do
  eval "source ${rc}"
done
