######## exports ########

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PIP_REQUIRE_VIRTUALENV=false
export CLICOLOR=1
export MOZ_USE_XINPUT2=1
export BASE16_THEME=default-dark
export MOZ_USE_XINPUT2=1
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim


######## aliases ########

alias ..="cd .."
alias ...="cd ../.."
alias grep='grep --color=auto'
alias mkdir="mkdir -p"
alias md="mkdir -p"
alias cp="cp -R"
alias l="ls -lhApF"

alias zshrc="vim ~/.zshrc ~/scripts/zsh/**.zsh"
alias zalias="vim ~/scripts/zsh/alias.zsh"
alias vimrc="vim ~/.config/nvim/init.vim"
alias soz="source ~/.zshrc"

alias pls='sudo $(fc -ln -1)'

alias vim="nvim"
# alias vimf="nvim \$(fzf)"

alias gac="git add -A && git commit -m"
alias gpl="git pull"
alias gph="git push"
alias gcl="git clone"
# alias grt="cd $(git rev-parse --show-toplevel)"

alias venv="python3 -m venv .venv && vact"
alias vact="source ./.venv/bin/activate"
alias voff="deactivate"

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ytdl="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg"
alias inst="apt-get install"
alias rmv="apt-get remove --auto-remove"
alias musync="~/adb-sync/adb-sync --delete ~/Music /storage/emulated/0"


######## functions ########

# function to run after every cd
function chpwd() {
    clear
    if [[ $PWD != $HOME ]]; then
        l
    fi
}
create_tmux_session() {
    SESSIONNAME="zsh"
    tmux has-session -t $SESSIONNAME &> /dev/null
    if [ $? != 0 ] 
    then
        tmux new-session -s $SESSIONNAME -n zsh -d
        # tmux send-keys -t $SESSIONNAME "~/scripts/tmux-script" C-m 
    fi
    tmux attach -t $SESSIONNAME
    soz
}
ghcl (){
    git clone https://www.github.com/$1.git
}
groot() { 
    cd "$(git rev-parse --show-toplevel)"
}
mcd () {
    mkdir -p $1
    cd $1
}
new_line() {
    echo
}
prepend-sudo() {
    prefix="sudo"
    BUFFER="$prefix $BUFFER"
    CURSOR=$(($CURSOR + $#prefix + 1))
}

fontsize() {
    CFS="$(gsettings get org.gnome.desktop.interface text-scaling-factor)"
    if [ "$CFS" = "1.0" ]
    then
        gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
    else
        gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
    fi
}
