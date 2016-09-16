# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/balzss/.zshrc'


if [ "$TMUX" = "" ]; then tmux; fi

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
alias pls='print -z sudo $(fc -ln -1)'
alias xc="xclip -selection c"
alias del="trash-put"
alias lass="ls -lah --color=auto | less"

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


autoload -Uz compinit
compinit
# End of lines added by compinstall

### Shows state of the Versioning Control System (e.g. Git, Subversion, Mercurial
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%f%F{yellow}%r%f'
zstyle ':vcs_info:*' enable git svn
precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '%b%c%u'
    } else {
        zstyle ':vcs_info:*' formats '%b%c%u●'
    }

    vcs_info
}

### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

### My default prompt
PROMPT='
[%d] ${vcs_info_msg_0_}
 ✞ '
