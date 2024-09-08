#!/bin/bash

declare -A FILES_PATH

mkdir -p home/.config
mkdir -p etc/X11/xorg.conf.d

#TODO separate rsync flags from the path
FILES_PATH['awesome']="$HOME/.config/awesome --exclude external_widgets ./home/.config"
FILES_PATH['alacritty']="$HOME/.config/alacritty ./home/.config"
FILES_PATH['bspwm']="$HOME/.config/bspwm $HOME/.config/sxhkd ./home/.config"
FILES_PATH['starship']="$HOME/.config/starship.toml ./home/.config"
mkdir -p home/.config/Code/User
FILES_PATH['vscode']="$HOME/.config/Code/User/keybindings.json $HOME/.config/Code/User/settings.json .home/.config/Code/User"
FILES_PATH['bash']="$HOME/.bash_aliases $HOME/.bashrc ./home"
FILES_PATH['vim']="$HOME/.vim/vimrc $HOME/.vim/colors ./home/.vim"
FILES_PATH['nvim']="$HOME/.config/nvim ./home/.config"
FILES_PATH['fff']="$HOME/.config/fff.sh ./home/.config"
FILES_PATH['nnn']="$HOME/.config/nnn.sh ./home/.config"
FILES_PATH['x11conf']="/etc/X11/xorg.conf.d/50-mouse-acceleration.conf ./etc/X11/xorg.conf.d"

#TODO try to synchronize only existing paths
bkp_dotfiles(){
    for i in "${!FILES_PATH[@]}" 
    do 
        echo "------------"
        echo "Synchronizing $i..." 
        rsync -avh --delete ${FILES_PATH[$i]} 
        echo ""
    done
}

while getopts ':he:o:' OPTION; do
    case "$OPTION" in
    h)
        echo "Usage: $(basename $0) [-h] [-e PROGRAM_NAME] [-o PROGRAM_NAME]" >&2
        echo "Synchronize configurations files from various programs to this repository\n"
        echo "-h Display this help and exit" >&2
        echo "-e [PROGRAM_NAME]  Exclude a specific program from synchronizing" >&2
        echo "-o [PROGRAM_NAME]  Only synchronize a specific program" >&2
        echo "Avaliable programs:"
        for i in "${!FILES_PATH[@]}"; do echo "$i"; done
        exit 0
        ;;
    e)
        #TODO handle multiple arguments
        eopt="$OPTARG"
        if [[ -n "${FILES_PATH[$eopt]}" ]]; then 
            unset 'FILES_PATH[$eopt]'
            bkp_dotfiles
            exit 0
        else
            echo "Informed program does not exists."
            exit 1
        fi
        ;;
    o)
        #TODO handle multiple arguments
        oopt="$OPTARG"
        if [[ -n "${FILES_PATH[$oopt]}" ]]; then 
            rsync -avh --delete ${FILES_PATH[$oopt]} 
            exit 0
        else
            echo "Informed program does not exists."
            exit 1
        fi
        ;;
    ?)
        echo "Usage: $(basename $0) [-h] [-e FILE||PATH] [-o FILE||PATH]" >&2
        exit 1
        ;;
    esac
done
shift "$(($OPTIND -1))"

bkp_dotfiles

unset bkp_dotfiles
unset FILES_PATH
