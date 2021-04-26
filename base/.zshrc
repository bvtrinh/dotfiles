# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Prompt themes
autoload -Uz promptinit
promptinit

# Theme for git
ZSH_THEME="basic"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias python='python3'

plugins=(git)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ZSHRC Settings
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
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
#source $HOME/.local/bin/virtualenvwrapper.sh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk

# Plugins
zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS

