#!/bin/sh

function bkp_dotfiles(){
    [ -d "$HOME/.config/awessome" ] && cp -uvr "$HOME/.config/awesome" .
    [ -d "$HOME/.config/alacritty" ] && cp -uvr "$HOME/.config/alacritty" .
    [ -d "$HOME/.config/bspwm" ] && cp -uvr "$HOME/.config/bspwm" .
    [ -d "$HOME/.config/sxhkd" ] && cp -uvr "$HOME/.config/sxhkd" .
    [ -f "$HOME/.config/starship.toml" ] && { mkdir -p "./starship"; cp -uv "$HOME/.config/starship.toml" "./starship"; }
    [ -f "$HOME/.config/Code/User/settings.json" ] && { mkdir -p "./Code/User"; cp -uv "$HOME/.config/Code/User/settings.json" "./Code/User"; }
    [ -f "$HOME/.config/Code/User/keybindings.json" ] && { mkdir -p "./Code/User"; cp -uv "$HOME/.config/Code/User/keybindings.json" "./Code/User"; }
    mkdir -p bash
    [ -f "$HOME/.bash_aliases" ] && cp -uvr "$HOME/.bash_aliases" "./bash"
    [ -f "$HOME/.bashrc" ] && cp -uvr "$HOME/.bashrc" "./bash"
    mkdir -p vim
    [ -f "$HOME/.vimrc" ] && cp -uvr "$HOME/.vimrc" "./bash"
    mkdir -p vim/colors
    cp -uvr "$HOME/.vim/colors" "./vim/colors"
    mkdir -p "etc/X11"
    cp -uvr "/etc/X11/xorg.conf.d" "./etc/X11"
    [ -f "$HOME/.config/fff.sh" ] && { mkdir -p "./fff"; cp -uv "$HOME/.config/fff.sh" "./fff"; }
}

read -p 'Proceed with the backup?(y/n) ' out
if [ $out == 'y' ]
then  
    bkp_dotfiles 
    printf "**Make sure to write on bashrc all necessary configurations to launch starship.**\n**Vim needs vim-plug to runs properly this configuration file.**"
fi

unset out
unset bkp_dotfiles
