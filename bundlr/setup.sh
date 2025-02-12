#!/bin/bash

node=$1
option=$2

install="https://raw.githubusercontent.com/DOUBLE-TOP/guides/main/bundlr/install_bundlr.sh"
update="https://raw.githubusercontent.com/DOUBLE-TOP/guides/main/bundlr/update_bundler.sh"
healthcheck="https://raw.githubusercontent.com/DOUBLE-TOP/guides/main/bundlr/health.sh"

confirm=$(dialog --clear --stdout --yesno "Do you want to install $node with option $option?" 0 0)

if [ "$?" -eq 0 ]; then
    confirm=1
else
    confirm=0
fi

# Show the main menu
if [ "$option" = "install" ]; then
    if [ "$confirm" != "0" ]; then
        . <(wget -qO- $install)
        dialog --title "Installation complete" --msgbox "The installation of $node with option $option was successful!" 0 0
    fi
elif [ "$option" = "update" ]; then
    if [ "$confirm" != "0" ]; then
        . <(wget -qO- $update)
        dialog --title "Update complete" --msgbox "The updating of $node was successful!" 0 0
    fi
elif [ "$option" = "healthcheck" ]; then
    if [ "$confirm" != "0" ]; then
        tmux new-session -d -s bundlr_healthcheck '. <(wget -qO- $healthcheck)'
        dialog --title "Healthcheck enabled" --msgbox "Healthcheck enabled for $node !" 0 0
    fi
else
    dialog --title "Installation cancelled" --msgbox "The installation was cancelled." 0 0
fi