#! /bin/bash

# Setup constants
USER=ttrinh;
HOME=/home/$USER;
REPO_DIR=$HOME/.dotfiles;
INSTALL_DIR=$HOME/software;
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
    sudo apt install -y nodejs;
}

discord_install() {
    sudo snap install discord;
}

zoom_install() {
    wget -O zoom.deb https://zoom.us/client/latest/zoom_amd64.deb;
    sudo apt install -y ./zoom.deb;
}

ngrok_install() {
    wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip;
    unzip ngrok.zip;
    mv ngrok /usr/local/bin/;
}

light_install() {
    wget -O light.deb https://github.com/haikarainen/light/releases/download/v1.2/light_1.2_amd64.deb;
    sudo apt install -y ./light.deb;
}

betterlockscreen_install() {
    git clone https://github.com/Raymo111/i3lock-color.git;
    cd i3lock-color && ./install-i3lock-color.sh;

    cd $INSTALL_DIR;

    git clone https://github.com/pavanjadhaw/betterlockscreen;
    sudo cp betterlockscreen/betterlockscreen /usr/local/bin;

    # Generate the lockscreen images
    betterlockscreen -u $REPO_DIR/images/girl1.png;

    # Lock when closing laptop
    sudo ln -sf $REPO_DIR/base/betterlockscreen@.service /etc/systemd/system;
    chmod +x $REPO_DIR/base/betterlockscreen@.service;
    sudo systemctl enable betterlockscreen@$USER;

    cd $INSTALL_DIR;
}

polybar_install() {
    git clone https://github.com/polybar/polybar.git;
    git submodule update --init --recursive;
    cd polybar && mkdir build;
    cd build && cmake ..;
    make -j$(nproc);
    sudo ln -s $INSTALL_DIR/polybar/build/bin/polybar /usr/local/bin;
    cd $INSTALL_DIR;
    fonts_install;
}

google_chrome_install() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
    sudo apt install -y ./google-chrome-stable_current_amd64.deb;
}

postman_install() {
    sudo snap install postman;
}

deluge_install() {
    sudo apt install -y software-properties-common;
    add-apt-repository -y ppa:deluge-team/stable;
    sudo apt install -y deluge;
}

virtualenv_install() {
    python3 -m pip install --user virtualenv;
}

vscode_install() {
    sudo snap install --classic code;
    cat $VSCODE_FILE | xargs -L1 code --user-data-dir $USER --install-extension < $VSCODE_FILE;
}

vim_setup() {
    mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle;
    curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;

    # Install plugins
    git clone https://github.com/vim-airline/vim-airline $VIM_PKG_DIR/vim-airline; 
    git clone https://github.com/altercation/vim-colors-solarized.git $VIM_PKG_DIR/vim-colors-solarized;
}

i3_install() {
    xargs sudo apt install -y < $REPO_DIR/poweruser_pkgs.txt;
}

fonts_install() {
    git clone https://github.com/ryanoasis/nerd-fonts.git;
    cd nerd-fonts;
    ./install.sh DejaVuSansMono;
    ./install.sh Hack;
    ./install.sh SourceCodePro;

    cd $INSTALL_DIR;

    mkdir -p $HOME/.local/share/fonts;

    git clone https://github.com/erikflowers/weather-icons.git;
    cd weather-icons && mv font/weathericons-regular-webfont.ttf $HOME/.local/share/fonts;

    cd $INSTALL_DIR;
    git clone https://github.com/FortAwesome/Font-Awesome.git
    mv Font-Awesome/otfs/'Font Awesome 5'* $HOME/.local/share/fonts;

    fc-cache -f -v;
    cd $INSTALL_DIR;
}

software_install() {
    node_install;
    discord_install;
    zoom_install;
    ngrok_install;
    google_chrome_install;
    vscode_install;
    deluge_install;
    postman_install;
    virtualenv_install;
}

poweruser_setup() {
    poweruser_symlinks;
    i3_install;
    polybar_install;
    betterlockscreen_install;
    light_install;
}

poweruser_symlinks() {
    ln -sf $REPO_DIR/config/i3 ~/.config;
    ln -sf $REPO_DIR/config/polybar ~/.config;
    ln -sf $REPO_DIR/config/screenlayout ~/.config;
}

symlink_setup() {
    ln -sf $REPO_DIR/base/.zshrc ~/.zshrc;
    ln -sf $REPO_DIR/base/.vimrc ~/.vimrc;
    ln -sf $REPO_DIR/base/basic.zsh-theme ~/.oh-my-zsh/custom/themes/basic.zsh-theme
    ln -sf $REPO_DIR/base/settings.json ~/.config/Code/User/settings.json;
}

update_shell() {
    # oh-my-zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
    # zplugin
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    # Need to logout for this to take effect
    sudo chsh -s /usr/bin/zsh "$USER" >/dev/null 2>&1;
}


main() {
    # Update, upgrade and install packages specified in $PACKAGES_FILE
    sudo apt update -y && sudo apt upgrade -y;
    xargs sudo apt install -y < $PACKAGES_FILE;
    vim_setup;

    mkdir -p $INSTALL_DIR;
    cd $INSTALL_DIR;
    software_install;

    if [[ "$ALL_FLAG" == 1 ]]; then
        poweruser_setup;
    fi

    update_shell;
    symlink_setup;

    echo "No errors. Hurray!";
    cd $REPO_DIR;
    exit 0;
}

main;
