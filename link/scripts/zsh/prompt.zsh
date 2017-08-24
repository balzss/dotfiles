### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions
autoload -U colors && colors    # Enables colours

# display host if in an SSH session, executed when .zshrc is sourced (on login)
if [[ -z "$SSH_CLIENT" ]]; then
    prompt_host=""
    # autostart tmux
    if [ "$TMUX" = "" ] && [ -z "$VSCODE" ]
    then
        create_tmux_session
    fi
else
    prompt_host="%F{172}[$(hostname -s)] %f"
fi

# modified python virtualenv prompt
function get_virtualenv_info(){
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "%F{yellow}[`basename \"$VIRTUAL_ENV\"`]%f "
    else
        echo ""
    fi
}
function get_dir_info(){
    echo "%F{magenta}[%d]%f "
}
function get_git_info(){
    echo "%F{blue}$(git_super_status)%f "
}

PROMPT='${prompt_host}$(get_dir_info)$(get_virtualenv_info)$(get_git_info)
 %F{green}$%f '
