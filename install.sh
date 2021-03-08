#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
ORANGE=$(tput setaf 3)
WHITE=$(tput setaf 7)

declare -A osInfo;
osInfo[/etc/debian_version]="apt install -y"
osInfo[/etc/alpine-release]="apk --update add"
osInfo[/etc/centos-release]="yum install -y"
osInfo[/etc/fedora-release]="dnf install -y"
osInfo[/etc/lsb-release]="pacman -S"

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

function get_package_manager(){
    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            package_manager=${osInfo[$f]}
        fi
    done
}

function update() {
    (
        ( apt update -y && apt upgrade -y && apt dist-upgrade -y ) ||
        ( pacman -Syyu ) || 
        ( apk -U upgrade ) ||
        ( dnf upgrade ) ||
        ( yum update )
    )
}

function export_files(){
    cp -iv .alacritty.yml ~/
    cp -iv .bashrc ~/
    cp -iv .bash_aliases ~/
    cp -iv .gitconfig ~/
    cp -iv .inputrc ~/
    cp -iv .tmux.conf ~/

    mkdir -p ~/.config/nvim
    cp -ivr nvim/* ~/.config/nvim/

    mkdir -p ~/.config/nvim
    cp -ivr nvim/* ~/.config/nvim
}

function install_code_env(){
    for i in "${setup_packages[@]}"
    do
        ${package_manager} ${i}
        echo "$i"
    done
}

# checks which package manager to use for the specific distro
get_package_manager

while getopts fupeh flag
do
    case "${flag}" in
        f) echo "full install";;
        u)
            echo -n ${ORANGE}
            read -p "Are you sure you want to update?: " VAR
            echo -n ${WHITE}
            if [[ "${VAR,,}" == "y" ]]; then
                update
            fi;;
        p) 
            echo -n ${ORANGE}
            read -p "Are you sure you want to install all necessary packages?: " VAR
            echo -n ${WHITE}
            if [[ "${VAR,,}" == "y" ]]; then
                install_code_env
            fi;;
        e) 
            echo -n ${ORANGE}
            read -p "Are you sure you want to export the config files?: " VAR
            echo -n ${WHITE}
            if [[ "${VAR,,}" == "y" ]]; then
                export_files
            fi;;
        h) echo "help page";;
        *) 
            echo -n ${ORANGE}
            read -p "Are you sure you want to do a full setup?: " VAR
            echo -n ${WHITE}
            if [[ "${VAR,,}" == "y" ]]; then
                update
                install_code_env
                export_files
            fi;;
    esac
done
