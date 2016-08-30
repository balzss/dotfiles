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

vf() {
  IFS='
'
  local declare files=($(fzf-tmux --query="$1" --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  unset IFS
}

cf() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

x-paste() {
    PASTE=$(pbpaste)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
    CURSOR=$(($CURSOR + $#PASTE + 1))
}

zle -N x-paste
zle -N vf

bindkey "^v" x-paste
bindkey "^s" prepend-sudo
bindkey "^[o" vf
bindkey "^[j" fzf-cd-widget


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
