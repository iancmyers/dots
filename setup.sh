#!/usr/bin/env zsh
set -e

# setup.sh — one-time machine setup.
# Run this when setting up a new machine. It installs dependencies and then
# calls symlink.sh to create all symlinks.
#
# For subsequent changes (adding a new dotfile, updating symlinks), just run
# symlink.sh directly — it's idempotent.

CURRENT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install fonts
if ! brew list --cask font-monaspace &>/dev/null; then
  echo "Installing Monaspace fonts..."
  brew install --cask font-monaspace
fi

# Run symlinks
echo ""
echo "Running symlink.sh..."
"$CURRENT_DIR/symlink.sh"
