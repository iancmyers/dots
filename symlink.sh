#!/usr/bin/env zsh
set -e

CURRENT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

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

for FILE in ${CODE_FILES[@]}; do
  echo "Creating symlink to $FILE in VSCode directory."
  mkdir -p "$HOME/Library/Application Support/Code/User"
  ln -sfn "$CURRENT_DIR/.code/$FILE" "$HOME/Library/Application Support/Code/User/$FILE"
done
