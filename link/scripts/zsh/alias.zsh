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

alias gac="git add -A && git commit -m"
alias gpl="git pull"
alias gph="git push"
alias gcl="git clone"

alias venv="python3 -m venv .venv && vact"
alias vact="source ./.venv/bin/activate"
alias voff="deactivate"

alias myip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
