#!/bin/bash

# 1. Open Kitty Terminal
kitty &
sleep 1

# 2. Open Chrome - Default Profile (Flatpak)
flatpak run com.google.Chrome --profile-directory="Default" &

exit 0
