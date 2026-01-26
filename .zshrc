#!/usr/bin/env zsh
setopt PROMPT_SUBST

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{37}(%b)%f'         # shows (branch) in light grey
# Optional: show change markers — staged (%c) yellow, unstaged (%u) red
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr ' ●'
zstyle ':vcs_info:git:*' unstagedstr ' ✚'
zstyle ':vcs_info:git:*' formats '%F{37}(%b%F{190}%c%F{196}%u%F{37})%f'
precmd() { vcs_info }

export RPROMPT='${vcs_info_msg_0_} %F{239}%*%f'
export PROMPT='%F{190}%~%F{33} →%f '

# Transient RPROMPT - clears after pressing Enter for cleaner copy/paste
function _transient_rprompt_accept_line() {
  _SAVED_RPROMPT="$RPROMPT"
  RPROMPT=""
  zle reset-prompt
  RPROMPT="$_SAVED_RPROMPT"
  zle accept-line
}
zle -N _transient_rprompt_accept_line
bindkey '^M' _transient_rprompt_accept_line
