#!/bin/zsh

#Copy the `.gitconfig` file in the root directory
#Copy the `gitcommands` directory in the `.config/` directory so `.gitconfig` will be able to find it.

DIR="$(cd "$(dirname "$0")" && pwd)"

cp "${DIR}/.gitconfig" ~/
cp -r "${DIR}/gitcommands" ~/.config
