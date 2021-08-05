#My aliases

alias aliases="cat ~/.bash_aliases | grep '^alias\|^.*()' | sed 's/^alias //g; s/=\".*\#/ = /g; s/().*\#/ = /g'" #Show all the aliases
alias ll="ls -l" #Long listing format
alias lla="ls -la" #Long listing format including hiden files
alias code="code -n" #Runs Visual Studio Code in a new session
alias path="echo $PATH | sed 's/:/\n/g'" #Shows the Path paths
alias rm="rm -i" #Remove with a confirmation
alias srm="trash-put" #Send a file to trash bin
alias pm="pulsemixer" #Runs pulsemixer
alias xo="xdg-open" #Opens a file using xdg-open

alias als="simple-mtpfs -l" #List avaliable Android devices

amt(){ #$[device number] Mounts an Android device at ~/.mnt
    [ $# == 1 ] && simple-mtpfs --device "$1" "/home/$USER/.mnt"
} 

alias aumt="fusermount -u '/home/$USER/.mnt'" #Unmount Android device mounted at ~/.mnt

mt(){ #$[device name without /dev/] Mounts a device
    [ $# == 1 ] && udisksctl mount -b "/dev/$1"
}

umt() { #$[device name without /dev/] Unmounts a device
    [ $# == 1 ] && udiskie-umount "/dev/$1" --detach
}

alias jupylab="jupyter lab --browser=firefox" #Starts Jupyter Lab in Firefox

alias jupynb="jupyter notebook --browser=firefox" #Starts Jupyter notebook in Firefox

sd(){ #Asks for shutdown
    read -p 'Shutdown now(y/n)? ' out
    [ $out == 'y' ] && shutdown +0
    unset out
}
