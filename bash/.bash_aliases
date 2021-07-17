#My aliases

alias ll="ls -l"
alias lla="ls -la"
alias sublime="sublime_text"
alias path="echo $PATH | sed 's/:/\n/g'"
alias rm="rm -i"
alias pm="pulsemixer"
alias weka="~/.weka/weka-3-8-5/weka.sh &"

#Aliases usados com simple_mtpfs
alias alist="simple-mtpfs -l"
alias amount="simple-mtpfs --device" #[device number] [mountpoint]

alias aumount="fusermount -u"

#Redshift
alias reds="redshift -l -21.595414323543466:-46.88868010008186"


function jupylab() {
    jupyter lab --browser=firefox
}

function jupynb() {
    jupyter notebook --browser=firefox
}

function sd(){
    read -p 'Shutdown now(Y/n)? ' out
    [ $out == 'Y' ] && shutdown +0
    unset out
}

function rb(){
    read -p 'Reboot now(Y/n)? ' out
    [ $out == 'Y' ] && reboot
    unset out
}

function killusb() {
    [ $# == 1 ] && udiskie-umount $1 --force --detach
}
