#!/usr/bin/env bash

MYOS="$(uname)"
DOTDIR="$(dirname $(realpath $0))"

ln -isv $DOTDIR/zsh/.zshrc $HOME/.zshrc
ln -isv $DOTDIR/zsh/.zshenv $HOME/.zshenv
ln -isv $DOTDIR/gitconfig/.gitconfig $HOME/.gitconfig

mkdir -p $HOME/.config/kitty &&
  ln -isv $DOTDIR/kitty/kitty.conf $HOME/.config/kitty/kitty.conf &&
  ln -isv $DOTDIR/kitty/gruvbox-material-dark-medium-theme.conf $HOME/.config/kitty/gruvbox-material-dark-medium-theme.conf

[ $MYOS = "Darwin" ] &&
  ln -isv $DOTDIR/kitty/macos.conf $HOME/.config/kitty/macos.conf

[ $MYOS = "Linux" ] &&
  ln -isv $DOTDIR/kitty/linux.conf $HOME/.config/kitty/linux.conf

mkdir -p $HOME/.config/nvim &&
  ln -isv $DOTDIR/nvim/init.lua $HOME/.config/nvim/init.lua

mkdir -p $HOME/.config/lazygit &&
  ln -isv $DOTDIR/lazygit/config.yml $HOME/.config/lazygit/config.yml

[ $MYOS = "Darwin" ] &&
  mkdir -p $HOME/.config/karabiner &&
  ln -isv $DOTDIR/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

# silence some of the login msg in macOS terminals
[ $MYOS = "Darwin" ] &&
  touch $HOME/.hushlogin

# uncomment if needed
# ln -isv $DOTDIR/tmux/.tmux.conf $HOME/.tmux.conf
