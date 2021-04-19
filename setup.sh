#! /bin/bash

# Setup constants
# TODO: setup current user command?
# i.e. sudo ./setup.sh -a -u $USER
USER=ubuntu;
HOME=/home/$USER;
REPO_DIR=$HOME/.dotfiles;
INSTALL_DIR=$HOME/tmp/install;
VSCODE_FILE=$REPO_DIR/vscode_extensions.txt;
VIM_PKG_DIR=$HOME/.vim/bundle;
PACKAGES_FILE=$REPO_DIR/packages_list.txt;
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

node_install() {
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -;
    apt install -y nodejs;
}

discord_install() {
    snap install discord;
}

zoom_install() {
    wget -O zoom.deb https://zoom.us/client/latest/zoom_amd64.deb;
    apt install ./zoom.deb;
}

ngrok_install() {
    wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    unzip ngrok.zip;
    mv ngrok /usr/local/bin/;
}

light_install() {
    wget -O light-1.2.2.tar.gz https://github.com/haikarainen/light/archive/refs/tags/v1.2.2.tar.gz;
    tar -xf light-1.2.2.tar.gz;
    cd light-1.2.2;
    ./autogen.sh;
    ./configure && make;
    make install;
}

betterlockscreen_install() {
    git clone https://github.com/pavanjadhaw/betterlockscreen;
    cp betterlockscreen/betterlockscreen /usr/local/bin;
}

polybar_install() {
    git clone https://github.com/polybar/polybar.git
    
}

google_chrome_install() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
    apt install -y ./google-chrome-stable_current_amd64.deb;
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

vscode_install() {
    snap install --classic code;
    cat $VSCODE_FILE | xargs -L1 code --user-data-dir $USER --install-extension < $VSCODE_FILE;
}

vim_setup() {
    mkdir -p ~/.vim/autoload ~/.vim/bundle;
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;

    # Install plugins
    git clone https://github.com/vim-airline/vim-airline $VIM_PKG_DIR/vim-airline; 
    git clone git://github.com/altercation/vim-colors-solarized.git $VIM_PKG_DIR/vim-colors-solarized;
}

# Missing: light, deluge, postman, virtualenv, betterlockscreen
software_install() {
    node_install;
    discord_install;
    zoom_install;
    ngrok_install;
    google_chrome_install;
    vscode_install;
}

symlink_setup() {
    ln -s ~/.dotfiles/base/.zshrc ~/.zshrc;
    ln -s ~/.dotfiles/base/.vimrc ~/.vimrc;
    ln -s ~/.dotfiles/base/settings.json ~/.config/Code/User/settings.json;
    ln -s ~/.dotfiles/config ~/.config;
}

update_shell() {
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    chsh -s /bin/zsh ubuntu >/dev/null 2>&1;
}


main() {
    # Update, upgrade and install packages specified in $PACKAGES_FILE
    #apt -y update && apt -y upgrade;
    #xargs apt -y install < $PACKAGES_FILE;
    #vim_setup;

    #mkdir -p $INSTALL_DIR;
    cd $INSTALL_DIR;

    if [[ "$ALL_FLAG" == 1 ]]; then
        software_install;
    fi

    #symlink_setup || error "Unable to setup symlinks.";
    update_shell || error "Unable to update shell";

    echo "No errors. Hurray!";
    cd $REPO_DIR;
    exit 0;
}

main;
