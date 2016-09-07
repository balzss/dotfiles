#!/usr/bin/env bash

i3status -c $HOME/.config/i3blocks/i3status.conf | while IFS= read -r line; do
    PARTS=($line)

    CHARGE="${PARTS[1]}"
    CHARGE="${CHARGE%\%*}"

    LEVEL=$(( (CHARGE - 1) / 20 ))
    ICON="f$(( 244 - LEVEL ))"

    echo -e "  \u${ICON}  ${CHARGE} "

    [[ "${LEVEL}" = "0" ]]
done
