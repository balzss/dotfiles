#!/usr/bin/env sh

MYOS="$(uname)"

ln -isv $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -isv $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv
ln -isv $HOME/dotfiles/gitconfig/.gitconfig $HOME/.gitconfig

mkdir -p $HOME/.config/nvim &&
  ln -isv $HOME/dotfiles/nvim/init.lua $HOME/.config/nvim/init.lua

mkdir -p $HOME/.config/lazygit &&
  ln -isv $HOME/dotfiles/lazygit/config.yml $HOME/.config/lazygit/config.yml

mkdir -p $HOME/.config/kitty &&
  ln -isv $HOME/dotfiles/kitty/kitty.conf $HOME/.config/kitty/kitty.conf &&
  ln -isv $HOME/dotfiles/kitty/gruvbox-material-dark-medium-theme.conf $HOME/.config/kitty/gruvbox-material-dark-medium-theme.conf

[ $MYOS = "Darwin" ] &&
  mkdir -p $HOME/.config/karabiner &&
  ln -isv $HOME/dotfiles/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

# [ $MYOS = "Linux" ] &&
#   echo "running on linux"

# uncomment if needed
# ln -isv $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
