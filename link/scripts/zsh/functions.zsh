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
}
venv(){
    pyenv virtualenv $(basename $PWD)
    echo $(basename $PWD)>.python-version
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
