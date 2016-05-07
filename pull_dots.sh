#!/bin/bash -e

cd ~/dotfiles
git pull
cp .vimrc ~/.vimrc
cp .zshrc ~/.zshrc
cp .Xresources ~/.Xresources
cp .tmux.conf ~/.tmux.conf
