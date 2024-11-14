#!/bin/bash
echo "POWER"

powermenu(){
v=$(zenity --list --title="POWER" --text="POWER MANEGER" --radiolist --column="" --column="OPTIONS" "" "SHUTDOWN" "" "REBOOT")
if [ "$v" == "SHUTDOWN" ];then
shutdown now
elif [ "$v" == "REBOOT" ];then
reboot
else
zenity --info --title=INFO --text="NO ACTION" --ellipsize
fi
}


case $BLOCK_BUTTON in
 1)powermenu;;
esac
