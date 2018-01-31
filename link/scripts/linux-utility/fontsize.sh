CFS="$(gsettings get org.gnome.desktop.interface text-scaling-factor)"
if [ "$CFS" = "1.0" ]
then
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
else
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.0
fi
