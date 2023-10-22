# function to run after every cd
function chpwd() {
    if [[ $PWD != $HOME ]]; then
        l
    fi
}
create_tmux_session() {
    SESSIONNAME="default session"
    tmux has-session -t $SESSIONNAME &> /dev/null
    if [ $? != 0 ] 
    then
        tmux new-session -s $SESSIONNAME -n zsh -d
        # tmux send-keys -t $SESSIONNAME "~/scripts/tmux-script" C-m 
    fi
    tmux attach -t $SESSIONNAME
    soz
}
grt() { 
  cd "$(git rev-parse --show-toplevel)"
}
mcd () {
  mkdir -p $1
  cd $1
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

# cd with fzf
function c() {
    local dirname
    dirname=$(fd --type directory | fzf) || return
    cd "$dirname"
}

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --ansi --no-multi --preview-window right:70% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %an - %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

gco() {
  if [[ $# -eq 0 ]] ; then
    local branch
    branch=$(fzf-git-branch)
    if [ "x$branch" != "x" ]
    then
      git checkout $branch
    fi
  else
    git checkout $1
  fi
}
