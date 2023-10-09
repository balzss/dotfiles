#!/usr/bin/env sh

MYOS="$(uname)"

ln -isv $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -isv $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv
ln -isv $HOME/dotfiles/gitconfig/.gitconfig $HOME/.gitconfig
ln -isv $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config/nvim &&
  ln -isv $HOME/dotfiles/nvim/init.lua $HOME/.config/nvim/init.lua

mkdir -p $HOME/.config/lazygit &&
  ln -isv $HOME/dotfiles/lazygit/config.yml $HOME/.config/lazygit/config.yml

[ $MYOS = "Darwin" ] &&
  mkdir -p $HOME/.config/karabiner &&
  ln -isv $HOME/dotfiles/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

# [ $MYOS = "Linux" ] &&
#   echo "running on linux"
