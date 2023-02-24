#My aliases

alias aliases="cat ~/.bash_aliases | grep '^alias\|^.*()' | sed 's/^alias //g; s/=\".*\#/ = /g; s/().*\#/ = /g'" #Show all the aliases
alias ll="ls -l" #Long listing format
alias lla="ls -la" #Long listing format including hiden files
alias code="code -n" #Runs Visual Studio Code in a new session
alias path="echo $PATH | sed 's/:/\n/g'" #Shows the Path paths
alias rm="rm -i" #Remove with a confirmation
alias pm="pulsemixer" #Runs pulsemixer
alias xo="xdg-open" #Opens a file using xdg-open


sd(){ #Asks for shutdown
    read -p 'Shutdown now(y/n)? ' out
    [ $out == 'y' ] && shutdown +0
    unset out
}
