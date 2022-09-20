#!/bin/zsh

DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.config

cp -r "${DIR}/.config" ~/

zsh "${DIR}/.config/zsh/setup.zsh"
zsh "${DIR}/git-setup/setup.zsh"
