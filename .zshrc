

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
alias rofi="rofi -modi 'run' -show run"

s() { pwd > ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }
nis() { npm install $1 -S }

cf() {
    cd $(find ~ -type d | fzf)
    clear
    zle reset-prompt
}

x-paste() {
    PASTE=$(pbpaste)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
    CURSOR=$(($CURSOR + $#PASTE + 1))
}

cdUndoKey() {
  popd      > /dev/null
  zle       reset-prompt
  echo
  ls
  echo
}

cdParentKey() {
    cd ..
    clear
    zle reset-prompt
}

goHome() {
    cd ~
    clear
    zle reset-prompt
}

zle -N goHome
zle -N cdParentKey
zle -N cdUndoKey
zle -N x-paste
zle -N vf
zle -N cf

bindkey "^h" goHome
bindkey '^k'      cdParentKey
bindkey '^z'      cdUndoKey
bindkey "^v" x-paste
bindkey "^s" prepend-sudo
bindkey "^j" cf


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
