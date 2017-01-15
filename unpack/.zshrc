# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_FIND_NO_DUPS

# use emacs keybindings
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

# source $HOME/scripts/gruvbox_256palette.sh
source $HOME/scripts/zsh-history-substring-search.zsh
source $HOME/scripts/autoenv.zsh

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export VIRTUAL_ENV_DISABLE_PROMPT=1
export CLICOLOR=1

# aliases for modifying defaults
alias ..="cd .."
alias grep='grep --color=auto'
alias mkdir="mkdir -p"
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm="rm -i"
alias syu="yaourt -Syu --noconfirm"
alias y="yaourt"
alias trm="trash-put"

# aliased for opening configs
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias xres="vim ~/.Xresources"
alias tconf="vim ~/.tmux.conf"

# aliases for sourcing
alias soz="source ~/.zshrc"
alias sox="xrdb ~/.Xresources"

# handy little things
alias pls='sudo $(fc -ln -1)'
alias l="ls -lhApF"
alias c="clear"
alias xc="xclip -selection c"

# python virtual environment things

alias venv="python3 -m venv .venv"
alias vact="source .venv/bin/activate"
alias voff="deactivate"

# git life 8)

alias gac="git add -A && git commit -m"
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

# bindkey "^v" x-paste
bindkey "^s" prepend-sudo
bindkey "^b" backward-word
bindkey "^f" forward-word
bindkey "^p" history-substring-search-up
bindkey "^n" history-substring-search-down

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
    virtualenv_info
}
function chpwd() {
    clear
    if [[ $PWD != $HOME ]]; then
        l
    fi
}

### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours


create_tmux_session() {
    SESSIONNAME="zsh"
    tmux has-session -t $SESSIONNAME &> /dev/null

    if [ $? != 0 ] 
    then
        tmux new-session -s $SESSIONNAME -n zsh -d
        # tmux send-keys -t $SESSIONNAME "~/scripts/tmux-script" C-m 
    fi

    tmux attach -t $SESSIONNAME
}

# display host if in an SSH session, executed when .zshrc is sourced (on login)
if [[ -z "$SSH_CLIENT" ]]; then
    prompt_host=""
    # autostart tmux
    if [ "$TMUX" = "" ]
    then
        create_tmux_session
    fi
else
    prompt_host="%F{172}[$(hostname -s)] %f"
fi

# modified python virtualenv prompt
function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="[${${VIRTUAL_ENV%/*}##*/}]"
    else
        # In case you don't have one activated
        venv=""
    fi
}

PROMPT='${prompt_host}%F{magenta}[%d]%f%F{blue}${vcs_info_msg_0_}%f %F{yellow}${venv}%f
 %F{A}✞%f '

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
