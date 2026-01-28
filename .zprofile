# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load environment-related dotfiles:
# * ~/.path can be used to extend `$PATH`.
# * ~/.exports can be used for other environment variables.
# * ~/.private can be used for settings you don't want to commit.
for file in ~/.{path,exports,private}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

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
