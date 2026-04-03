#!/usr/bin/env zsh
set -e

# symlink.sh — idempotent symlinking of dotfiles.
# Safe to run multiple times. Does not install software.
# For first-time machine setup (Homebrew, fonts), run setup.sh.

CURRENT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

# Scaffold .local files if they don't exist yet (gitignored, so absent on fresh clone).
# These live in the repo and are symlinked to $HOME so they're easy to find and edit.
if [ ! -f "$CURRENT_DIR/.zshenv.local" ]; then
  cat > "$CURRENT_DIR/.zshenv.local" <<'EOF'
# .zshenv.local — machine-specific env config (gitignored).
# Runs for every zsh process (interactive, non-interactive, scripts).
#
# Use this file for:
#   - Machine-specific PATH additions
#   - Secrets and API keys
#   - Tool initialization (e.g. eval "$(pyenv init -)", brew shellenv)
#
# Automated installers that want to modify .zshenv should append here instead.
EOF
fi

if [ ! -f "$CURRENT_DIR/.zshrc.local" ]; then
  cat > "$CURRENT_DIR/.zshrc.local" <<'EOF'
# .zshrc.local — machine-specific interactive shell config (gitignored).
# Runs for interactive shells only.
#
# Use this file for:
#   - Machine-specific aliases and functions
#   - Tool initialization that requires an interactive shell
#
# Automated installers that want to modify .zshrc should append here instead.
EOF
fi

DOT_FILES=(
  ".aliases"
  ".zshrc"
  ".zshrc.local"
  ".zprofile"
  ".zshenv"
  ".zshenv.local"
  ".functions"
  ".gitconfig"
  ".gitignore"
  ".excludes"
  ".code"
)

for FILE in ${DOT_FILES[@]}; do
  echo "Symlinking ~/$FILE"
  ln -sfn "$CURRENT_DIR/$FILE" "$HOME/$FILE"
done

# VS Code — merge shared settings with local overrides
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"

echo "Merging VS Code settings (shared + local)"
# Remove any existing symlink so the merge output is always a plain file,
# never written through a symlink back into the repo.
rm -f "$VSCODE_USER_DIR/settings.json"
if [ -f "$CURRENT_DIR/.code/settings.local.json" ]; then
  jq -s '(.[0] // {}) * (.[1] // {})' \
    "$CURRENT_DIR/.code/settings.json" \
    "$CURRENT_DIR/.code/settings.local.json" \
    > "$VSCODE_USER_DIR/settings.json"
else
  cp "$CURRENT_DIR/.code/settings.json" "$VSCODE_USER_DIR/settings.json" || true
fi

echo "Symlinking VS Code snippets"
ln -sfn "$CURRENT_DIR/.code/snippets" "$VSCODE_USER_DIR/snippets"

# Ghostty
GHOSTTY_DIR="$HOME/.config/ghostty"
mkdir -p "$GHOSTTY_DIR"
echo "Symlinking Ghostty config"
ln -sfn "$CURRENT_DIR/.ghostty/config" "$GHOSTTY_DIR/config"
ln -sfn "$CURRENT_DIR/.ghostty/icon.icns" "$GHOSTTY_DIR/icon.icns"

# Claude
mkdir -p "$HOME/.claude"
echo "Symlinking Claude AGENTS.md"
ln -sfn "$CURRENT_DIR/.claude/home/AGENTS.md" "$HOME/.claude/AGENTS.md"

echo ""
echo "Done."
