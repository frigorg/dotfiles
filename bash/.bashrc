#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#Link to my $PATH additional paths
#~/.profile

#Link to my aliases
source ~/.bash_aliases

#Make Starship displays a nice window title
function set_win_title(){
    echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"
}
starship_precmd_user_func="set_win_title"
eval "$(starship init bash)"

echo ""
pfetch
