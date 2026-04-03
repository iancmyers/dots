#!/usr/bin/env zsh

# .zshenv — runs for every zsh process (interactive, non-interactive, scripts).
# This is the single source of truth for PATH and environment exports.

# --- PATH ---

PATH="/usr/local/bin:$PATH"
PATH="/usr/local/lib:$PATH"
PATH="$HOME/bin:$PATH"
PATH="./node_modules/.bin:$PATH"
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# rbenv shims — makes ruby available in non-interactive shells without full rbenv init
[ -d "$HOME/.rbenv/shims" ] && PATH="$HOME/.rbenv/shims:$PATH"

# Tool-managed environments (uv, rustup, etc.)
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

export PATH

# --- NVM default node ---
# Resolves nvm's default alias chain and adds it to PATH.
# Makes node/npm/npx available without loading nvm.sh.
# Interactive login shells get the full lazy-load setup via .zprofile.
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR/alias" ] && [ -d "$NVM_DIR/versions/node" ]; then
  _nvm_ver="$(cat "$NVM_DIR/alias/default" 2>/dev/null)"
  # Follow alias indirections up to 4 levels (e.g. default → lts/* → lts/krypton → v24.x.x)
  for _nvm_i in 1 2 3 4; do
    case "$_nvm_ver" in
      v[0-9]*) break ;;
      *) _nvm_next="$(cat "$NVM_DIR/alias/$_nvm_ver" 2>/dev/null)"
         [ -z "$_nvm_next" ] && break
         _nvm_ver="$_nvm_next" ;;
    esac
  done
  [ -d "$NVM_DIR/versions/node/$_nvm_ver/bin" ] && \
    export PATH="$NVM_DIR/versions/node/$_nvm_ver/bin:$PATH"
  unset _nvm_ver _nvm_next _nvm_i
fi

# --- Exports ---

export EDITOR="code"
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export MANPAGER="less -X"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export TERM=xterm-256color

# --- Machine-specific ---
# .zshenv.local is gitignored and not symlinked — it lives only in $HOME.
# Use it for machine-specific PATH additions, secrets, and tool init (e.g. nvm, pyenv).
# Automated installers that want to modify shell config should append here.
[ -r "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
