######## exports ########

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PIP_REQUIRE_VIRTUALENV=false
export CLICOLOR=1
export MOZ_USE_XINPUT2=1
export BASE16_THEME=default-dark
export MOZ_USE_XINPUT2=1
export EDITOR=/usr/bin/nvim
export PAGER="nvim -R"
export VISUAL=/usr/bin/nvim
export PATH=$HOME/.local/bin:$PATH
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/.config/nvim/plugged/vim-floaterm/bin:$PATH"

######## aliases ########

alias -- -="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias grep='grep --color=auto'
alias mkdir="mkdir -p"
alias md="mkdir -p"
alias cp="cp -R"

# --color option for ls is not available on macs
_myos="$(uname)"
case $_myos in
  Linux) alias l="ls -lhApF --color";;
  Darwin) alias l="ls -lhApF";;
  *) ;;
esac

alias zshrc="vim ~/.zshrc ~/scripts/zsh/**.zsh"
alias zalias="vim ~/scripts/zsh/alias.zsh"
alias vimrc="vim ~/.config/nvim/init.vim"
alias soz="source ~/.zshrc"

alias pls='sudo $(fc -ln -1)'

alias vim="nvim"
alias v="nvim"
alias vl="/usr/share/nvim/runtime/macros/less.sh"

alias gac="git add -A && git commit -m"
alias gad="git add"
alias gcm="git commit -m"
alias gst="git status"
alias gpl="git pull"
alias gcl="git clone"
alias gco="git checkout"
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias gdf="git diff --no-color"
alias gpoh="git push origin HEAD"

alias macip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ytdl="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg"
alias mrc="~/scripts/make-react-component.sh"


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
grt() { 
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

# kill process with fzf
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}
