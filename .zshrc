if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# aliases

alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias xres="vim ~/.Xresources"
alias tconf="vim ~/.tmux.conf"
alias del="trash-put"
alias jcons="~/prog/j804/jconsole.sh"
alias soz="source ~/.zshrc"
alias sox="xrdb ~/.Xresources"
alias pls='print -z sudo $(fc -ln -1)'
alias fix-pac="rm /var/lib/pacman/db.lck"

s() { pwd > ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }
nis() { npm install $1 -S }
