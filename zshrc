# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/home/wanghao/.oh-my-zsh" 
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
plugins=(
  git autojump extract zsh-autosuggestions zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

export TERM=xterm-256color
bindkey ',' autosuggest-accept
alias jupwn="PWNLIB_NOTERM='1' jupyter lab"
alias vmrun="/Applications/VMWare\ Fusion.app/Contents/Library/vmrun"
alias manjarorun="vmrun start ~/Virtual\ Machines.localized/manjaro.vmwarevm nogui"
alias manjarostop="vmrun stop ~/Virtual\ Machines.localized/manjaro.vmwarevm"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias newt="tmux new -s"
alias killt="tmux kill-session -t"
alias help="tldr"
alias lookip='curl cip.cc'
