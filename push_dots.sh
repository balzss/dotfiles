#!/bin/bash

cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.Xresources ~/dotfiles/.Xresources
cp ~/.tmux.conf ~/dotfiles/.tmux.conf
git add --all
git commit -m '$HOME'
git push
