#! /bin/sh

# Install all packages
apt update && apt upgrade;

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# This file will install the software that I use and setup 
# symlinks with my dotfiles

ln -s ~/.dotfiles/base/.zshrc ~/.zshrc;

ln -s ~/.dotfiles/base/.vimrc ~/.vimrc;

ln -s ~/.dotfiles/config ~/.config

