bindkey -v
export KEYTIMEOUT=1

DISABLE_AUTO_UPDATE="true"
ZSH=/usr/share/oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="gruvster"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

plugins=(git wd)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:/usr/lib/gems/1.8/bin/:$PATH
export PATH=$PATH:/home/balzss/.gem/ruby/2.3.0/bin
export TERM="xterm-256color"
export VISUAL=vim
export EDITOR="$VISUAL"

# Example aliases

alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias xres="vim ~/.Xresources"
alias tconf="vim ~/.tmux.conf"
alias del="trash-put"
alias jcons="~/prog/j804/jconsole.sh"

s() { pwd > ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }
nis() { npm install $1 -S }

vimf() {
    $args = "**/*.{"
    for var
    do
        args+="$var,"
    done
    args=${args:0:-1}
    args+="}"
    echo $args
}



ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
