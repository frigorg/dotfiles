#
# Include `source ~/.config/nnn/nnn.sh` to the .bashrc file
#

if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

NNN_BOOKMARKSV(){
    local N_TRASH="t:$HOME/.local/share/Trash/files;"
    local N_UFRN="u:$HOME/Documents/UFRN;" 
    local N_CONF="c:$HOME/.config;" 
    export NNN_BMS="$N_TRASH$N_UFRN$N_CONF"

}
NNN_BOOKMARKSV
unset NNN_BOOKMARKSV

export NNN_TRASH=1
