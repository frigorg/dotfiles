#My aliases

alias ll="ls -l"
alias lla="ls -la"
alias code="code -n"
alias sublime="sublime_text"
alias path="echo $PATH | sed 's/:/\n/g'"
alias aliases="cat ./.bash_aliases | grep '^alias\|^.*()' | sed 's/^alias //g; s/=\".*$//g; s/().*$//g'"
alias rm="rm -i"
alias srm="trash-put"
alias pm="pulsemixer"
alias xo="xdg-open"
alias weka="~/.weka/weka-3-8-5/weka.sh &"

#Aliases usados com simple_mtpfs
alias alist="simple-mtpfs -l"
alias amount="simple-mtpfs --device" #[device number] [mountpoint]

alias aumount="fusermount -u"

#Redshift
alias reds="redshift -l -21.595414323543466:-46.88868010008186"


jupylab() {
    jupyter lab --browser=firefox
}

jupynb() {
    jupyter notebook --browser=firefox
}

sd(){
    read -p 'Shutdown now(y/n)? ' out
    [ $out == 'y' ] && shutdown +0
    unset out
}

rb(){
    read -p 'Reboot now(y/n)? ' out
    [ $out == 'y' ] && reboot
    unset out
}

killusb() {
    [ $# == 1 ] && udiskie-umount $1 --force --detach
}


