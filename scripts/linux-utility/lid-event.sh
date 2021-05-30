#!/bin/bash
acpi_listen | while IFS= read -r line;
do
    if [ "$line" == "button/lid LID close" ]
    then
       notify-send "lid closed!"
       gsettings set org.gnome.desktop.interface text-scaling-factor 1
    elif [ "$line" == "button/lid LID open" ]
    then
       notify-send "lid opened!"
       gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
    fi
done
