#==================================================================================================
# Functions
#==================================================================================================
function fzf_ghq_open() {
  local -r FZF_PROMPT='Open Repository> '
  local -r FZF_HEADER='<Ctrl-B>: Browse Repository, <Ctrl-P>: Browse Pull Requests, <Ctrl-O>: Open in Zed'
  local -r PREVIEW='bat --color=always --number $(ghq root)/{}/README.md'
  local item=$(ghq list | fzf --prompt="${FZF_PROMPT}" --header "${FZF_HEADER}" \
    --preview "${PREVIEW}" \
    --bind 'ctrl-b:execute(open https://{})' \
    --bind 'ctrl-p:execute(open https://{}/-/merge_requests)' \
    --bind 'ctrl-o:execute(zed $(ghq root)/{})'
    )
  [[ ${item} ]] && cd $(ghq root)/${item} || :
}

function fzf_ssh_connect() {
  local -r FZF_PROMPT='Connect To> '
  local -r PREVIEW='echo ssh {}'
  local item=$(cat ~/.ssh/config | grep '^Host' | cut -d ' ' -f2 | fzf --prompt="${FZF_PROMPT}" --preview "${PREVIEW}")
  [[ ${item} ]] && ssh ${item} || :
}
