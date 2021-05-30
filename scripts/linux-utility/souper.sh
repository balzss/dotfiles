cd $(find . -type d \( -name .git -o -name .venv -o -name node_modules \) -prune -o -print | fzy)
