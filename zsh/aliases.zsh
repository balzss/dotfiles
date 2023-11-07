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

function set-title() {
  echo -en "\e]2;$@\a"
}

alias v="set-title 'nvim' && nvim"
alias zshrc="set-title 'zshrc' && nvim ~/dotfiles/zsh/.zshrc ~/dotfiles/zsh/.zshenv ~/dotfiles/zsh/*"
alias zshenv="set-title 'zshenv' && nvim ~/dotfiles/zsh/.zshenv"
alias zalias="set-title 'zalias' && nvim ~/dotfiles/zsh/aliases.zsh"
alias vimrc="set-title 'vimrc' && nvim ~/dotfiles/nvim/init.lua"
alias dofiles="cd ~/dotfiles"
alias soz="source ~/.zshrc"
alias pls='sudo $(fc -ln -1)'

# git
alias gac="git add -A && git commit -m"
alias gad="git add"
alias gcm="set-title 'git commit' && git commit"
alias gcmm="git commit -m"
alias gst="git status"
alias gpl="set-title 'git pull' && git pull"
alias gcl="set-title 'git clone' && git clone"
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias gmm="git merge master"
alias grm="git rebase master"
alias gdf="git diff"
alias gpoh="set-title 'git push' && git push origin HEAD"
alias gpohf="set-title 'git push' && git push origin HEAD --force"
alias gsqb='git reset $(git merge-base master $(git branch --show-current))' # single quote to avoid running command on init
alias lg="set-title 'lazygit' && lazygit"

alias macip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ytdl="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --prefer-ffmpeg"
alias mrc="$HOME/dotfiles/scripts/make-react-component.sh"
