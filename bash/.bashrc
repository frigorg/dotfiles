# Starship
eval "$(starship init bash)"

# My custom paths/conf
pfetch

#asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

#pasta dos meus binários
PATH="${HOME}/.local/share/bin:${PATH}"

# My custom variables
EDITOR="vim"
