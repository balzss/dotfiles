# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# use emacs/vi keybindings
bindkey -e

# custom autocomplete
zstyle :compinstall filename '/home/balzss/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

autoload -Uz compinit
compinit
_comp_options+=(globdots)


source $HOME/scripts/gruvbox_256palette.sh

# aliases for modifying defaults
alias ..="cd .."
alias ls="ls --color=auto"
alias grep='grep --color=auto'
alias mkdir="mkdir -p"
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias syu="yaourt -Syu --noconfirm"
alias y="yaourt"
alias rm="rm -i"

# aliased for opening configs
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias xres="vim ~/.Xresources"
alias tconf="vim ~/.tmux.conf"
alias vimplug="curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

# aliases for sourcing
alias soz="source ~/.zshrc"
alias sox="xrdb ~/.Xresources"

# handy little things
alias pls='sudo $(fc -ln -1)'
alias l="ls -lhA --color=auto"
alias c="clear"
alias xc="xclip -selection c"
alias del="trash-put"


# git life 8)

alias gaa="git add -A"
alias gcm="git commit -m"
alias gpl="git pull"
alias gph="git push"

GH='https://www.github.com'

ghcl (){
    git clone $GH/$1.git
}

# functions
mcd () {
    mkdir -p $1
    cd $1
}
new_line() {
    echo
}
x-paste() {
    PASTE=$(xclip -selection clipboard -o)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
    CURSOR=$(($CURSOR + $#PASTE + 1))
}
prepend-sudo() {
    prefix="sudo"
    BUFFER="$prefix $BUFFER"
    CURSOR=$(($CURSOR + $#prefix + 1))
}


# keybindings
zle -N x-paste
zle -N prepend-sudo

bindkey "^v" x-paste
bindkey "^s" prepend-sudo
bindkey "^b" backward-word
bindkey "^f" forward-word

# setup hooks
autoload -Uz add-zsh-hook
add-zsh-hook precmd new_line
add-zsh-hook preexec new_line

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon


# custom PROMPT config
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr ' ✓'
zstyle ':vcs_info:*' unstagedstr ' ✕'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats ' [%b%c%u]'
zstyle ':vcs_info:*' enable git
precmd () {
    vcs_info
}

### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

if [[ -z "$SSH_CLIENT" ]]; then
    prompt_host=""
    # autostart tmux
    if [ "$TMUX" = "" ]
    then
        exec tmux
    fi
else
    prompt_host="%F{172}[$(hostname -s)] %f"
fi

PROMPT='${prompt_host}%F{167}[%d]%f%F{175}${vcs_info_msg_0_}%f
 %F{246}✞%f '
