#==================================================================================================
# Bindkey
#==================================================================================================
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
zle -N fzf_history_search
bindkey "^R" fzf_history_search
