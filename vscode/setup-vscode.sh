#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
   echo "##################################################################"
   echo "This script MUST NOT be run as root user since it makes changes"
   echo "to the \$HOME directory of the \$USER executing this script."
   echo "The \$HOME directory of the root user is, of course, '/root'."
   echo "We don't want to mess around in there. So run this script as a"
   echo "normal user. You will be asked for a sudo password when necessary."
   echo "##################################################################"
   exit 1
fi

error() {
   clear
   printf "ERROR:\\n%s\\n" "$1" >&2
   exit 1
}

welcome() {
   dialog --colors --title "\Z7\ZbInstalling and setting up vsCode" --msgbox "\Z4This is a script that will install vscode on your machine, regardless of your OS, and will setup the my default config files." 8 60

   dialog --colors --title "\Z7\ZbStay near you computer!" --yes-label "Continue" --no-label "Exit" --yesno "\Z4This script is not allowed to be run as root, but you will be asked to enter your sudo password at various points during this installation. This is the give the package manager the necessary permissions to install the softwar. So stay near the computer." 8 60
}

override_warning() {
   dialog --colors --title "\Z7\ZbOverride default configs" --yes-label "Continue" --no-label "Exit" --yesno "\Z4This is going to override vsCode's default settings, keybidnings and snippets files. Do you wish to continue?" 8 60 || error "User chose to exit"
}

installing_vscode_extentions() {
   dialog --colors --title "\Z7\ZbInstalling vsCode extentions" --yes-label "Continue" --no-label "Exit" --yesno "\Z4This is going to install all my needed vsCode extentions" 8 60 || error "User chose to exit"
}

if [ "$(uname)" == "Darwin" ]; then
   # Do something under Mac OS X platform
   brew install dialog

   welcome || error "User choose to exit"

   brew install --cask visual-studio-code || error "Could not install vscode"

   VSCODE_SETTINGS_PATH="$HOME/Library/Application\ Support/Code/User/"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
   # Do something under GNU/Linux platform
   VSCODE_SETTINGS_PATH="$HOME/.config/Code/User/settings.json"

   if [ -f /etc/debian_version ]; then
      sudo apt update && sudo apt upgrade -y

      sudo apt-get install -y dialog

      welcome || error "User choose to exit"

      sudo apt install software-properties-common apt-transport-https wget

      wget -q "https://packages.microsoft.com/keys/microsoft.asc" -O- | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

      sudo apt install code || error "Could not install vscode"
   elif [ -f /etc/lsb-release ]; then
      sudo pacman -S snapd
      sudo systemctl enable --now snapd.socket
      sudo ln -s /var/lib/snapd/snap /snap

      sudo snap install code --classic || error "Could not install vscode"
   else
      error || "not supported"
   fi
elif

   [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]
then
   # Do something under 32 bits Windows NT platform
   echo 'never gonna be supported'
   exit 1
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
   # Do something under 64 bits Windows NT platform
   echo 'never gonna be supported'
   # VSCODE_SETTINGS_PATH="%APPDATA%\Code\User\settings.json"
   exit 1
else
   echo "not supported"
   exit 1
fi

override_warning

cp -v ./settings.json ./keybidnings.json "$VSCODE_MAC_PATH"
yes | cp -Rv snippets/. "$VSCODE_MAC_PATH/snippets"

installing_vscode_extentions

extention_list=(
   "2gua.rainbow-brackets"
   "Angular.ng-template"
   "christian-kohler.npm-intellisense"
   "christian-kohler.path-intellisense"
   "dae.vscode-mac-color-picker"
   "Dart-Code.dart-code"
   "Dart-Code.flutter"
   "dbaeumer.vscode-eslint"
   "dsznajder.es7-react-js-snippets"
   "eamodio.gitlens"
   "EditorConfig.EditorConfig"
   "eg2.vscode-npm-script"
   "Equinusocio.vsc-community-material-theme"
   "Equinusocio.vsc-material-theme"
   "equinusocio.vsc-material-theme-icons"
   "esbenp.prettier-vscode"
   "formulahendry.auto-rename-tag"
   "foxundermoon.shell-format"
   "Fudge.auto-using"
   "infeng.vscode-react-typescript"
   "jasonnutter.search-node-modules"
   "jchannon.csharpextensions"
   "johnpapa.Angular2"
   "jorgeserrano.vscode-csharp-snippets"
   "k--kato.intellij-idea-keybindings"
   "leo-labs.dotnet"
   "mads-hartmann.bash-ide-vscode"
   "MellowMarshmallow.groovy"
   "ms-azuretools.vscode-docker"
   "ms-dotnettools.csharp"
   "ms-python.python"
   "ms-python.vscode-pylance"
   "ms-toolsai.jupyter"
   "ms-toolsai.jupyter-keymap"
   "ms-toolsai.jupyter-renderers"
   "ms-vscode-remote.remote-containers"
   "ms-vscode.cpptools"
   "msjsdiag.vscode-react-native"
   "planbcoding.vscode-react-refactor"
   "Remisa.shellman"
   "rogalmic.bash-debug"
   "streetsidesoftware.code-spell-checker"
   "timonwong.shellcheck"
   "VisualStudioExptTeam.vscodeintellicode"
   "vscode-icons-team.vscode-icons"
   "vscodevim.vim"
   "waderyan.nodejs-extension-pack"
   "WallabyJs.quokka-vscode"
   "xabikos.JavaScriptSnippets"
)

for i in "${extention_list[@]}"; do
   dialog --colors --title "\Z7\ZbInstalling extenttion" --msbox "\Z4Installing $i"
   code --install-extension "$i"
   clear
done
