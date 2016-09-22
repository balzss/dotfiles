# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

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

# autostart tmux
if [ "$TMUX" = "" ]
then
    exec tmux
fi

source $HOME/scripts/gruvbox_256palette.sh

# aliases for modifying defaults
alias ..="cd .."
alias ls="ls --color=auto"
alias la="ls -lha --color=auto"
alias grep='grep --color=auto'
alias mkdir="mkdir -p"
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias syu="yaourt -Syu"
alias y="yaourt"
alias rm="rm -i"

# aliased for opening configs
alias i3.conf="vim $HOME/.i3/config"
alias i3b.conf="vim $HOME/.config/i3blocks/config"
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias xres="vim ~/.Xresources"
alias tconf="vim ~/.tmux.conf"

# aliases for sourcing
alias soz="source ~/.zshrc"
alias sox="xrdb ~/.Xresources"

# handy little things
alias pls='sudo $(fc -ln -1)'
alias xc="xclip -selection c"
alias del="trash-put"
alias lass="ls -lah --color=auto | less"
alias data="cd /run/media/balzss/Data"

alias jcons="~/prog/j804/jconsole.sh"


# functions
mcd () {
    mkdir -p $1
    cd $1
}
lcd () {
    cd $1
    clear
    la
}
new_line() {
    echo
}
cd_dir() {
    clear
    ls -ah
}
cf() {
    cd $(find ~ -type d | fzf)
    clear
    zle reset-prompt
}
x-paste() {
    PASTE=$(xclip -selection clipboard -o)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
    CURSOR=$(($CURSOR + $#PASTE + 1))
}

cdParentKey() {
    cd ..
    clear
    zle reset-prompt
}
goHome() {
    cd
}
prepend-sudo() {
    prefix="sudo"
    BUFFER="$prefix $BUFFER"
    CURSOR=$(($CURSOR + $#prefix + 1))
}


# keybindings
zle -N goHome
zle -N cdParentKey
zle -N x-paste
zle -N vf
zle -N cf
zle -N prepend-sudo

bindkey "^h" goHome
bindkey '^k' cdParentKey
bindkey "^v" x-paste
bindkey "^s" prepend-sudo
bindkey "^j" cf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# setup hooks
autoload -Uz add-zsh-hook
add-zsh-hook precmd new_line
add-zsh-hook preexec new_line
add-zsh-hook chpwd cd_dir

# so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon


# custom PROMPT config
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr ' ✓'
zstyle ':vcs_info:*' unstagedstr ' ✕'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats '%b%c%u'
# zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%f%F{yellow}%r%f'
zstyle ':vcs_info:*' enable git
precmd () {
    # if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    # } else {
    #     zstyle ':vcs_info:*' formats '%b%c%u●'
    # }

    vcs_info
}

### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

PROMPT='%F{167}[%d]%f%F{175} ${vcs_info_msg_0_} %f
 %F{246}✞%f '
