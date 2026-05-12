#!/bin/bash
input=$(cat)

# Extract basic info
cwd=$(echo "$input" | jq -r ".workspace.current_dir // .cwd")
project_dir=$(echo "$input" | jq -r ".workspace.project_dir // \"\"")
model=$(echo "$input" | jq -r ".model.display_name // \"\"")
style=$(echo "$input" | jq -r ".output_style.name // \"default\"")
session_cost=$(echo "$input" | jq -r ".cost.total_cost_usd // 0")

# Cache file for daily cost
cache_file="/tmp/claude-daily-cost.cache"
cache_timeout=60  # Update cache every 60 seconds

# Get daily cost from cache or update if stale
day_cost="0"
if [[ -f "$cache_file" ]]; then
  # Check if cache is fresh (less than 60 seconds old)
  cache_age=$(($(date +%s) - $(stat -f %m "$cache_file" 2>/dev/null || echo 0)))
  if [[ $cache_age -lt $cache_timeout ]]; then
    # Use cached value
    day_cost=$(cat "$cache_file" 2>/dev/null || echo "0")
  else
    # Update cache in background
    (
      today=$(date +%Y%m%d)
      new_cost=$(npx --yes ccusage daily --since "$today" --until "$today" --json 2>/dev/null | jq -r ".daily[0].totalCost // 0" 2>/dev/null)
      [[ -n "$new_cost" && "$new_cost" != "0" ]] && echo "$new_cost" > "$cache_file"
    ) &
    day_cost=$(cat "$cache_file" 2>/dev/null || echo "0")
  fi
else
  # No cache exists, create it in background and show 0 for now
  (
    today=$(date +%Y%m%d)
    new_cost=$(npx --yes ccusage daily --since "$today" --until "$today" --json 2>/dev/null | jq -r ".daily[0].totalCost // 0" 2>/dev/null)
    [[ -n "$new_cost" && "$new_cost" != "0" ]] && echo "$new_cost" > "$cache_file"
  ) &
fi

# Display directory
dir_display="${cwd/#$HOME/~}"
if [[ -n "$project_dir" && "$cwd" == "$project_dir"* ]]; then
  rel="${cwd#$project_dir}"
  [[ -z "$rel" ]] && dir_display="$(basename "$project_dir")" || dir_display="$(basename "$project_dir")$rel"
fi
printf "\033[0;36m%s\033[0m" "$dir_display"

# Git status info (adapted from p10k config)
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  # Colors
  branch_green='\033[0;92m'  # light green for branch
  clean='\033[0;32m'         # green
  modified='\033[0;33m'      # yellow
  untracked='\033[0;34m'     # blue
  conflicted='\033[0;31m'    # red
  reset='\033[0m'

  # Get branch name
  branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)

  if [[ -n "$branch" ]]; then
    # Truncate long branch names (like p10k does)
    if [[ ${#branch} -gt 32 ]]; then
      branch="${branch:0:12}..${branch: -12}"
    fi

    # Get git status counts
    num_staged=$(git -C "$cwd" --no-optional-locks diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    num_unstaged=$(git -C "$cwd" --no-optional-locks diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    num_untracked=$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')
    num_conflicts=$(git -C "$cwd" --no-optional-locks diff --name-only --diff-filter=U 2>/dev/null | wc -l | tr -d ' ')

    # Get commits ahead/behind
    upstream=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref @{upstream} 2>/dev/null)
    ahead=0
    behind=0
    if [[ -n "$upstream" ]]; then
      ahead=$(git -C "$cwd" --no-optional-locks rev-list --count ${upstream}..HEAD 2>/dev/null || echo 0)
      behind=$(git -C "$cwd" --no-optional-locks rev-list --count HEAD..${upstream} 2>/dev/null || echo 0)
    fi

    # Check for git action (merge, rebase, etc.)
    git_dir=$(git -C "$cwd" rev-parse --git-dir 2>/dev/null)
    action=""
    if [[ -f "$git_dir/MERGE_HEAD" ]]; then
      action="merge"
    elif [[ -d "$git_dir/rebase-merge" ]] || [[ -d "$git_dir/rebase-apply" ]]; then
      action="rebase"
    elif [[ -f "$git_dir/CHERRY_PICK_HEAD" ]]; then
      action="cherry-pick"
    elif [[ -f "$git_dir/REVERT_HEAD" ]]; then
      action="revert"
    fi

    # Build git status string with light green branch name
    git_status=" ${reset}│${reset} ${branch_green}${branch}${reset}"

    # Add ahead/behind indicators
    [[ $behind -gt 0 ]] && git_status+=" ${clean}<${behind}${reset}"
    [[ $ahead -gt 0 ]] && git_status+=" ${clean}>${ahead}${reset}"

    # Add action if present
    [[ -n "$action" ]] && git_status+=" ${conflicted}${action}${reset}"

    # Add file status counts
    [[ $num_conflicts -gt 0 ]] && git_status+=" ${conflicted}~${num_conflicts}${reset}"
    [[ $num_staged -gt 0 ]] && git_status+=" ${modified}+${num_staged}${reset}"
    [[ $num_unstaged -gt 0 ]] && git_status+=" ${modified}!${num_unstaged}${reset}"
    [[ $num_untracked -gt 0 ]] && git_status+=" ${untracked}?${num_untracked}${reset}"

    printf "%b" "$git_status"
  fi
fi

# Model name
if [[ -n "$model" ]]; then
  model_short=$(echo "$model" | sed -E "s/Claude ([0-9.]+) ([A-Za-z]+)/\2 \1/")
  printf " \033[0m│\033[0m \033[0;35m%s\033[0m" "$model_short"
fi

# Output style
if [[ "$style" != "default" && -n "$style" ]]; then
  printf " \033[0m│\033[0m \033[0;34m[%s]\033[0m" "$style"
fi

# Cost info
if [[ "$session_cost" != "null" && "$session_cost" != "0" ]]; then
  printf " \033[0m│\033[0m \033[2msession:\033[0m \033[0;93m\$%.3f\033[0m" "$session_cost"
fi

if [[ "$day_cost" != "0" && "$day_cost" != "" ]]; then
  printf " \033[0m│\033[0m \033[2mtoday:\033[0m \033[0;92m\$%.3f\033[0m" "$day_cost"
fi

echo
