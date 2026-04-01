export NVM_DIR="$HOME/.nvm"

# Resolve nvm's default alias chain and add it to PATH.
# This makes node/npm/npx available in non-interactive shells (e.g., editor
# sub-processes and build tools) without fully loading nvm.sh.
# Interactive login shells get the full lazy-load setup via .zprofile.
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
# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

. "$HOME/.cargo/env"
