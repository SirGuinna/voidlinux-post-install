#!/bin/bash
selected=$(echo "
theme1
theme2
theme3
theme4
cancelar" | rofi -dmenu -p "MENU DE TEMAS")
[[ -z $selected ]] && exit
case $selected in
"theme1")python  $HOME/.config/i3/scripts/theme-selector.py theme1;;
"theme2")python  $HOME/.config/i3/scripts/theme-selector.py theme2;;
"theme3")python  $HOME/.config/i3/scripts/theme-selector.py theme3;;
"theme4")python  $HOME/.config/i3/scripts/theme-selector.py theme4;;
*)exit;;
esac