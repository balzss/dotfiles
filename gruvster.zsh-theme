# Directory info.
NEWLINE=$'\n'
local current_dir='[${PWD}]'

# Git info.
local git_info=' $FG[175]$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✖︎"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="
$FG[109]${current_dir}\
${git_info} \
${NEWLINE} \
$FG[245]→ %{$reset_color%}"
