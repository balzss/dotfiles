#!/bin/bash -e

host=$HOST
cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.Xresources ~/dotfiles/.Xresources
cp ~/.tmux.conf ~/dotfiles/.tmux.conf
cp ~/.vim ~/dotfiles/.vim
cp ~/.gitconfig ~/dotfiles/.gitconfig
cd ~/dotfiles
git add --all 
git commit -m "$(curl -s http://whatthecommit.com/index.txt)"
git push 
