# Path to your oh-my-zsh installation.
export ZSH="/home/ttrinh/.oh-my-zsh"

### Added by Zplugin's installer
source '/home/ttrinh/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Plugins
zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS

# Prompt themes
autoload -Uz promptinit
promptinit

# Theme for git
ZSH_THEME="basic"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

plugins=(git)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ZSHRC Settings
alias zshrc="vim ~/.zshrc"
alias ss="source ~/.zshrc"
alias ohmyzsh="vim  ~/.oh-my-zsh"
alias gc="cd ~/Documents/Classes/"

# URXVT Settings
alias xres="vim ~/.config/.Xresources"
alias xx="xrdb ~/.config/.Xresources"

# EXTRAS
alias printer="system-config-printer-applet &"
alias ic="vim ~/.config/i3/config"
alias cl="cd ~/Documents/Classes"
alias ww="cd ~/Documents/work/fabcycle"
alias gt="cd ~/.local/share/Trash/files"
alias sqlite="sqlite3"

#    /usr/lib/postgresql/10/bin/pg_ctl -D /var/lib/postgresql/10/main -l logfile start

# Python venvs
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents/Code
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh
