#!/usr/bin/env bash

# reset keyboard mappings to default us and kell xcape for a fresh start
setxkbmap -layout us
pkill -x xcape

# use control instead of caps
setxkbmap -option ctrl:nocaps
# short press on control act as escape
xcape -e "Control_L=Escape"

xmodmap -e "keycode 19 = 0 parenright UF6 UD6"
xmodmap -e "keycode 20 = minus underscore UFC UDC"
xmodmap -e "keycode 21 = equal plus UF3 UD3"

xmodmap -e "keycode 34 = bracketleft braceleft U151 U150"
xmodmap -e "keycode 35 = bracketright braceright UFA UDA"

xmodmap -e "keycode 47 = semicolon colon UE9 UCA"
xmodmap -e "keycode 48 = apostrophe quotedbl UE1 UC1"
xmodmap -e "keycode 51 = backslash bar U171 U170"

xmodmap -e "keycode 61 = slash question UED UCD"

xmodmap -e "keycode 24 = q Q U1D4E0"
xmodmap -e "keycode 25 = w W U1D4E6"
xmodmap -e "keycode 26 = e E U1D4D4"
xmodmap -e "keycode 27 = r R U1D4E1"
xmodmap -e "keycode 28 = t T U1D4E3"
xmodmap -e "keycode 29 = y Y U1D4E8"
xmodmap -e "keycode 30 = u U U1D4E4"
xmodmap -e "keycode 31 = i I U1D4D8"
xmodmap -e "keycode 32 = o O U1D4DE"
xmodmap -e "keycode 33 = p P U1D4DF"

xmodmap -e "keycode 38 = a A U1D4D0"
xmodmap -e "keycode 39 = s S U1D4E2"
xmodmap -e "keycode 40 = d D U1D4D3"
xmodmap -e "keycode 41 = f F U1D4D5"
xmodmap -e "keycode 42 = g G U1D4D6"
xmodmap -e "keycode 43 = h H U1D4D7"
xmodmap -e "keycode 44 = j J U1D4D9"
xmodmap -e "keycode 45 = k K U1D4DA"
xmodmap -e "keycode 46 = l L U1D4DB"

xmodmap -e "keycode 52 = z Z U1D4E9"
xmodmap -e "keycode 53 = x X U1D4E7"
xmodmap -e "keycode 54 = c C U1D4D2"
xmodmap -e "keycode 55 = v V U1D4E5"
xmodmap -e "keycode 56 = b B U1D4D1"
xmodmap -e "keycode 57 = n N U1D4DD"
xmodmap -e "keycode 58 = m M U1D4DC"

# Mode_switch is a 3rd level modifier similar to Shift which is a 2nd level modifier
spare_modifier="Mode_switch"

# space is 65 and tab is 23; but you can use any ordinary key
# change Tab to modifier
xmodmap -e "keycode 23 = $spare_modifier"
xmodmap -e "keycode any = Tab"
# short press on modifier act as Tab
xcape -e "$spare_modifier=Tab"
