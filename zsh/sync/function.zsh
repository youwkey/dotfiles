#==================================================================================================
# Functions
#==================================================================================================
function fzf_ghq_open() {
  local -r FZF_PROMPT='Open Repository> '
  local -r FZF_HEADER='<Ctrl-B>: Browse Repository, <Ctrl-p>: Browse Pull Requests'
  local -r PREVIEW='bat --color=always --number $(ghq root)/{}/README.md'
  local item=$(ghq list | fzf --prompt="${FZF_PROMPT}" --header "${FZF_HEADER}" \
    --preview "${PREVIEW}" \
    --bind 'ctrl-b:execute(open https://{})+accept,ctrl-p:execute(open https://{}/pull-requests)+accept')
  [[ ${item} ]] && cd $(ghq root)/${item} || :
}
