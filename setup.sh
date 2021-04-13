#! /bin/bash

# Setup constants
INSTALL_DIR=~/tmp/install;
PACKAGES_FILE=package_list.txt;
ALL_FLAG=0;

while getopts ":ha" opt; do
  case ${opt} in
    h) 
        echo "Usage: ./setup.sh [-h] [-a]";
        exit 0;
        ;;
    a)
        ALL_FLAG=1
        ;;
  esac
done

main;

error() { clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;}

node_install() {
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -;
    apt install -y nodejs;
}

discord_install() {
    wget -O discord.deb https://discordapp.com/api/download?platform=linux&format=deb;
    dpkg -i discord.deb;
}

zoom_install() {
    wget -O zoom.deb https://zoom.us/client/latest/zoom_amd64.deb;
    dpkg -i zoom.deb;
}

ngrok_install() {
    wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.tgz;
    unzip ngrok.zip;
    mv ngrok /usr/local/bin/;
}

# TODO: verify commands
light_install() {
    wget -O light-1.2.2.tar.gz https://github.com/haikarainen/light/archive/refs/tags/v1.2.2.tar.gz;
    tar -xf light-1.2.2.tar.gz;
}

betterlockscreen_install() {
    git clone https://github.com/pavanjadhaw/betterlockscreen;
    cp betterlockscreen/betterlockscreen /usr/local/bin;
}

google_chrome_install() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
    sudo dpkg -i google-chrome-stable_current_amd64.deb;
}

postman_install() {
    snap install postman;
}

deluge_install() {
    apt install software-properties-common;
    add-apt-repository ppa:deluge-team/stable;
    apt install deluge;
}

virtualenv_install() {
    python -m pip install --user virtualenv;
}

# TODO: setup extensions and settings.json
vscode_install() {
    wget -O vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64;
    apt install ./vscode.deb;
}

# Missing: light, vscode setup
software_install() {
    node_install || error "Unable to install nodejs.";
    discord_install || error "Unable to install discord.";
    zoom_install || error "Unable to install zoom.";
    ngrok_install || error "Unable to install ngrok.";
    google_chrome_install || error "Unable to install google-chrome.";
    vscode_install || error "Unable to install vscode";
}

symlink_setup() {
    ln -s ~/.dotfiles/base/.zshrc ~/.zshrc;
    ln -s ~/.dotfiles/base/.vimrc ~/.vimrc;
    ln -s ~/.dotfiles/config ~/.config;
}

update_shell() {
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    chsh -s /bin/zsh "$name" >/dev/null 2>&1;
}


main() {
    # Update, upgrade and install packages specified in $PACKAGES_FILE
    apt update && apt upgrade;
    xargs apt install < $PACKAGES_FILE;

    mkdir -p $INSTALL_DIR && cd $INSTALL_DIR;

    if [[ "$ALL_FLAG" == 1 ]]; then
        software_install;
    fi

    symlink_setup || error "Unable to setup symlinks.";
    update_shell || error "Unable to update shell";

    echo "No errors! Hurray!";
    exit 0;
}

