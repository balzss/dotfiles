#!/usr/bin/env sh

ln -isv $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -isv $HOME/dotfiles/zsh/.zshenv $HOME/.zshenv
ln -isv $HOME/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
ln -isv $HOME/dotfiles/gitconfig/.gitconfig $HOME/.gitconfig
ln -isv $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

case "$(uname)" in
  Linux) LAZYGIT_TARGET_DIR="$HOME/.config/lazygit/config.yml";;
  Darwin) LAZYGIT_TARGET_DIR="$HOME/Library/Application Support/lazygit/config.yml";;
  *) ;;
esac
ln -isv $HOME/dotfiles/lazygit/config.yml "$LAZYGIT_TARGET_DIR"
