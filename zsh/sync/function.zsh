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

function fzf_history_search() {
  BUFFER=$(history -n -r 1 | awk '!a[$0]++' | fzf --no-sort --prompt="History> ")
  CURSOR=$#BUFFER
  zle reset-prompt
}