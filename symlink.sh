#!/usr/bin/env zsh
set -e

CURRENT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

# Create .private if it doesn't exist (for machine-specific secrets)
touch "$CURRENT_DIR/.private"

DOT_FILES=(
  ".aliases" \
  ".zshrc" \
  ".zprofile" \
  ".exports" \
  ".functions" \
  ".gitconfig" \
  ".gitignore" \
  ".path" \
  ".private" \
  ".code" \
)

CODE_FILES=(
  "settings.json" \
  "snippets" \
)

for FILE in ${DOT_FILES[@]}; do
  echo "Creating symlink to $FILE in $HOME."
  ln -sfn "$CURRENT_DIR/$FILE" "$HOME/$FILE"
done

VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"

# Merge shared and local settings into VS Code's settings.json
echo "Merging VS Code settings (shared + local)."
if [ -f "$CURRENT_DIR/.code/settings.local.json" ]; then
  # Use jq to merge shared settings with local overrides
  jq -s '.[0] * .[1]' \
    "$CURRENT_DIR/.code/settings.json" \
    "$CURRENT_DIR/.code/settings.local.json" \
    > "$VSCODE_USER_DIR/settings.json"
else
  cp "$CURRENT_DIR/.code/settings.json" "$VSCODE_USER_DIR/settings.json"
fi

# Symlink other VS Code files (snippets, etc.)
for FILE in snippets; do
  echo "Creating symlink to $FILE in VSCode directory."
  ln -sfn "$CURRENT_DIR/.code/$FILE" "$VSCODE_USER_DIR/$FILE"
done

CLAUDE_FILES=(
  "AGENTS.md" \
)

for FILE in ${CLAUDE_FILES[@]}; do
  echo "Creating symlink to $FILE in Claude directory."
  mkdir -p "$HOME/.claude"
  ln -sfn "$CURRENT_DIR/.claude/home/$FILE" "$HOME/.claude/$FILE"
done
