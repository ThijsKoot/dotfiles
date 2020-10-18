#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=$PATH:$HOME/.local/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/thijs/.sdkman"
[[ -s "/home/thijs/.sdkman/bin/sdkman-init.sh" ]] && source "/home/thijs/.sdkman/bin/sdkman-init.sh"
