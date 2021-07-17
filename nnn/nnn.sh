#
# Include `source ~/.config/nnn/nnn.sh` to the .bashrc file
#

if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

NNN_LOCALVAL(){
    local N_TRASH="t:$HOME/.local/share/Trash/files;"
    local N_UFRN="u:$HOME/Documents/UFRN;" 
    local N_CONF="c:$HOME/.config;" 
    export NNN_BMS="$N_TRASH$N_UFRN$N_CONF"
}
NNN_LOCALVAL
unset NNN_LOCALVAL

export NNN_TRASH=1
export NNN_PREVIEWDIR="$XDG_CACHE_HOME/nnn/previews"
export NNN_PLUG="s:imgview"
