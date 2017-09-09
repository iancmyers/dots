#!/usr/bin/env bash
set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOT_FILES=(
  ".atom" \ 
  ".aliases" \
  ".bash_prompt" \
  ".bash_profile" \
  ".exports" \
  ".functions" \
  ".gitconfig" \
  ".gitignore" \
  ".path" \
  ".private" \
  ".code" \
)

BIN_FILES=(
  "atomwrite" \
  "atomload" \
  "vsinstall" \
  "vswrite" \
)

CODE_FILES=(
  "settings.json" \
  "vsicons.settings.json" \
  "snippets" \
)

for FILE in ${DOT_FILES[@]}; do
  echo "Creating symlink to $FILE in $HOME."
  ln -sFf $CURRENT_DIR/$FILE $HOME
done

mkdir -p $HOME/bin

for FILE in ${BIN_FILES[@]}; do
  echo "Creating symlink to $FILE in $HOME/bin."
  ln -sFf $CURRENT_DIR/bin/$FILE $HOME/bin
done

for FILE in ${CODE_FILES[@]}; do
  echo "Creating symlink to $FILE in VSCode directory."
  ln -sFf $HOME/.code/$FILE $HOME/Library/Application\ Support/Code/User/
done
