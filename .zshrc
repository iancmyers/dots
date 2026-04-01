#!/usr/bin/env zsh

# Load shell dotfiles for interactive features:
# * ~/.aliases for command aliases
# * ~/.functions for shell functions
for file in ~/.{aliases,functions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Shell options
setopt PROMPT_SUBST
setopt NO_CASE_GLOB      # Case-insensitive globbing (used in pathname expansion)
setopt APPEND_HISTORY    # Append to the Zsh history file, rather than overwriting it
setopt CORRECT           # Autocorrect typos in path names when using `cd`
setopt AUTO_CD           # `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`

# Prompt configuration
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

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
