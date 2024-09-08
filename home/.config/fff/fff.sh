#
# Include `source ~/.config/fff.sh` to the .bashrc file
#

function ff() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

# export FFF_FAV1=
# export FFF_FAV2=
# export FFF_FAV3=
# export FFF_FAV4=
# export FFF_FAV5=
# export FFF_FAV6=
# export FFF_FAV7=
# export FFF_FAV8=
# export FFF_FAV9=

export EDITOR="vim"
export FFF_OPENER="xdg-open"
export FFF_TRASH=
export FFF_MARK_FORMAT="> %f"

