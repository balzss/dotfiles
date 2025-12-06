#!/bin/bash

# 1. Open Slack (Flatpak)
flatpak run com.slack.Slack &
sleep 1

# 2. Open Chrome - Profile 5 (Flatpak)
flatpak run com.google.Chrome --profile-directory="Profile 5" &
sleep 1

# 3. Open Kitty Terminal
kitty &
sleep 1

# 4. Open Chrome - Default Profile (Flatpak)
flatpak run com.google.Chrome --profile-directory="Default" &

exit 0
