#
# Include `source ~/.config/nnn/nnn.sh` to the .bashrc file
#

if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

export NNN_TRASH=1
export NNN_PREVIEWDIR="$XDG_CACHE_HOME/nnn/previews"
export NNN_PLUG="s:imgview"
