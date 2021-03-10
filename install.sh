#!/bin/bash

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
ORANGE=$(tput setaf 3)
WHITE=$(tput setaf 7)

declare -A osInfo;
osInfo[/etc/debian_version]="./ubuntu_setup.sh"
osInfo[/etc/alpine-release]="./alpine_setup.sh"
osInfo[/etc/centos-release]="./centos_setup.sh"
osInfo[/etc/fedora-release]="./fedora_setup.sh"
osInfo[/etc/lsb-release]="./arch_setup.sh"

function get_distro(){
    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            distro=${osInfo[$f]}
        fi
    done
}

#chechs what distro is being used
get_distro

echo -n ${ORANGE}
read -p "Are you sure you want to procede with the instalation?: (y/n) " VAR
echo -n ${WHITE}
if [[ "${VAR,,}" == "y" ]]; then
    echo ${distro}
    eval "$distro"
fi
