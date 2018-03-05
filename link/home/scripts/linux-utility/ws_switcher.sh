CURRENT_WS=`wmctrl -d | grep \* | cut -d " " -f 1`

if [ "CURRENT_WS" == "0" ]; then
    wmctrl -s 1
else
    wmctrl -s 0
fi
