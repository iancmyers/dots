#!/usr/bin/env zsh

# .zprofile — runs for login shells only.
# PATH and exports are handled in .zshenv (runs for all shells).
# This file only sets up lazy-load shell functions for interactive use.

# Lazy load rbenv — only loads when you first use ruby/gem/bundle
# Helper names avoid a leading underscore: Claude Code's shell-snapshot
# capture drops underscore-prefixed functions, which breaks the shims.
if [ -d "$HOME/.rbenv" ]; then
  rbenv_lazy_load() {
    unset -f ruby gem bundle rbenv 2>/dev/null
    eval "$(rbenv init -)"
  }

  ruby() { rbenv_lazy_load; ruby "$@"; }
  gem() { rbenv_lazy_load; gem "$@"; }
  bundle() { rbenv_lazy_load; bundle "$@"; }
  rbenv() { rbenv_lazy_load; rbenv "$@"; }
fi

# Lazy load nvm — only loads when you first use nvm/node/npm/npx
if [ -s "$NVM_DIR/nvm.sh" ]; then
  nvm_lazy_load() {
    unset -f nvm node npm npx 2>/dev/null
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  }

  nvm() { nvm_lazy_load; nvm "$@"; }
  node() { nvm_lazy_load; node "$@"; }
  npm() { nvm_lazy_load; npm "$@"; }
  npx() { nvm_lazy_load; npx "$@"; }
fi
