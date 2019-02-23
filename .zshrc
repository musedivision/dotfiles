# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )




# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

export VIMINIT="source ~/.vim/.vimrc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
. ~/z.sh
source ~/.bashrc
#source ~/.bash_profile
alias code="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron /usr/local/sbin/code"

# path for .vimrc
export VIMINIT="source ~/.vim/.vimrc"

# ctags setup
alias ctags="`brew --prefix`/bin/ctags"

#setopt correct
unsetopt CASE_GLOB

# tmux aliases
alias tn="tmux new -s"
alias ta="tmux attach"
alias td="tmux detach"
alias tls="tmux list-sessions"
alias tk="tmux kill-session -t"
alias dps="docker ps"

# FZF and Ag 
# # Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# RUBY
export PATH=$PATH:~/.gem/ruby/2.3.0/bin
