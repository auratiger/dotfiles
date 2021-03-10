#!/bin/bash

setup_packages=(
    "git"
    "nodejs"
    "npm"
    "curl"
    "python3-pip"
    "default-jre"
    "gcc"
    "maven"
    "snapd"
    "cargo"
    "lua5.3" 
    "neofetch"
    "cmatrix"
    "gnome-tweaks"
    "fonts-firacode"
    "tmux"
)

files=(
    ".alacritty.yml"
    ".bashrc"
    ".bash_aliases"
    ".gitconfig"
    ".inputrc"
    ".tmux.conf"
)

package_manager="apt install -y"

function update() {
    apt update -y && apt upgrade -y && apt dist-upgrade -y
}

function backup_existing_files(){
    #make a backup of all files which
    #will be overriden from 'export_files'
    mkdir -p backups

    for i in "${files[@]}"
    do
        cp -v ${i} ./backups/ 2>/dev/null
        echo "$i was backed up successfully"
    done

    mkdir -p ./backups/
    cp -r ~/.config/nvim/ ./backups/ 2>/dev/null
}

function export_files(){

    for i in "${files[@]}"
    do
        cp -v ${i} ~/
    done

    mkdir -p ~/.config/nvim
    cp -vr nvim/* ~/.config/nvim/

}


function install_code_env(){
    for i in "${setup_packages[@]}"
    do
        ${package_manager} ${i}
        echo "$i"
    done
}

# update
backup_existing_files
#export_files
#install_code_env


