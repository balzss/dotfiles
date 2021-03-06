# aliases
alias ..="cd .."
alias ...="cd ../.."
alias grep='grep --color=auto'
alias md="mkdir -p"
alias cp="cp -R"
alias du="du -h"

# --color option for ls is not available on macs
_myos="$(uname)"
case $_myos in
  Linux) alias l="ls -lhApF --color";;
  Darwin) alias l="ls -lhApF";;
  *) ;;
esac

alias vim="nvim"
alias v="nvim"
alias zshrc="nvim ~/dotfiles/zsh/.zshrc ~/dotfiles/zsh/.zshenv ~/dotfiles/zsh/*"
alias vimrc="nvim ~/dotfiles/nvim/init.vim"
alias soz="source ~/.zshrc"
alias pls='sudo $(fc -ln -1)'

alias gac="git add -A && git commit -m"
alias gad="git add"
alias gcm="git commit -m"
alias gst="git status -sb"
alias gpl="git pull"
alias gcl="git clone"
# alias gco="git checkout"
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias gdf="git diff"
alias gpoh="git push origin HEAD"
alias lg="lazygit"

alias macip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ytdl="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg"
alias mrc="~/scripts/make-react-component.sh"
alias escaps="setxkbmap -option esc:nocaps"
