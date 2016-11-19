#!/usr/bin/env bash
set -e

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sFi $CURRENT_DIR/.atom $HOME
ln -sFi $CURRENT_DIR/.aliases $HOME
ln -sFi $CURRENT_DIR/.bash_prompt $HOME
ln -sFi $CURRENT_DIR/.bash_profile $HOME
ln -sFi $CURRENT_DIR/.exports $HOME
ln -sFi $CURRENT_DIR/.functions $HOME
ln -sFi $CURRENT_DIR/.gitconfig $HOME
ln -sFi $CURRENT_DIR/.gitignore $HOME
ln -sFi $CURRENT_DIR/.path $HOME
ln -sFi $CURRENT_DIR/.private $HOME

mkdir -p $HOME/bin

ln -sFi $CURRENT_DIR/bin/atomwrite $HOME/bin
ln -sFi $CURRENT_DIR/bin/atomload $HOME/bin

touch $CURRENT_DIR/.private

# Install nvm
export NVM_DIR="$HOME/.nvm" && (
  git clone -q https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
) && . "$NVM_DIR/nvm.sh"

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Homebrew/bundle
brew bundle
