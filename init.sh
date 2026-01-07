#!/usr/bin/env zsh
set -e

CURRENT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"

touch $CURRENT_DIR/.private
