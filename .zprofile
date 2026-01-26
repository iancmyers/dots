# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.private can be used for other settings you don’t want to commit.
for file in ~/.{path,exports,zshrc,aliases,functions,private}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
setopt NO_CASE_GLOB

# Append to the Zsh history file, rather than overwriting it
setopt APPEND_HISTORY

# Autocorrect typos in path names when using `cd`
setopt CORRECT

# Enable some Zsh features:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
setopt AUTO_CD

# Lazy load rbenv - only loads when you first use ruby/gem/bundle
if [ -d "$HOME/.rbenv" ]; then
  _rbenv_lazy_load() {
    unset -f ruby gem bundle rbenv 2>/dev/null
    eval "$(rbenv init -)"
  }

  ruby() { _rbenv_lazy_load; ruby "$@"; }
  gem() { _rbenv_lazy_load; gem "$@"; }
  bundle() { _rbenv_lazy_load; bundle "$@"; }
  rbenv() { _rbenv_lazy_load; rbenv "$@"; }
fi

# Lazy load nvm - only loads when you first use nvm/node/npm/npx
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Placeholder functions that load nvm on first use
  _nvm_lazy_load() {
    unset -f nvm node npm npx 2>/dev/null
    \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  }

  nvm() { _nvm_lazy_load; nvm "$@"; }
  node() { _nvm_lazy_load; node "$@"; }
  npm() { _nvm_lazy_load; npm "$@"; }
  npx() { _nvm_lazy_load; npx "$@"; }
fi
