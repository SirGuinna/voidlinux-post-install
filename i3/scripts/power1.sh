#!/bin/bash
selected=$(echo " Reboot
 Shutdown
 Logout
Cancel" | rofi -dmenu -p "MENU DA SESSÃO")
[[ -z $selected ]] && exit
case $selected in
" Reboot")reboot;;
" Shutdown")shutdown now;;
" Logout")i3-msg exit;;
*)echo "Nada a fazer....";; 
esac
