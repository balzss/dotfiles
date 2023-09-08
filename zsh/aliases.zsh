_myos="$(uname)"
_sshfile="$HOME/.ssh/id_rsa.pub"

case $_myos in
  Linux)
    alias l="ls -lhApF --color"
    alias copy-ssh="xclip -selection clipboard -i $_sshfile"
    alias go="gio open ."
    ;;
  Darwin)
    alias l="ls -lhApF" # --color option for ls is not available on mac
    alias copy-ssh="pbcopy < $_sshfile"
    ;;
  *) ;;
esac

alias ..="cd .."
alias ...="cd ../.."
alias grep='grep --color=auto'
alias md="mkdir -p"
alias cp="cp -R"

alias v="nvim"
alias zshrc="nvim ~/dotfiles/zsh/.zshrc ~/dotfiles/zsh/.zshenv ~/dotfiles/zsh/*"
alias zshenv="nvim ~/dotfiles/zsh/.zshenv"
alias vimrc="nvim ~/dotfiles/nvim/init.vim"
alias dofiles="cd ~/dotfiles"
alias soz="source ~/.zshrc"
alias pls='sudo $(fc -ln -1)'

alias gac="git add -A && git commit -m"
alias gad="git add"
alias gcm="git commit -m"
alias gst="git status"
alias gpl="git pull"
alias gcl="git clone"
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias gmm="git merge master"
alias grm="git rebase master"
alias gdf="git diff"
alias gpoh="git push origin HEAD"
alias lg="lazygit"

alias macip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ytdl="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg"
alias mrc="$HOME/dotfiles/scripts/make-react-component.sh"
alias profile="$HOME/.profile"
