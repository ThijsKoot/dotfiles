# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


alias oldll=ls -l
alias ll="ls -a"
alias oldvim=vim
alias vim=nvim
alias td="todoist --color"
alias kc=kubectl
alias k=kubectl
alias py=python
# force tmux to use `screen-256color` instead of default `alacritty`
alias tmux='TERM=screen-256color tmux'


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
complete -F __start_kubectl k

source /usr/share/nvm/init-nvm.sh

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.ghcup/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/scripts:$PATH

eval "$(pipenv --completion)"

# use vi keymap
set -o vi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/thijs/.sdkman"
[[ -s "/home/thijs/.sdkman/bin/sdkman-init.sh" ]] && source "/home/thijs/.sdkman/bin/sdkman-init.sh"
