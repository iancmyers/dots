#!/usr/bin/env zsh
setopt PROMPT_SUBST

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{37}(%b)%f'         # shows (branch) in light grey
# Optional: show change markers — staged (%c) yellow, unstaged (%u) red
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr '●'
# zstyle ':vcs_info:git:*' unstagedstr '✚'
# zstyle ':vcs_info:git:*' formats '%F{37}(%b%f %F{190}%c%f %F{196}%u%f)'
precmd() { vcs_info }

export RPROMPT='${vcs_info_msg_0_} %F{239}%*%f'
export PROMPT='%n %F{190}%~%F{33} →%f '

alias astro='nocorrect astro'
