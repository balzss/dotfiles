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

# ==========================================
# GIT WORKTREE WORKFLOW
# ==========================================

function workon() {
    local MAIN_DIR=$(git worktree list 2>/dev/null | head -n 1 | awk '{print $1}')

    if [ -z "$MAIN_DIR" ]; then
        echo "❌ You don't seem to be inside a git repository."
        return 1
    fi

    local BRANCH="$1"

    # Interactive Mode via fzf
    if [ -z "$BRANCH" ]; then
        if ! command -v fzf &> /dev/null; then
            echo "❌ Provide a branch name, or install 'fzf' for the menu."
            return 1
        fi

        echo "🔍 Select a branch/task (type to search, Esc to cancel):"
        # Hide the branch we're currently on — selecting it would be a no-op
        local CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)

        # Annotate branches that already have a worktree with ♻️ and float them to the top
        BRANCH=$(awk -v cur="$CURRENT_BRANCH" '
                NR==FNR { m[$0] = 1; next }
                $0 == cur { next }
                m[$0] { hot[++h] = $0; next }
                       { cold[++c] = $0 }
                END {
                    for (i = 1; i <= h; i++) printf "♻️  %s\n", hot[i]
                    for (i = 1; i <= c; i++) printf "   %s\n", cold[i]
                }
            ' \
            <(git -C "$MAIN_DIR" worktree list --porcelain \
                | awk '$1=="branch" { sub("refs/heads/","",$2); print $2 }') \
            <(git -C "$MAIN_DIR" for-each-ref \
                    --format='%(refname:short)' \
                    refs/heads refs/remotes \
              | sed 's|^origin/||' \
              | grep -v '^HEAD$' \
              | sort -u) \
            | fzf --prompt="Task/Branch > " --height=40% --layout=reverse --border \
            | awk '{ print $NF }') || true

        if [ -z "$BRANCH" ]; then
            echo "🛑 Cancelled."
            return 0
        fi
    fi

    # Sanitize: strip carriage returns, replace spaces with hyphens
    BRANCH=$(echo "$BRANCH" | tr -d '\r' | tr ' ' '-')

    if ! git check-ref-format --allow-onelevel "$BRANCH" 2>/dev/null; then
        echo "❌ Git rejected the branch name: '$BRANCH'"
        echo "💡 Branch names cannot contain double dots (..), trailing slashes, or special characters."
        return 1
    fi

    local TASK_NAME=$(basename "$BRANCH")

    # Handle Master/Main
    if [[ "$BRANCH" == "master" || "$BRANCH" == "main" ]]; then
        echo "🌳 Opening base repository ($BRANCH)..."
        git -C "$MAIN_DIR" checkout "$BRANCH" && git -C "$MAIN_DIR" pull || return 1

        cd "$MAIN_DIR"
        return 0
    fi

    # Worktree location: sibling of main repo
    local WORKTREE_DIR="${MAIN_DIR:h}/wt-$TASK_NAME"

    # Re-entry: worktree already exists
    if [ -d "$WORKTREE_DIR" ]; then
        echo "♻️ Worktree exists! Switching to it..."
        cd "$WORKTREE_DIR"
        return 0
    fi

    # Re-entry: branch is already checked out in some other worktree.
    # A branch can only live in one worktree at a time, and its directory
    # name may not match wt-$TASK_NAME, so look it up explicitly.
    local EXISTING_WT=$(git -C "$MAIN_DIR" worktree list --porcelain \
        | awk -v b="refs/heads/$BRANCH" '
            $1=="worktree" { wt=$2 }
            $1=="branch" && $2==b { print wt; exit }
        ')
    if [ -n "$EXISTING_WT" ]; then
        echo "♻️ Branch '$BRANCH' is already checked out at $EXISTING_WT. Switching to it..."
        cd "$EXISTING_WT"
        return 0
    fi

    echo "🌳 Creating new worktree at $WORKTREE_DIR..."

    # Smart checkout: existing local > existing remote > new branch
    if git -C "$MAIN_DIR" show-ref --verify --quiet "refs/heads/$BRANCH"; then
        echo "➡️ Found local branch '$BRANCH'. Checking out..."
        git -C "$MAIN_DIR" worktree add "$WORKTREE_DIR" "$BRANCH" || return 1
    elif git -C "$MAIN_DIR" show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
        echo "➡️ Found remote branch 'origin/$BRANCH'. Tracking..."
        git -C "$MAIN_DIR" worktree add --track -b "$BRANCH" "$WORKTREE_DIR" "origin/$BRANCH" || return 1
    else
        echo "✨ Branch '$BRANCH' not found. Creating as new..."
        git -C "$MAIN_DIR" worktree add "$WORKTREE_DIR" -b "$BRANCH" || return 1
    fi

    if [ ! -d "$WORKTREE_DIR" ]; then
        echo "❌ Error creating worktree."
        return 1
    fi

    # Copy local-only files (e.g. .env) that aren't tracked by git
    for f in .env .env.local; do
        if [ -f "$MAIN_DIR/$f" ]; then
            cp "$MAIN_DIR/$f" "$WORKTREE_DIR/$f"
            echo "📋 Copied $f"
        fi
    done

    cd "$WORKTREE_DIR"
    echo "✅ Workspace ready!"
}

function cleantask() {
    local MAIN_DIR=$(git worktree list 2>/dev/null | head -n 1 | awk '{print $1}')

    if [ -z "$MAIN_DIR" ]; then
        echo "❌ You don't seem to be inside a git repository."
        return 1
    fi

    echo "🔍 Select tasks to clean up (Tab=multi-select, Enter=confirm, Esc=cancel):"
    # Filter out the main worktree explicitly (don't trust list ordering)
    local WT_LINES=$(git -C "$MAIN_DIR" worktree list \
        | awk -v main="$MAIN_DIR" '$1 != main' \
        | fzf --multi \
              --prompt="Clean Tasks > " \
              --height=40% --layout=reverse --border \
              --header="Tab: select  |  Shift-Tab: deselect  |  Enter: confirm") || true

    if [ -z "$WT_LINES" ]; then
        echo "🛑 Cancelled."
        return 0
    fi

    local COUNT=$(echo "$WT_LINES" | wc -l | tr -d ' ')
    echo "🧹 Removing $COUNT worktree(s)..."

    echo "$WT_LINES" | while IFS= read -r WT_LINE; do
        [ -z "$WT_LINE" ] && continue

        local WT_PATH=$(echo "$WT_LINE" | awk '{print $1}')

        # Resolve branch via porcelain output — handles detached HEAD correctly
        local BRANCH_NAME=$(git -C "$MAIN_DIR" worktree list --porcelain \
            | awk -v p="$WT_PATH" '
                $1=="worktree" && $2==p { found=1; next }
                found && $1=="branch" { sub("refs/heads/","",$2); print $2; exit }
                found && /^$/ { exit }
            ')

        echo
        echo "── $WT_PATH ${BRANCH_NAME:+($BRANCH_NAME)}"

        # Safety: warn on uncommitted changes before forcing removal
        local USE_FORCE=""
        if [ -d "$WT_PATH" ]; then
            if ! git -C "$WT_PATH" diff --quiet 2>/dev/null \
                || ! git -C "$WT_PATH" diff --cached --quiet 2>/dev/null \
                || [ -n "$(git -C "$WT_PATH" status --porcelain 2>/dev/null)" ]; then
                echo "⚠️  Has uncommitted changes."
                read -q "REPLY?    Force-remove anyway? (y/N/a=skip all dirty) " || { echo; echo "   ⏩ Skipped."; continue; }
                echo
                USE_FORCE="--force"
            fi
        fi

        if git -C "$MAIN_DIR" worktree remove $USE_FORCE "$WT_PATH"; then
            echo "✅ Worktree removed."
        else
            echo "❌ Failed to remove worktree."
            continue
        fi

        if [ -z "$BRANCH_NAME" ]; then
            echo "ℹ️  Was detached — no branch to clean up."
            continue
        fi

        # Try safe delete first; only escalate to -D after explicit confirmation
        if git -C "$MAIN_DIR" branch -d "$BRANCH_NAME" 2>/dev/null; then
            echo "✅ Local branch '$BRANCH_NAME' deleted (was merged)."
        else
            read -q "REPLY?⚠️  '$BRANCH_NAME' has unmerged commits. Force-delete? (y/N) "
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                git -C "$MAIN_DIR" branch -D "$BRANCH_NAME" \
                    && echo "✅ Local branch '$BRANCH_NAME' force-deleted."
            else
                echo "⏩ Kept local branch '$BRANCH_NAME'."
            fi
        fi
    done

    echo
    echo "✨ All clean!"
}
