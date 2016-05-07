#!/bin/bash -e

cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.Xresources ~/dotfiles/.Xresources
cp ~/.tmux.conf ~/dotfiles/.tmux.conf
cd ~/dotfiles
git add --all 
git commit -am "changed from $HOST" 
git push 
